# Sysconfig

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`offline_mode`: Do not configure any repository and use local repository (Optional)
```
offline_mode: False
```

`repos_release`: Debian distribution short name (example: "bullseye") (Optional)
```
repos_release: "{{ ansible_distribution_release }}"
```

`repos_debian_prefix`: Prefix of the debian repositories, with the protocol (example: "http://"). Used when the apt-cacher-ng of the Nudgis Manager proxifies the debian repositories. (Optional)
```
repos_debian_prefix: "http://"
```

`init_locale`: Value for the system locale (Optional)
```
init_locale: "en_GB.UTF-8"
```

`ntp_servers`: List of NTP servers to use on the systems (Optional)
```
ntp_servers:
  - 0.debian.pool.ntp.org
  - 1.debian.pool.ntp.org
  - 2.debian.pool.ntp.org
  - 3.debian.pool.ntp.org
```

`repos_ubicast_packages_token`: Token used in the UbiCast debian repository URL
```
repos_ubicast_packages_token: "XXXX-XXXX-XXXX-XXXX-XXXX"
```

`repos_ubicast_packages_domain`: Domain of the UbiCast debian packages repository URL (Optional)
```
repos_ubicast_packages_domain: "manager.example.com"
```

`init_timezone`: Timezone to set on the servers (`timedatectl list-timezones` for the complete list) (Optional)
```
init_timezone: "Europe/Paris"
```

`repos_debian_packages_domain`: Domain to use for the Debian repositories (Optional)
```
repos_debian_packages_domain: "deb.debian.org"
```

`repos_debian_security_packages_domain`: Domain to use for the Debian security repositories (Optional)
```
repos_debian_security_packages_domain: "security.debian.org"
```
