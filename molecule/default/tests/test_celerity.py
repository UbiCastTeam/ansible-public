import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_celerity_is_installed(host):
    p = host.package("celerity-server")

    assert p.is_installed


def test_celerity_config(host):
    f = host.file("/etc/celerity/config.py")

    assert f.exists
    assert f.contains("SIGNING_KEY =")
    assert f.contains("MEDIASERVERS =")


def test_celerity_service(host):
    s = host.service("celerity-server")

    assert s.is_running
    assert s.is_enabled


def test_celerity_socket(host):
    s = host.socket("tcp://0.0.0.0:6200")

    assert s.is_listening
