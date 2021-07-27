import os

import testinfra.utils.ansible_runner

# /!\ This test run accross all servers
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("postgres")


def test_psycopg2_is_installed(host):
    p = host.package("python3-psycopg2")

    assert p.is_installed


def test_postgres_is_installed(host):
    p = host.package("postgresql-11")

    assert p.is_installed
    assert p.version.startswith("11")


def test_postgres_user(host):
    u = host.user("postgres")

    assert u.name == "postgres"


def test_postgres_service(host):
    s = host.service("postgresql@11-main")

    assert s.is_running


def test_postgresql_socket(host):
    s = host.socket("tcp://127.0.0.1:5432")

    assert s.is_listening
