# Localisation
## Description

The group handles the installation and configuration of locales

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`init_locale`: Value for the system locale (Optional)
```
init_locale: "en_GB.UTF-8"
```

`init_timezone`: Timezone to set on the servers (`timedatectl list-timezones` for the complete list) (Optional)
```
init_timezone: "Europe/Paris"
```
