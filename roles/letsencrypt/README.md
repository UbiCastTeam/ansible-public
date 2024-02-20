# Letsencrypt
## Description

Install and configure Let's Encrypt tools to generate and maintain Let's Encrypt SSL certificates for the webdomains

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`letsencrypt_domains`: List the domain to configure with a let's encrypt certificate. If an empty list is provided, every domain found in nginx is configured. (Optional)
```
letsencrypt_domains: []
```

`letsencrypt_email`: Email of the Let's Encrypt SSL certificates administrator(s)
```
letsencrypt_email: "admin@example.com"
```

`letsencrypt_webroot`: Default Let's Encrypt web root folder for challenges publication (Optional)
```
letsencrypt_webroot: "/var/www/letsencrypt"
```
