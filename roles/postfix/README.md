# Postfix
## Description

Used by the "base" metagroup to provide emailing capabilities

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`postfix_admin`: Define the specified email address for the unix root account (in /etc/aliases)
```
postfix_admin: "admin@example.com"
```

`postfix_mailname`: Default sender domain, used to complete both postfix configuration and the /etc/mailname content
```
postfix_mailname: "domain.example.com"
```

`postfix_email_from`: Email address used by postfix to send emails
```
postfix_email_from: "noreply@{{ postfix_mailname }}"
```

`postfix_relay_host`: SMTP relay host (Optional)
```
postfix_relay_host: ""
```

`postfix_relay_pass`: User of the SMTP SASL account (Optional)
```
postfix_relay_pass: ""
```

`postfix_relay_user`: Password of the SMTP SASL account (Optional)
```
postfix_relay_user: ""
```
