**Description**

This playbook is deploying and configuring `certbot` on every server that is publishing some UbiCast services through nginx. The configuration of the SSL certificates in nginx is also handled by this playbook.
This playbook is configuring certbot to generate Let's Encrypt SSL certificates **only** for UbiCast services (automatically discovered in the playbook).

**Prerequisites**

You should provide a working inventory (with defined `front`, `manager`, `cache` and `monitor_server` groups) when calling this playbook and the `letsencrypt_email` variable should be set as it will be used for the Let's Encrypt administrator account email address (See **Usage**).
You should also have working DNS entries and network access to the servers for Let's Encrypt to be able to generate the SSL certificates.

**Usage**

```bash
ansible-playbook -i inventories/<inventory> -e 'letsencrypt_email=<customer_admin_email>' playbooks/nudgis/letsencrypt/deploy.yml
```

**Note:** This playbook do not apply to High Availibity cases, it will fail before action if several hosts are in a group needing SSL certificates. For HA cases, a custom solution has to be implemented to generate and/or **synchronize** the certificates between servers publishing the same domain.
