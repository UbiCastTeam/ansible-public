# Fail2ban
## Description

Used by the "base" metagroup to provide and configure ban capabilities for various services

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`fail2ban_ignoreip`: IP addresses exceptions (no monitored by fail2ban) (Optional)
```
fail2ban_ignoreip: "127.0.0.1/8 ::1"
```

`fail2ban_maxretry`: Number of acceptable failures before banning an IP (Optional)
```
fail2ban_maxretry: "5"
```

`fail2ban_bantime`: Duration of bans (Optional)
```
fail2ban_bantime: "10m"
```

`fail2ban_email_from`: Email sender of the fail2ban reports (Optional)
```
fail2ban_email_from: "root@localhost"
```

`fail2ban_email_to`: Email reciepient of the fail2ban reports (Optional)
```
fail2ban_email_to: "noreply@example.com"
```

`fail2ban_action`: Define the default action to do when a ban occurs ("action_mwl" to send whois and logs via email or "action_" for default) (Optional)
```
fail2ban_action: "action_mwl"
```
