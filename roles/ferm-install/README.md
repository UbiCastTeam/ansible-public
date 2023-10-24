# Ferm-install
## Description

Used by the "base" metagroup to install the firewall solution

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`ferm_input_policy`: Input policy for the ferm firewall (Optional)
```
ferm_input_policy: "DROP"
```

`ferm_input_log`: Activates the logs for input packets (Optional)
```
ferm_input_log: False
```

`ferm_input_log_prefix`: Prefix for the input packets log lines (Optional)
```
ferm_input_log_prefix: "{{ ferm_input_policy }} INPUT "
```

`ferm_output_policy`: Output policy for the ferm firewall (Optional)
```
ferm_output_policy: "ACCEPT"
```

`ferm_output_log`: Activates the logs for output packets (Optional)
```
ferm_output_log: False
```

`ferm_output_log_prefix`: Prefix for the output packets log lines (Optional)
```
ferm_output_log_prefix: "{{ ferm_output_policy }} OUTPUT "
```

`ferm_forward_policy`: Forward policy for the ferm firewall (Optional)
```
ferm_forward_policy: "DROP"
```

`ferm_forward_log`: Activates the logs for forward packets (Optional)
```
ferm_forward_log: False
```

`ferm_forward_log_prefix`: Prefix for the forward packets log lines (Optional)
```
ferm_forward_log_prefix: "{{ ferm_forward_policy }} FORWARD "
```
