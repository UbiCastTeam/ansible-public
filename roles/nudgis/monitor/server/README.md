# Monitor_server
## Description

The monitor_server group is used to configure the hosts to allow to access to monitoring data through a web interface (webmonitor).  
 * In a standard and HA Ubicast case, the host(s) is(are) the same as mediaserver  
 
 This group is only meant to be used as a meta group (see for instance meta groups section in the [standard example inventory](../../inventories/example/std/hosts) or [HA example inventory](../../inventories/example/ha/hosts)).

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`monitor_domain`: Defines the default domain for monitor
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

`ubicast_customer_name`: Short name of the customer, with no spaces. This name is used in munin to group the graphs under the same name.
```
ubicast_customer_name: "example"
```

`munin_nodes`: List of munin_nodes with their names and IP (each element of the list is a dictionary with a "name" and a "ip" key) (Optional)
```
munin_nodes: []
```
