#!/usr/bin/env bash

# config
exclude_pattern=()
exclude_pattern+=('^./roles/elastic.elasticsearch')
exclude_pattern+=('^./.venv')

apt_regex='^[^#]*(ansible.builtin.|)apt:'
until_regex='^[^#]*until: apt_status is success'

# * * *

# go to repository root dir
cd "$(readlink -f "$(dirname "${0}")")"/..

# join function
join_by() { local IFS="$1"; shift; echo "$*"; }

# set all *.yml files to an array
mapfile -t yml_files < <(find . -type f -iname '*.yml' | grep -vE "$(join_by '|' "${exclude_pattern[@]}")")

# check every files
errors_count=0
for f in "${yml_files[@]}"; do

    # count apt block
    apt_block_count=$(grep -cE "${apt_regex}" "${f}")

    # test if file contain apt block
    if (( apt_block_count > 0 )); then

        # get apt block, count apt: and until:
        apt_blocks="$(awk -v RS='' "/${apt_regex}/" "${f}")"
        apt_nb="$(echo "${apt_blocks}" | grep -cE "${apt_regex}")"
        until_nb="$(echo "${apt_blocks}" | grep -c "${until_regex}")"

        # test if apt: and until: count differ
        if (( apt_nb != until_nb )); then
            echo "- ${f}"
            (( errors_count++ ))
        fi
    fi

done

if (( errors_count != 0 )); then
    echo "Files listed below contain incomplete apt blocks"
    echo "Please refer to this documentation: https://docs.google.com/document/d/1B31l4v6VV_3r_ePPiugI8I_D_oRsUKFVIMIjerV_KvM/edit#heading=h.lm0b49ccpi46"
    echo
    exit 1
else
    exit 0
fi
