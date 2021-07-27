import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


# TODO: ubicast-mediaimport when released
def test_import_is_installed(host):
    p = host.package("ubicast-mediaimport")

    assert p.is_installed


def test_ftp_is_installed(host):
    p = host.package("pure-ftpd")

    assert p.is_installed


def test_ssh_is_installed(host):
    p = host.package("openssh-server")

    assert p.is_installed


def test_sftp_is_installed(host):
    p = host.package("mysecureshell")

    assert p.is_installed


def test_mediaimport_conf(host):
    f = host.file("/etc/mediaserver/mediaimport.json")

    assert f.exists


def test_mediaimport_service(host):
    s = host.service("mediaimport")

    assert s.is_running
    assert s.is_enabled


def test_ftp_service(host):
    s = host.service("pure-ftpd")

    assert s.is_running
    assert s.is_enabled


def test_sftp_service(host):
    s = host.service("mysecureshell")

    assert s.is_running
    assert s.is_enabled


def test_ftp_socket(host):
    s = host.socket("tcp://0.0.0.0:21")

    assert s.is_listening


def test_sftp_socket(host):
    s = host.socket("tcp://0.0.0.0:22")

    assert s.is_listening


def test_fail2ban_conf(host):
    f = host.file("/etc/fail2ban/jail.d/pure-ftpd.conf")

    assert f.exists


def test_fail2ban_service(host):
    s = host.service("fail2ban")

    assert s.is_running
