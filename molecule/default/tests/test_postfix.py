import os

import testinfra.utils.ansible_runner


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_postfix_is_installed(host):
    p = host.package("postfix")

    assert p.is_installed


def test_postfix_main(host):
    f = host.file("/etc/postfix/main.cf")

    assert f.exists


def test_mailname(host):
    f = host.file("/etc/mailname")

    assert f.exists


def test_aliases(host):
    f = host.file("/etc/aliases")

    assert f.exists
    assert f.contains("devnull:")
    assert f.contains("root:")


def test_postfix_virtual(host):
    f = host.file("/etc/postfix/virtual")

    assert f.exists
    assert f.contains("postmaster@")
    assert f.contains("bounces@")
    assert f.contains("noreply@")


def test_postfix_generic(host):
    f = host.file("/etc/postfix/generic")

    assert f.exists
    assert f.contains("root@")


def test_postfix_service(host):
    s = host.service("postfix")

    assert s.is_running
    assert s.is_enabled


def test_postfix_listen(host):
    s = host.socket("tcp://127.0.0.1:25")

    assert s.is_listening
