# Proxy
## Description

Install and configure a mandatory proxy for several applications

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`proxy_http`: Proxy URL for HTTP calls (complete URL with protocol) (Optional)
```
proxy_http: ""
```

`proxy_https`: Proxy URL for HTTPS calls (complete URL with protocol) (Optional)
```
proxy_https: ""
```

`proxy_exclude`: List of non-local URL that does not use the proxy. "localhost" addresses are automatically added. (Optional)
```
proxy_exclude:
  - nudgis.example.com
  - manager.example.com
  - monitor.example.com
```
