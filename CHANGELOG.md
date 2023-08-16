* Remove unused `server_live_host` variable
* Remove unnecessary `manager_default_email_sender` variable
* Replace `skyreach_activation_key` and `skyreach_system_key` with `ubicast_api_key`
* Remove `conf_debug` variable and task
* Remove unnecessary `letsencrypt_testing` variable
* Set `netcapture_mm_url` to a default value
* Set `init_locale` to a default value
* Set `init_timezone` to a default value
* Move `postfix_packages` from default to vars directory
* Remove unused `cockpit` firewall rule
* Move roles firewall rules from default to vars directory
* Move munin nodes firewall rules from sysconfig to munin-node
* Define package variable in vars directory where missing (mediaworker, msmonitor, munin-node, munin-server)
* Remove unnecessary `postfix_default_email_sender` variable
* Change default `celerity_server` value
* Change default `letsencrypt_email` value
* Rework celerity server and worker defaults variables to use nudgis frontend one
* Rename `repos_skyreach_*` variables to `repos_ubicast_*`
* Set `proxy_*` to a default value
* Set `ntp_servers` to a default value
* Remove unused `manager_testing` variable
* Rename `manager_hostname` variable to `manager_domain`
* Rename `server_*` variables to `nudgis_front_*`
* Remove unnecessary `server_instances` variable
* Rename `tmpfs_size` to `live_tmpfs_size`
* Rename `f2b_` varibales to `fail2ban_`

# TODO : add cache  
