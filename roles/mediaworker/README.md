# Mediaworker
## Description

The mediaorker group is used to configure the hosts treat the transcoding tasks.  
 * In a standard UbiCast case, the host is a dedicated server
 * In a HA UbiCast case, it is usually a cluster of two (or more) dedicated servers

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`nudgis_front_domain`: URL of the default Nudgis "msuser" portal used to populate the /etc/celerity/config.py file
```
nudgis_front_domain: "nudgis.example.com"
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
