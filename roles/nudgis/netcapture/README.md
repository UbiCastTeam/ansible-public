# Netcapture
## Description

The netcapture group is used to configure the server which will host UbiCast virtual recorders instances.

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

`netcapture_mm_ssl`: Activates the SSL verification when calling the Nudgis Manager (Optional)
```
netcapture_mm_ssl: true
```
