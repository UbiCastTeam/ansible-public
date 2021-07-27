import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_apache2_is_installed(host):
    p = host.package("apache2")

    assert not p.is_installed


def test_nginx_is_installed(host):
    p = host.package("nginx")

    assert p.is_installed


def test_nginx_removed_default(host):
    f = host.file("/etc/nginx/sites-enabled/default.conf")

    assert not f.exists


def test_nginx_removed_old_ssl(host):
    f = host.file("/etc/nginx/conf.d/ssl.conf")

    assert not f.exists
