# Proxy set if defined in /etc/environment
for proxy_var in $(grep -iE '^(https?|no)_proxy' /etc/environment); do
    export "${proxy_var}"
done
