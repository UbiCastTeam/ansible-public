# Ferm-configure

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`ferm_global_settings`: Global settings to be put in ferm.d directory (Optional)
```
ferm_global_settings: |

```

`ferm_input_rules`: List of input rules for the ferm firewall (Optional)
```
ferm_input_rules: []
```

`ferm_output_rules`: List of output rules for the ferm firewall (Optional)
```
ferm_output_rules: []
```

`ferm_rules_filename`: Filename into which rules will be written (Optional)
```
ferm_rules_filename: "default"
```

`ferm_forward_rules`: List of forward rules for the ferm firewall (Optional)
```
ferm_forward_rules: []
```
