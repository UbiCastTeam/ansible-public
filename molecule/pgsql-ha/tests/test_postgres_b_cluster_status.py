import os

import testinfra.utils.ansible_runner

import commons

# This test run accross all servers
testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(os.environ["MOLECULE_INVENTORY_FILE"]).get_hosts("postgres")


def test_postgresql_check_repmgr_status(host):
    ''' check if repmgr is working correctly on each node'''

    if host.ansible.get_variables()["inventory_hostname"].startswith("db0"):
        data = commons.get_status(host)
        assert data == "primary"
    if host.ansible.get_variables()["inventory_hostname"].startswith("db1"):
        data = commons.get_status(host)
        assert data == "standby"
    if host.ansible.get_variables()["inventory_hostname"].startswith("db2"):
        data = commons.get_status(host)
        assert data == "witness"
