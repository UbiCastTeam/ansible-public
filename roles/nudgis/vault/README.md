# Vault
## Description

The vault group is used to configure the hosts with the UbiCast backup solution 

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`vault_email_enabled`: Boolean to activate the mail notifications (Optional)
```
vault_email_enabled: true
```

`vault_email_from`: From fields for email sending (as defined in RFC2822) (Optional)
```
vault_email_from: "{{ ansible_facts['fqdn'] }} <backup@{{ ansible_facts['fqdn'] }}>"
```

`vault_email_to`: Destination address for the Nudgis Vault emails (Optional)
```
vault_email_to: "noreply@example.com"
```
