# Celerity
## Description

The celerity group is used to configure the hosts that balance the transcoding tasks.  
 * In a standard UbiCast case, the host is the same as the mediaserver.
 * In a HA UbiCast case, the live is usually a dedicated server.

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`nudgis_front_system_user`: Nudgis system username for the application portal, used as a JSON key in celerity config for nudgis API usage (see also nudgis_front_api_key) (Optional)
```
nudgis_front_system_user: "msuser"
```

`nudgis_front_api_key`: Nudgis API key, used to communicate with the nudgis portal
```
nudgis_front_api_key: "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
```

`celerity_server_domain`: IP or domain on which the celerity server service can be joined
```
celerity_server_domain: "celerity.example.com"
```

`celerity_signing_key`: Secret key shared between celerity server and workers for communications (should be the same everywhere for communication)
```
celerity_signing_key: "changeit"
```
