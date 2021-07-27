import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_manager_is_installed(host):
    p = host.package("ubicast-skyreach")

    assert p.is_installed


def test_manager_user(host):
    u = host.user("skyreach")

    assert u.name == "skyreach"


def test_manager_nginx(host):
    f = host.file("/etc/nginx/sites-available/skyreach.conf")

    assert f.exists


def test_manager_service(host):
    s = host.service("skyreach")

    assert s.is_running
    assert s.is_enabled


def test_manager_socket(host):
    s = host.socket("tcp://0.0.0.0:443")

    assert s.is_listening


def test_fail2ban_conf(host):
    f = host.file("/etc/fail2ban/jail.d/skyreach.conf")

    assert f.exists


def test_fail2ban_service(host):
    s = host.service("fail2ban")

    assert s.is_running


def test_postfix_service(host):
    s = host.service("postfix")

    assert s.is_running
