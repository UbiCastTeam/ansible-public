# Letsencrypt
## Description

Install and configure Let's Encrypt tools to generate and maintain Let's Encrypt SSL certificates for the webdomains.  
 The role is generating a multi-domains SSL certificate with the first domain in the list as the main one and others as alternative names.  
 For usage instructions take a look at [the playbook](../../../playbooks/nudgis/letsencrypt).

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`letsencrypt_domains`: List the domain to configure with a let's encrypt certificate (Optional)
```
letsencrypt_domains: []
```

`letsencrypt_email`: Email of the Let's Encrypt SSL certificates administrator(s)
```
letsencrypt_email: "admin@example.com"
```
