import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_rsync_is_installed(host):
    p = host.package("rsync")

    assert p.is_installed


def test_rsync_tmbackup_is_installed(host):
    r = host.file("/usr/bin/rsync_tmbackup")

    assert r.exists
