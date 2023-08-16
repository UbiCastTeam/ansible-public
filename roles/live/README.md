# Live

The live group is used to configure all hosts that will process lives streams.  
 * In a standard Ubicast case, the host is the same as the mediaserver.
 * In a HA Ubicast case, the live is usually a cluster of two dedicated servers behind a loadbalancer VIP setup in active/backup.

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`live_ha`: Define if the deployment is an HA architecture (i.e. live domain is not handle by nudgis frontend server)
```
live_ha: False
```

`live_domain`: Domain name of the live cluster (only if distinct live server(s) from MediaServer and live_ha variable is set to True) (Optional)
```
live_domain: "live.example.com"
```

`live_tmpfs_size`: Size of the tmpfs storing the live chunks (unit g or m and only if distinct live server(s) from MediaServer) (Optional)
```
live_tmpfs_size: "2048m"
```
