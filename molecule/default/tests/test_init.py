import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_apt_source_skyreach_file(host):
    f = host.file("/etc/apt/sources.list.d/ubicast.list")

    assert f.exists
    assert f.is_file
    assert f.user == "root"
    assert f.group == "root"
    assert f.contains("deb http")


def test_requests_is_installed(host):
    p = host.package("python3-requests")

    assert p.is_installed
    assert p.version.startswith("2.")


def test_locale_file(host):
    f = host.file("/etc/default/locale")

    assert f.exists
    assert f.is_file
    assert f.user == "root"
    assert f.group == "root"
    assert f.contains("LANGUAGE=")


def test_ubicast_user(host):
    u = host.user("ubicast")

    assert u.name == "ubicast"
    assert u.home == "/home/ubicast"
    assert "sudo" in u.groups
    assert u.expiration_date is None


def test_bashrc_file(host):
    f = host.file("/root/.bashrc")

    assert f.exists


def test_vimrc_file(host):
    f = host.file("/root/.vimrc")

    assert f.exists


def test_authorized_keys_file(host):
    f = host.file("/root/.ssh/authorized_keys")

    assert f.exists
    assert f.is_file
    assert f.user == "root"
    assert f.group == "root"
    assert f.contains(
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCr2IJlzvLlLxa2PyGhydAlz/PAOj240g8anQmY5"
        "8X+llirLHIOlkdJXBqf94jAeZkweWpoE41RdmKPUQEz4pCO09dGJaZD4lv1NtDhrhNwTmoOnyFcko"
        "PimR6DX6+UMM9wUmfti/ytljbVEVVo/pRacXmczeumDaci3uYTURyliuAR9h3zbIMQ6D2COESXjpt"
        "WmEwawE9grsTfJi84Q+XIBPvXRHjjceB5hejUMWuf7xc6GH9WIo5REh3qTUvgtxHtIGLQ3ImOzrbC"
        "sEhENrBWds0qH0pIuH0lykWGR6pumpPxLzXcVho+e/UJgUrEg5u6/58aizqJTkxFJMa8ciYz "
        "support@ubicast"
    )


def test_journal_file(host):
    f = host.file("/var/log/journal")

    assert f.exists
    assert f.is_directory
