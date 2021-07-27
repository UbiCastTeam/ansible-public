import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_munin_is_installed(host):
    p = host.package("munin-node")

    assert p.is_installed


def test_monitor_is_installed(host):
    p = host.package("ubicast-monitor")

    assert p.is_installed


def test_monitor_runtime_is_installed(host):
    p = host.package("ubicast-monitor-runtime")

    assert p.is_installed


def test_monitor_user(host):
    u = host.user("msmonitor")

    assert u.name == "msmonitor"


def test_monitor_nginx(host):
    f = host.file("/etc/nginx/sites-available/msmonitor.conf")

    assert f.exists


def test_monitor_service(host):
    s = host.service("msmonitor")

    assert s.is_running
    assert s.is_enabled


def test_monitor_socket(host):
    s = host.socket("tcp://0.0.0.0:443")

    assert s.is_listening


def test_fail2ban_conf(host):
    f = host.file("/etc/fail2ban/jail.d/monitor.conf")

    assert f.exists


def test_fail2ban_service(host):
    s = host.service("fail2ban")

    assert s.is_running
