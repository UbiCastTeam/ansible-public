import os

import testinfra.utils.ansible_runner

# This test run accross all servers
hosts = testinfra.utils.ansible_runner.AnsibleRunner(os.environ["MOLECULE_INVENTORY_FILE"]).get_hosts("postgres")
testinfra_hosts = [i for i in hosts if i.startswith('db0')]


def test_postgresql_create_db(host):
    ''' check if we can only create db on the primary node of the cluster '''

    s = host.ansible("postgresql_db", "name=test", become=True, check=False, become_user='postgres')
    assert s["changed"]


def test_postgresql_create_table(host):
    ''' check if we can only create a table on the primary node of the cluster '''

    s = host.ansible("postgresql_query", "db=test query='CREATE TABLE test_ha (id SERIAL PRIMARY KEY, name VARCHAR(100) );'", become=True, check=False, become_user='postgres')
    assert s["changed"]


def test_postgresql_insert(host):
    ''' check if we can only write to the primary node of the cluster '''

    s = host.ansible("postgresql_query", "db=test query='INSERT INTO test_ha (name) VALUES (\'test\');'", become=True, check=False, become_user='postgres')
    assert s["changed"]
