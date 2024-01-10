# Netcapture
## Description

The netcapture group is used to configure the server which will host UbiCast virtual recorder instances.

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`netcapture_miris_user_pwd`: Password of the deployed netcapture miris API
```
netcapture_miris_user_pwd: "changeme"
```

`netcapture_mm_url`: URL of the mirismanager to use for packages
```
netcapture_mm_url: "mirismanager.example.com"
```

`netcapture_pkg_folder`: Folder used to store the packages (Optional)
```
netcapture_pkg_folder: "/data/netcapture/packages"
```

`netcapture_conf_folder`: Folder used to store the configurations (Optional)
```
netcapture_conf_folder: "/etc/miris/conf"
```

`netcapture_media_folder`: Folder used to store the medias (Optional)
```
netcapture_media_folder: "/data/netcapture/media"
```

`netcapture_mm_ssl`: Activates the SSL verification when calling the Nudgis Manager (Optional)
```
netcapture_mm_ssl: True
```

`netcapture_miris_auth`: Activates the authentication for the deployed netcapture miris API (Optional)
```
netcapture_miris_auth: True
```
