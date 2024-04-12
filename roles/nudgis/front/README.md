# Front
## Description

The front group is used to configure all hosts with the UbiCast platform to handle and to broadcast media.  
 * In a standard Ubicast case, the host is the same as other component (mirismanager, etc.)
 * In a HA Ubicast case, the mediaserver is usually a cluster of two (or more) dedicated servers behind a loadbalancer VIP setup in active/active

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`nudgis_front_email_from`: Defines the address for the Nudgis Front emails sender (Optional)
```
nudgis_front_email_from: "noreply@{{ nudgis_front_domain }}"
```

`nudgis_front_domain`: Defines the default deployed Nudgis portal domain (will be the URL of the portal when adding the HTTP(S) prefix)
```
nudgis_front_domain: "nudgis.example.com"
```

`manager_domain`: Defines the default deployed Nudgis portal linked mirismanager domain (correspond to the URL of the mirismanager portal when adding the HTTP(S) prefix) (Optional)
```
manager_domain: "manager.example.com"
```

`nudgis_front_api_key`: Defines the default deployed Nudgis portal master API key (Optional)
```
nudgis_front_api_key: "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
```

`nudgis_front_user_ubicast_password`: Defines the default deployed Nudgis portal "ubicast" user password (Optional)
```
nudgis_front_user_ubicast_password: "changeit"
```

`nudgis_front_user_admin_password`: Defines the default deployed Nudgis portal "admin" user password (Optional)
```
nudgis_front_user_admin_password: "changeit"
```

`celerity_server_domain`: IPv4 address used to join the celerity server
```
celerity_server_domain: "celerity.example.com"
```

`celerity_signing_key`: Key used to encrypt communications to and from celerity server
```
celerity_signing_key: "changeit"
```

`nudgis_front_database_domain`: Domain to reach PostgreSQL database
```
nudgis_front_database_domain: "database.nudgis.example.com"
```

`nudgis_front_database_port`: Port to reach PostgreSQL database
```
nudgis_front_database_port: "5432"
```

`nudgis_front_database_password`: Port to connect to PostgreSQL database with superuser rights
```
nudgis_front_database_password: "changeit"
```

`offline_mode`: Do not configure UbiCast web accesses in the solution (Optional)
```
offline_mode: false
```
