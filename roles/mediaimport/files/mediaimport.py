#!/usr/bin/env python3

import argparse
import crypt
import shutil
import subprocess

BASE_DIR = "/home/ftp/storage"
INCOMING_DIR = BASE_DIR + "/incoming"
WATCH_DIR = BASE_DIR + "/watchfolder"


def main():
    commands = MediaImport()

    parser = argparse.ArgumentParser(prog="mediaimport", description=commands.__doc__)
    subparsers = parser.add_subparsers(title="available commands", dest="command")
    subparsers.required = True

    # add command and arguments
    parser_add = subparsers.add_parser("add", help=commands.add_user.__doc__)
    parser_add.add_argument(
        "-u",
        "--user",
        help="username",
        action="store",
        type=commands._new_user,
        required=True,
    )
    parser_add.add_argument(
        "-p", "--passwd", help="password", action="store", type=str, required=True
    )
    parser_add.add_argument(
        "-y", "--yes", action="store_true", help="do not prompt for confirmation"
    )
    parser_add.set_defaults(func=commands.add_user)

    # delete command and arguments
    parser_del = subparsers.add_parser("delete", help=commands.del_user.__doc__)
    parser_del.add_argument(
        "-u",
        "--user",
        help="username",
        action="store",
        type=commands._user,
        required=True,
    )
    parser_del.add_argument(
        "-y", "--yes", action="store_true", help="do not prompt for confirmation"
    )
    parser_del.set_defaults(func=commands.del_user)

    # list command and arguments
    parser_list = subparsers.add_parser("list", help=commands.list_users.__doc__)
    parser_list.set_defaults(func=commands.list_users)

    # parse and run
    args = parser.parse_args()
    args.func(args)


class MediaImport:
    """Manage mediaimport users."""

    def __init__(self):
        self.users = self._get_users()

    def _get_users(self) -> list:
        """Get mysecureshell users list."""

        with open("/etc/passwd") as fh:
            passwd = fh.readlines()

        return sorted(
            [
                u.split(":")[0]
                for u in passwd
                if u.split(":")[-1].strip() == "/usr/bin/mysecureshell"
            ]
        )

    def _confirm(self, message: str = None):
        """Ask for confirmation."""

        if message:
            print(message)
        choice = input("Do you want to continue [y/N]? ").lower()

        if choice not in ["y", "yes"]:
            print("Exit.")
            exit(0)

    def _new_user(self, value: str) -> str:
        """Check that username does not exist."""

        if value in self.users:
            raise argparse.ArgumentTypeError(f"{value} already exists")

        return value

    def _user(self, value: str) -> str:
        """Check that username exists."""

        if value not in self.users:
            raise argparse.ArgumentTypeError(f"{value} does not exists")

        return value

    def add_user(self, args: argparse.Namespace):
        """add an user"""

        username = args.user
        password = args.passwd

        if not args.yes:
            self._confirm(f"MediaImport user '{username}' will be created.")

        # create user
        subprocess.Popen(
            [
                "useradd",
                "-b",
                INCOMING_DIR,
                "-m",
                "-p",
                crypt.crypt(password),
                "-s",
                "/usr/bin/mysecureshell",
                "-U",
                username,
            ],
            stdout=subprocess.DEVNULL,
        )
        print(f"User {username} created, adjust /etc/mediaserver/mediaimport.json and restart the service:\nsystemctl restart mediaimport")

    def del_user(self, args: argparse.Namespace):
        """delete an user"""

        username = args.user
        paths = [f"{INCOMING_DIR}/{username}", f"{WATCH_DIR}/{username}"]

        if not args.yes:
            self._confirm(f"MediaImport user '{username}' data will be deleted.")

        # remove user
        subprocess.Popen(
            ["userdel", "-f", "-r", username],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )

        # remove user's folders
        for path in paths:
            shutil.rmtree(path, ignore_errors=True)
        print(f"User {username} deleted, adjust /etc/mediaserver/mediaimport.json and restart the service:\nsystemctl restart mediaimport")

    def list_users(self, args: argparse.Namespace):
        """list existing users"""

        if len(self.users):
            print("\n".join(self.users))


if __name__ == "__main__":
    main()
