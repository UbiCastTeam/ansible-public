import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_ntp_is_installed(host):
    p = host.package("ntp")

    assert p.is_installed


def test_systemd_timesyncd_override(host):
    f = host.file(
        "/lib/systemd/system/systemd-timesyncd.service.d/disable-with-time-daemon.conf"
    )

    assert f.exists
    assert f.contains("[Unit]")
    assert f.contains("ConditionFileIsExecutable=!")


def test_systemd_timesyncd_disabled(host):
    s = host.service("systemd-timesyncd")

    assert not s.is_running
    assert not s.is_enabled


def test_ntp_service(host):
    s = host.service("ntp")

    assert s.is_running
    assert s.is_enabled
