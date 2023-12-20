# Tester
## Description

The tester group is used to configure all hosts with the UbiCast tester solution  
 * In a standard and HA Ubicast case, the hosts are all those that compose the UbiCast platform  
 
 This group is only meant to be used as a meta group (see for instance meta groups section in the [standard example inventory](../../inventories/example/std/hosts) or [HA example inventory](../../inventories/example/ha/hosts)).

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`tester_system_name`: Name of the system in the reports (Optional)
```
tester_system_name: "{{ inventory_hostname }}"
```

`repos_ubicast_packages_token`: UbiCast repository token used to make API call to mirismanager.ubicast.net to retrieve system informations
```
repos_ubicast_packages_token: "XXXX-XXXX-XXXX-XXXX-XXXX"
```

`tester_email_admin`: UbiCast admin reciever of the email report for premiums (Optional)
```
tester_email_admin: "sysadmin+premium@ubicast.eu"
```

`tester_email_from`: Sender of the email report (Optional)
```
tester_email_from: "ubicast.tester"
```

`tester_email_to`: Reciever of the email report
```
tester_email_to: "example@example.com"
```

`tester_tests_ignored`: List of tests to ignore when executing the ubicast-tester (Optional)
```
tester_tests_ignored: []
```
