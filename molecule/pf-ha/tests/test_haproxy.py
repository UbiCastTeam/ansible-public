import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("mediaserver")


def test_psycopg2_is_installed(host):
    p = host.package("haproxy")

    assert p.is_installed


def test_postgres_service(host):
    s = host.service("haproxy")

    assert s.is_running


def test_haproxy_socket(host):
    s = host.socket("tcp://0.0.0.0:54321")

    assert s.is_listening
