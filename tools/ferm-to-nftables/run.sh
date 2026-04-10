#!/usr/bin/env bash

# -- Variables --

# Nftables migration validation duration
VALIDATION_TIMEOUT=180  # seconds

# Nftables rules directory
NFTABLES_DIR='/etc/nftables.d'

# Ferm migration backup directory
FERM_BACKUP_DIR='/etc/ferm.deb12.bak'

# retrieve list of installed packages ("ii" from dpkg -l)
INSTALLED_PKGS=$(dpkg-query -Wf='${db:Status-Abbrev} ${Package}\n' | awk '/^ii/ {print $2}')

# define colors
_reset='\033[0m'
_red='\033[1;31m'
_green='\033[1;32m'
_yellow='\033[1;33m'
_blue='\033[1;34m'
_grey='\e[2m'

# -- Functions --

title(){
    echo
    echo -e "${_blue}:: ${*}${_reset}"
}

is_installed(){
    if ! echo "${INSTALLED_PKGS}" | grep -q "^${1}$"; then
        echo -e "${1} ${_yellow}not installed${_reset}"
        return 1
    fi
    echo -e "${1} ${_green}installed${_reset}"
    return 0
}

use_iptables(){
    # verify if iptables is installed
    if ! command -v iptables >/dev/null 2>&1; then
        return 1
    fi
    # check which backend iptables is using
    # /usr/sbin/xtables-nft-multi
    # /usr/sbin/xtables-legacy-multi
    iptables_backend="$(readlink -f "$(which iptables)" 2>/dev/null)"
    if [[ "${iptables_backend}" =~ nft ]]; then
        return 1
    else
        return 0
    fi
}

manual_intervention(){
    echo
    echo "Manual intervention is required."
    echo "After completing the intervention, please rerun this script."
    exit 1
}

nftables_ports(){
    ports_to_check=("${@}")
    active_ports=()
    for port in "${ports_to_check[@]}"; do
        # Verify if port is listening
        if ss -tln sport = :"${port}" 2>/dev/null | awk 'NR > 1 {print $4}' | grep -q ":${port}$"; then
            active_ports+=("${port}")
        fi
    done
    if [[ ${#active_ports[@]} -eq 0 ]]; then
        nft_port=''
    elif [[ ${#active_ports[@]} -eq 1 ]]; then
        nft_port="${active_ports[0]}"
    else
        nft_port="{ $(IFS=', '; echo "${active_ports[*]}") }"
    fi
    echo "${nft_port}"
}

nftables_uninstall_notes(){
    echo "  apt-get -qq purge -y nftables"
}

ferm_install_notes(){
    echo "  apt-get -qq update"
    echo "  apt-get -qq install -y ferm"
    echo "  update-alternatives --set iptables /usr/sbin/iptables-legacy"
    echo "  update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy"
}

ferm_restore_notes(){
    if [ -d "${FERM_BACKUP_DIR}" ]; then
        echo "  rm -r /etc/ferm"
        echo "  cp -a ${FERM_BACKUP_DIR}" /etc/ferm
        echo "  systemctl enable ferm.service"
        echo "  systemctl restart ferm.service"
    fi
}

enable_service(){
    echo "[+] Enable & start ${1}..."
    systemctl enable "${1}"
    systemctl restart "${1}"
}

disable_service(){
    echo "Stop & disable ${1}..."
    systemctl stop "${1}"
    systemctl disable "${1}"
}

nftables_rollback(){
    echo 'Flush nftables ruleset...'
    nft flush ruleset
    disable_service nftables.service
}

ferm_rollback(){
    echo '[+] Restore ferm configuration'
    mv -v "${FERM_BACKUP_DIR}" /etc/ferm
    enable_service ferm.service
}

rollback(){
    echo
    echo -e "${_red}Rollback services and configurations${_reset}"
    nftables_rollback
    ferm_rollback
    manual_intervention
}

# -- Test elegibilty --

title "Verification"
echo '[+] Backend verification'
if use_iptables; then
    echo 'Iptables used as backend...'
else
    echo 'Nftables already used as backend.'
    # detect migration rollback or aborted
    if [ -d "${FERM_BACKUP_DIR}" ] || [ -d '/etc/ferm' ]; then
        echo
        echo "To force script rerun, reinstall ferm package and change iptables backend:"
        echo
        ferm_install_notes
        echo
    fi
    exit 0
fi

echo '[+] Verify ferm is installed'
if ! is_installed 'ferm'; then
    echo 'Automatic migration not supported!'
    exit 1
fi

# -- Apply changes --

title 'Installation'
echo '[+] Installation of nftables...'
apt-get -qq update
apt-get -qq install -y nftables || manual_intervention

title 'Configuration'
# data generated with: tar -czf - -C /etc nftables.conf | base64
# data content from: https://git.ubicast.net/sys/ansible-public/-/blob/3276d264121e6ae9747da0a32b468527946f827d/roles/system/nftables/files/nftables.conf
data=$(cat <<'EOF'
H4sIAAAAAAACA+1XTY/bNhD12b9isnsrorU+bHebnLabQwK0QJGkt15ocrRiTZEqSa3XCPLfO5Ts
rrP+WDlJCxTgO1iQNI8zfG8o0rr0bKHQXXGjy9G/g5Qwn067K+HpdZZns1E2S4tsWqRZOh+lWR4e
QTr6D9A6zyzAyBrjT8U99/5/issXk9bZiVtIPdGlh6Qcjy/hViGJwpSCxkpjgTTyOC5V6yqwLbUL
+hD2M3OSw7vf7qcT+pn3YWWroJQWV4FeBjLae7STlbHLECCNvhp3TQdSo6dY5dHCpzFswCsmNb1r
Wr/zdAu/bnDLqYxZbgK7OqVfQ/oaGqMkX4Owpnk93htAylKzGkEZYJxj4+GPvRhu6hq1h4ubPoLp
NcVzpirjPHjLylLyi/2xue81gE+ALsxRugrFS7Co6KmAz8NTbpIAzepO6o5dWlND607llfqeKSm6
uZ9K8ia83wbT0tfIgzGHxva8AdEY6yHLCprJnxQKK+krkLxuHnpDwvuk1RYZuResPZH7fT/Eze8f
34I3ULMl1U19wCT1C3P+QA2X8O72V2qzA242ZL3xhhvV1dP/dDXt984WyCuTWGzU+mUYu4tOj0YL
sjI4QPrsTvGRWjyX6K+WhniMvz4a72WNCT5wRBHaZkvIsqOMhllqZloMCclAVdU7rHyPdUb/BcGP
OzE/5MQcND74StjOBPoebC7PuPGsvqdmz5foE29MspB3j4z8XIWLrxF4eqbvWX59Vktm+U/f4uBi
+3WeQ9nqbn3Tcvfri+/onRaJNW1Qx4WPrtydbVEMoDFBe8MXrOkplkZ5Vy3MwXSzQcT9hPMDIgdB
KtMoWdOXKZ/NhqiulFn1cn/45ebm9nvKXCuR0F7iUZNk1FV2t0uKdBiPust8OfNsKFG0XfvscvNT
3PxE1mlxRG/HBOlS4nX66tUkS8+TvG6Vl5x2D9hmBiEdN2T2Goymp3qZdFv4EV+eZm9FA67b9mbT
H7s7sbmbD1+Cb97ehuLCupbo+g28K/exHAh50TmkvfcfPcZPDkN0jFoxK4Ych7ahRw9ER5PQghx4
5NpEHkjRK7Ob5HM4KL4PZ8ax1Fy1AuFigp6H02b/z0NMfriiG/JlFBERERERERERERERERERERER
ERERERERERER8S34G7mpxMEAKAAA
EOF
)
echo '[+] Extract default nftables configuration...'
(
    cd /etc
    echo "${data}" | base64 -d | tar -xzv
)

echo '[+] Prepare rules directory...'
mkdir -v "${NFTABLES_DIR}" 2>/dev/null

echo '[+] Create nftables SSH rules...'
echo 'Retrieve SSH port'
mapfile -t ssh_ports < <(grep -hRPo '^Port\s+\K\d+' /etc/ssh/sshd_config* 2>/dev/null)
ssh_ports="$(nftables_ports ${ssh_ports[@]})"
[ -z "${ssh_ports[*]}" ] && ssh_ports=22
echo "SSH port(s): ${ssh_ports}"
echo '> add SSH rule...'
echo "add inet filter input tcp dport ${ssh_ports} accept comment \"SSH\"" > "${NFTABLES_DIR}/ssh.nft"

# To list ansible deployed rules:
#  git grep -A2 '_rules_files: *$' | awk -F'/' '/ - / {print $3" ->> "$0".nft"}' | sed 's/->>.*- */->> /'
echo '[+] Create nftables application rules...'
if is_installed 'nginx'; then
    echo '> add http rules...'
    echo 'add inet filter input tcp dport { 80, 443 } accept comment "HTTP(S)"' > "${NFTABLES_DIR}/http.nft"
fi

if is_installed 'nginx-rtmp'; then
    echo 'Retrieve RTMP port'
    rtmp_port="$(nftables_ports '1935' '1936')"
    echo "RTMP port(s): ${rtmp_port}"
    echo '> add rtmp rules...'
    echo "add inet filter input tcp dport ${rtmp_port} accept comment \"RTMP\"" > "${NFTABLES_DIR}/rtmp.nft"
fi

if is_installed 'ubicast-celerity-server'; then
    echo '> add celerity server rules...'
    echo 'add inet filter input tcp dport 6200 accept comment "Celerity Server"' > "${NFTABLES_DIR}/celerity.nft"
fi

if is_installed 'munin-node'; then
    echo '> add munin-node rules...'
    echo 'add inet filter input tcp dport 4949 accept comment "Munin node"' > "${NFTABLES_DIR}/munin-node.nft"
fi

if is_installed 'apt-cacher'; then
    echo '> add apt-cacher rules...'
    echo 'add inet filter input tcp dport 3142 accept comment "Apt Cacher"' > "${NFTABLES_DIR}/apt-cacher.nft"
fi

if is_installed 'ubicast-mediaimport'; then
    echo '> add ftp rules...'
    cat <<- 'EOF' > "${NFTABLES_DIR}/ftp.nft"
add ct helper inet filter passive-ftp { type "ftp" protocol tcp; }
add inet filter input tcp dport 21 ct helper set "passive-ftp" accept comment "FTP"
add inet filter input tcp dport 22 accept comment "SFTP"
EOF
fi

if is_installed 'postgresql'; then
    echo '> add postgresql rules...'
    echo 'add inet filter input tcp dport 5432 accept comment "PostgreSQL"' > "${NFTABLES_DIR}/postgresql.nft"
fi

# haproxy - local call only
if is_installed 'repmgr'; then
    echo '> add rephacheck rules...'
    echo 'add inet filter input tcp dport 8543 accept comment "Rephacheck"' > "${NFTABLES_DIR}/rephacheck.nft"
fi

if is_installed 'ubicast-health-check-api'; then
    echo '> add healthcheck rules...'
    echo 'add inet filter input tcp dport 3080 accept comment "Health-Check"' > "${NFTABLES_DIR}/healthcheck.nft"
fi

if is_installed 'lxc'; then
    echo '> add lxc rules...'
    cat <<- 'EOF' > "${NFTABLES_DIR}/lxc.nft"
# Used only for DHCP, otherwhise not necessary
# Override inet > forward chain to policy ACCEPT
table inet filter {
    chain forward {
        type filter hook forward priority 0; policy accept;
   }
}
# - for masquerade bridge
add inet filter input iifname "lxcbr0" udp dport { 53, 67 } accept
add inet filter input iifname "lxcbr0" tcp dport { 53, 67 } accept
# - for host bridge
add inet filter input iifname "vmbr0" udp dport { 53, 67 } accept
add inet filter input iifname "vmbr0" tcp dport { 53, 67 } accept
EOF
fi

title 'Verification'
echo '[+] Test nftables configuration...'
if ! nft --file /etc/nftables.conf --check >/dev/null 2>/dev/null; then
    echo -e "Nftables configuration parsing ${_red}error${_reset}"
    nftables_rollback
    manual_intervention
else
    echo -e "Nftables configuration test successfull"
fi

echo '[+] Verify ferm configuration...'
for dir in /etc/ferm/{output,forward}.d/; do
    if [ -d "${dir}" ] && [ "$(ls -A "${dir}")" ]; then
        echo -e "Directory ${dir} ${_red}not empty${_reset} and ${_yellow}not migrated automatically${_reset}:"
        find "${dir}" -mindepth 1 | sed 's|^|- |'
        manual_intervention
    fi
done

title 'System configuration'
disable_service ferm.service
if [ -d '/etc/ferm' ] && ! [ -d "${FERM_BACKUP_DIR}" ]; then
    echo "[+] Move ferm configuration to ${FERM_BACKUP_DIR}"
    mv -v /etc/ferm "${FERM_BACKUP_DIR}"
fi
enable_service nftables.service

# -- Verify --

echo
echo -e "${_red}Firewall rules have been migrated from ferm/iptables to nftables.${_reset}"
echo 'Please open a *new terminal* and test if SSH still works.'
echo "Once you have confirmed the SSH connection works, press [ENTER] to continue."
echo "If it does not work, this script will automatically roll back the changes in ${VALIDATION_TIMEOUT} seconds."
echo
if ! read -r -t ${VALIDATION_TIMEOUT} -p "Continue? [Y/n] " answer; then
    echo
    echo "No input received, timeout"
    rollback
elif ! [[ -z "${answer}" || "${answer}" =~ ^[yYoO]$ ]]; then
    echo
    echo "SSH connection not confirmed"
    rollback
fi

title 'Change fail2ban backend to nftables'
# set default configuration to jail.local if missing
if ! [ -f '/etc/fail2ban/jail.local' ]; then
    # retrieve email configuration
    email_from="$(awk '/root@/ {print $NF; exit}' /etc/postfix/generic)"
    email_to="$(awk '/^email:/ {p=1} p && /to:/ {gsub(/[" ]/, "", $2); print $2; exit}' /etc/ubicast-tester/config.yml)"
    cat << EOF > /etc/fail2ban/jail.local
[DEFAULT]

ignoreip = 127.0.0.1/8 ::1
bantime = 10m
maxretry = 5
destemail = ${email_to:-noreply@example.com}
sender = ${email_from:-root@localhost}
action = %(action_mwl)s
EOF
fi

# change default banaction backends if missing
if ! grep -q 'nftables' '/etc/fail2ban/jail.local' 2>/dev/null && \
   ! grep -q 'nftables' '/etc/fail2ban/jail.d/defaults-debian.conf' 2>/dev/null; then
    cat << EOF >> /etc/fail2ban/jail.local
# nftables configuration
banaction = nftables-multiport
banaction_allports = nftables-allports
EOF
fi
systemctl reload fail2ban.service

title 'Cleanup'
apt-get -qq purge -y --auto-remove ferm iptables

if [ -f '/usr/share/ubicast-tester/tests/firewall.sh' ]; then
    title 'Tests'
    echo "[+] Execute firewall test from ubicast-tester..."
    /usr/share/ubicast-tester/tests/firewall.sh
fi

title 'Notes'
echo -e "${_red}If a rollback is needed${_reset}, please execute the following commands:"
echo
nftables_uninstall_notes
ferm_install_notes
ferm_restore_notes
echo
