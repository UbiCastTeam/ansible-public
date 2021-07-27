import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_celerity_is_installed(host):
    p = host.package("celerity-workers")

    assert p.is_installed


def test_celerity_config(host):
    f = host.file("/etc/celerity/config.py")

    assert f.exists
    assert f.contains("SIGNING_KEY =")
    assert f.contains("SERVER_URL =")
    assert f.contains("QUEUES_PER_WORKER =")


def test_celerity_service(host):
    s = host.service("celerity-workers")

    assert s.is_running
    assert s.is_enabled
