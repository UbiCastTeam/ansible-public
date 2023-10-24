# Mediacache
## Description

The cache group is used to configure all hosts that will server as a proxy cache of live and/or vod.

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`cache_domain`: URL of the Nudgis Cache vhost (Optional)
```
cache_domain: "cache.example.com"
```

`nudgis_front_domain`: URL of Nudgis Front cluster
```
nudgis_front_domain: "nudgis.example.com"
```

`live_domain`: URL of the Nudgis Live cluster (Optional)
```
live_domain: "live.example.com"
```

`cache_vod_folder`: Path of the folder to cache the VOD service data (Optional)
```
cache_vod_folder: "/var/cache/nginx/mediacache-vod"
```

`cache_vod_size`: Max size allowed for the VOD service data (Optional)
```
cache_vod_size: "1"
```

`cache_live_folder`: Path of the folder to cache the Live service data (Optional)
```
cache_live_folder: "/var/cache/nginx/mediacache-live"
```

`cache_live_size`: Max size allowed for the Live service data (Optional)
```
cache_live_size: "1"
```
