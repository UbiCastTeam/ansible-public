# Manager
## Description

The manager group is used to configure all hosts with the UbiCast platform to control and manage video recorders.  
 * In a standard Ubicast case, the host is the same as mediaserver
 * In a HA Ubicast case, it is usually a dedicated server

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`manager_domain`: Defines the default domain for the Nudgis Manager
```
manager_domain: "manager.example.com"
```

`manager_email_from`: Defines the default address for the Nudgis Manager emails sender (Optional)
```
manager_email_from: "noreply@{{ manager_domain }}"
```

`manager_database_domain`: Domain to reach PostgreSQL database
```
manager_database_domain: "database.manager.example.com"
```

`manager_database_port`: Port to reach PostgreSQL database
```
manager_database_port: "5432"
```

`manager_database_password`: Port to connect to PostgreSQL database with superuser rights (Optional)
```
manager_database_password: "changeit"
```

`manager_user_ubicast_password`: Application ubicast user password
```
manager_user_ubicast_password: "changeit"
```

`manager_user_admin_password`: Application admin user password
```
manager_user_admin_password: "changeit"
```

`offline_mode`: Do not configure UbiCast web accesses in the solution (Optional)
```
offline_mode: false
```
