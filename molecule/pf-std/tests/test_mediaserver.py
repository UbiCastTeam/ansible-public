import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("mediaserver")


def test_server_is_installed(host):
    p = host.package("ubicast-mediaserver")

    assert p.is_installed


def test_server_user(host):
    u = host.user("msuser")

    assert u.name == "msuser"


def test_server_nginx(host):
    f = host.file("/etc/nginx/sites-available/mediaserver-msuser.conf")

    assert f.exists


def test_server_service(host):
    s = host.service("mediaserver")

    assert s.is_running
    assert s.is_enabled


def test_server_socket(host):
    s = host.socket("tcp://0.0.0.0:443")

    assert s.is_listening


def test_fail2ban_conf(host):
    f = host.file("/etc/fail2ban/jail.d/mediaserver.conf")

    assert f.exists


def test_fail2ban_service(host):
    s = host.service("fail2ban")

    assert s.is_running
