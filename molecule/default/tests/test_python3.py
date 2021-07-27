import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_python3_is_installed(host):
    p = host.package("python3")

    assert p.is_installed
    assert p.version.startswith("3.")
