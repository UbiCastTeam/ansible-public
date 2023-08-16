# Nginx

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`nginx_ssl_certificate`: Path of the SSL certificate for nginx configuration (Optional)
```
nginx_ssl_certificate: "/etc/ssl/certs/ssl-cert-snakeoil.pem"
```

`nginx_ssl_certificate_key`: Path of the SSL key for nginx configuration (Optional)
```
nginx_ssl_certificate_key: "/etc/ssl/private/ssl-cert-snakeoil.key"
```

`nginx_real_ip_from`: IPv4 address of the reverse-proxy or loadbalancer above the server(s) (Optional)
```
nginx_real_ip_from: ""
```
