# Mediavault

The mediaserver group is used to configure all hosts with the UbiCast backup solution 

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`vault_email_enabled`: Boolean to activate the mail notifications (Optional)
```
vault_email_enabled: True
```

`vault_email_from`: From fields for email sending (as defined in RFC2822) (Optional)
```
vault_email_from: "{{ ansible_fqdn }} <backup@{{ ansible_fqdn }}>"
```

`vault_email_to`: Destination address for the Nudgis Vault emails (Optional)
```
vault_email_to: "noreply@example.com"
```
