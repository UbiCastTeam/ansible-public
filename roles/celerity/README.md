# Celerity
## Description

The celerity group is used to configure the hosts that balance the transcoding tasks.  
 * In a standard UbiCast case, the host is the same as the mediaserver.
 * In a HA UbiCast case, the live is usually a dedicated server.

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`nudgis_front_api_key`: Nudgis API key, used to communicate with the nudgis portal
```
nudgis_front_api_key: "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
```

`nudgis_front_domain`: Defines the default deployed Nudgis portal domain (will be the URL of the portal when adding the HTTP(S) prefix)
```
nudgis_front_domain: "nudgis.example.com"
```

`celerity_server_domain`: IP or domain on which the celerity server service can be joined
```
celerity_server_domain: "celerity.example.com"
```

`celerity_signing_key`: Secret key shared between celerity server and workers for communications (should be the same everywhere for communication)
```
celerity_signing_key: "changeit"
```
