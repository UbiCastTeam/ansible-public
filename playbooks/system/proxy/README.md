# Proxy
## Description

Install and configure a mandatory proxy for the system (`/etc/environment`), but also for `apt`, `apt-cacher-ng`, `wget` and `git` if installed

## Playbook variables

This playbook makes use of the following variables.

`proxy_http`: Proxy URL for HTTP calls (full URL, protocol included)
```
proxy_http: "http://proxy.url"
```

`proxy_https`: Proxy URL for HTTPS calls (full URL, protocol included)
```
proxy_https: "https://proxy.url"
```

`proxy_exclude`: Additional URLs that does not use the proxy. `localhost` domains (ipv4 and ipv6) are already added in the list by the playbook.
```
proxy_exclude:
  - nudgis.url
  - manager.url
  - monitor.url
```

## Usage

Example of usage with everything in the ansible call (executed at `ansible-playbook` root).
```bash
ansible-playbook \
    -i "inventory/path" \
    -e '{ "proxy_http": "http://proxy.url" }' \
    -e '{ "proxy_https": "https://proxy.url" }' \
    -e '{ "proxy_exclude": [ "nudgis.url", "manager.url", "monitor.url" ] }' \
    playbooks/system/proxy/deploy.yml
```

**Note:** For better readability and reusability, it is best to put the variables directly in the ansible inventory.
