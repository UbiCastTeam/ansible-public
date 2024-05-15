# Repository
## Description

The group handles the installation and configuration of debian and ubicast repositories

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`offline_mode`: Do not configure any repository and use local repository (Optional)
```
offline_mode: false
```

`repos_debian_prefix`: Prefix of the debian repositories, with the protocol (example: "http://"). Used when the apt-cacher-ng of the Nudgis Manager proxifies the debian repositories. (Optional)
```
repos_debian_prefix: "http://"
```

`repos_ubicast_packages_token`: Token used in the UbiCast debian repository URL
```
repos_ubicast_packages_token: "XXXX-XXXX-XXXX-XXXX-XXXX"
```

`repos_ubicast_packages_domain`: Domain of the UbiCast debian packages repository URL (Optional)
```
repos_ubicast_packages_domain: "manager.example.com"
```

`repos_ubicast_trusted`: Check the UbiCast apt repository SSL certificate (if "true" the repository is trusted and there is no verification)
```
repos_ubicast_trusted: false
```

`repos_debian_packages_domain`: Domain to use for the Debian repositories (Optional)
```
repos_debian_packages_domain: "deb.debian.org"
```

`repos_debian_security_packages_domain`: Domain to use for the Debian security repositories (Optional)
```
repos_debian_security_packages_domain: "security.debian.org"
```

`repos_debian_trusted`: Check the Debian apt repository SSL certificate (if "true" the repository is trusted and there is no verification)
```
repos_debian_trusted: false
```
