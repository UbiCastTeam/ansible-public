import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_netcapture_is_installed(host):
    p = host.package("python3-miris-netcapture")

    assert p.is_installed


def test_docker_is_installed(host):
    p = host.package("docker-ce")

    assert p.is_installed


def test_netcapture_conf(host):
    f = host.file("/etc/miris/netcapture.json")

    assert f.exists


def test_miris_api_conf(host):
    f = host.file("/etc/miris/conf/api.json")

    assert f.exists


def test_docker_service(host):
    s = host.service("docker")

    assert s.is_running
    assert s.is_enabled
