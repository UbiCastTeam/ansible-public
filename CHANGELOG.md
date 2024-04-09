# 2024-03-20

Update nftables FTP rules to allow passive FTP for Nudgis Import.

# 2024-03-14

Update of the `letsencrypt` role and playbook to be more independant from the reste of the deployment.
See the [Let's Encrypt playbook README](./playbooks/nudgis/letsencrypt/README.md) for more informations.

# 2024-02-22

* Improve and revamp the roles and playbooks tree and names for more clarity
* Generalization of group names for more clarity and robusteness in the futur

The following inventory group name transition rules apply :

Old group name | New group name
---------------|-----------------
sysconfig | config
sysuser | user
mediaserver | front
mediacache | cache
mirismanager | manager
mediaimport | import
mediavault | vault
celerity | task_management_server
worker | task_management_client
munin_node | monitor_client
webmonitor | monitor_server

**Note:** See inventory examples and roles documentations for details on how to adapt to the new structure

System configuration roles are no longer forced. It is possible to avoid the configuration of these elements from the `site.yml` playbook. 
For example, if you don't want to configure `ntp`, just comment out the `import_playbook: system/ntp/deploy.yml` line in `site.yml`.

# 2024-02-16

* Rework roles in 3 distinct stages. Stages can be used with the ansible tags of the same name.
  * `install` for package installations,
  * `base` for basic configuration (without variable),
  * `configure` for case specific configurations.  
* Remove some unused variables in roles.
* Migrate variables from roles `defaults` to `vars`.
* Add variables to `munin_server` and `munin_node` roles to allow a standalone installation of the roles.
* Add documentation for ansible `vars` and `default`.

# 2024-02-15

* Remove obsolete `DATA_DIRS` configuration in Nudgis Front configuration template
* Add `MSCONTROLLER_LOCKS_DIR` configuration in Nudgis Front configuration template (use the `nudgis_front_instances_dir` value as default value)

# 2024-01-24

* Changing the firewall solution from `ferm`/`iptables` to `nftables`.

# 2023-10-23

* Remove benchmark solution deployment.

# 2023-10-20

* Avoid multiple `base` role execution.  
Now you have to create a meta group `[base:children]` containing all defined groups (`mediaserver`, `mirismanager`, ... see example inventories).

# 2023-10-18

* Ansible installation documentation has been enhanced.  
Makefile has been removed in favor of the more complete `ansible` and `ansible-playbook` default commands.

# 2023-08-16

* Many changes have been made with the arrival of debian 12.  
Variables have been completely restructured.

To help you make the transition : 
* [Documentations has been added for each role](https://git.ubicast.net/sys/ansible-public/-/tree/stable/roles) 
it contains an exhaustive list of variables that can be specified
* [Example inventories are also available in the repository](https://git.ubicast.net/sys/ansible-public/-/tree/stable/inventories/example)

### Remove

* Remove `conf` role
* Remove unused `server_live_host` variable
* Remove unused `manager_testing` variable
* Remove unused `cockpit` firewall rule
* Remove unnecessary `manager_default_email_sender` variable
* Remove unnecessary `postfix_default_email_sender` variable
* Remove unnecessary `server_instances` variable
* Remove unnecessary `letsencrypt_testing` variable
* Remove unnecessary `envsetup_*` variable
* Remove all mediaimport variables (deployed with an empty configuration)

### Rename or replace

Variables have been renamed to be consistent across roles. 
For instance, the mirismanager domain name is now called `manager_domain` across all roles where it is used.  
Variables have been renamed for better clarity (for instance `server_hostname` become `nudgis_front_domain`)

### Additions

* Add `tester_tests_ignored` variables to configure ubicast-tester ignored tests list
* All variables from the `/root/envsetup/conf.sh` and `/root/envsetup/auto-generated-conf.sh` should now be configured in the ansible inventory. The following transition rules apply:

`*-conf.sh` value | Ansible value
--------------|---------------
CELERITY_SERVER | celerity_server_domain
CELERITY_SIGNING_KEY | celerity_signing_key
CM_ADMIN_PWD | manager_user_admin_password
CM_SERVER_NAME | manager_domain
CM_SUPERUSER_PWD | manager_user_ubicast_password
DB_HOST | nudgis_front_database_domain
DB_PG_ROOT_PWD | nudgis_front_database_password, mirismanager_database_password, database_password
DB_PORT | nudgis_front_database_port
EMAIL_ADMINS | tester_email_admin
EMAIL_SMTP_PWD | postfix_relay_pass
EMAIL_SMTP_SERVER | postfix_relay_host
EMAIL_SMTP_USER | postfix_relay_user
MONITOR_ADMIN_PWD | monitor_user_admin_password
MONITOR_SERVER_NAME | monitor_domain
MONITOR_SUPERUSER_PWD | monitor_user_ubicast_password
MS_ADMIN_PWD | nudgis_front_user_admin_password
MS_API_KEY | nudgis_front_api_key
MS_ID | nudgis_front_system_user (see **Note 1** below)
MS_SECRET | nudgis_front_secret
MS_SERVER_NAME | nudgis_front_domain
MS_SUPERUSER_PWD | nudgis_front_user_ubicast_password
NTP_SERVER | ntp_servers
PROXY_EXCLUDE | proxy_exclude
PROXY_HTTP | proxy_http
PROXY_HTTPS | proxy_https
SERIAL_NUMBER | tester_system_name
SHELL_ADMIN_PWD | admin_password
SHELL_UBICAST_PWD | ubicast_password
SKYREACH_API_KEY | ubicast_api_key
SKYREACH_APT_TOKEN | repos_ubicast_packages_token

**Note 1:** For `nudgis_front_system_user` ansible value, keep only the first part of `MS_ID` value (before the `_`)  
**Note 2:** [See roles `README.md`](https://git.ubicast.net/sys/ansible-public/-/tree/stable/roles)  for more informations on the ansible variables.

### Roles default value

All variables have now a default value (for example `init_locale` is set to `en_GB.UTF-8`).  
The values of some variables have been updated.

### Move role

* Move all role's package variable from `default` to `vars` directory and add it when missing (mediaworker, msmonitor, munin-node, munin-server)
* Move all role's firewall rules from `default` to `vars` directory
* Move all haproxy role configuration from `default` to a template

