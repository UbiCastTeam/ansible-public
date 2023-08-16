# Msmonitor

The msmonitor group is used to configure all hosts to allow to access to monitoring data through a secure web interface.  
 * In a standard and HA Ubicast case, the host(s) is(are) the same as mediaserver

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`monitor_domain`: Defines the default domain for monitor (Optional)
```
monitor_domain: "monitor.example.com"
```

`monitor_user_ubicast_password`: Password for the webmonitor ubicast user (Optional)
```
monitor_user_ubicast_password: "changeit"
```

`monitor_user_admin_password`: Password for the webmonitor admin user (Optional)
```
monitor_user_admin_password: "changeit"
```
