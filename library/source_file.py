#!/usr/bin/python

# Copyright: (c) 2019, Nicolas Karolak <nicolas.karolak@ubicast.eu>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import absolute_import, division, print_function

__metaclass__ = type

ANSIBLE_METADATA = {
    "metadata_version": "1.1",
    "status": ["preview"],
    "supported_by": "community",
}


DOCUMENTATION = """
module: source_file
short_description: Source remote bash/dotenv file
description:
    - This module is used to register host variables from a remote bash/dotenv-like file.
    - It handles boolean value (`MY_VAR=1`) and has a basic handling of list (`MY_VAR=one,two,three`) and dictionnary (`MY_VAR=a=1;b=2;c=3`).
version_added: "2.8"
author: "Nicolas Karolak (@nikaro)"
options:
    path:
        description:
            - Path to the file to source.
        required: true
        type: path
    prefix:
        description:
            - Prefix to add to the registred variable name.
        required: false
        default: ""
        type: str
    lower:
        description:
            - Wether to lower or not the variable name.
        required: false
        default: false
        type: bool
notes:
    - The `check_mode` is supported.
"""

EXAMPLES = """
- name: source envsetup file
  source_file:
    prefix: envsetup_
    path: /root/envsetup/conf.sh
    lower: true
"""

RETURN = """
ansible_facts:
    description: Registred vairales.
    returned: on success
    type: dict
    sample:
        key: value
"""

import os  # noqa: E402
import re  # noqa: E402

from ansible.module_utils.basic import AnsibleModule  # noqa: E402
from ansible.module_utils.parsing.convert_bool import BOOLEANS, boolean  # noqa: E402
from ansible.module_utils.six import string_types  # noqa: E402


def run_module():
    module_args = {
        "path": {"type": "path", "required": True},
        "prefix": {"type": "str", "required": False, "default": ""},
        "lower": {"type": "bool", "required": False, "default": False},
    }

    result = {"changed": False}

    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    path = module.params["path"]
    prefix = module.params["prefix"]
    lower = boolean(module.params["lower"])
    variables = {}
    regex_valid_name = re.compile(r"^[a-zA-Z][a-zA-Z0-9_-]*$")
    regex_key_value = re.compile(
        r"^(?!#)(?P<key>[a-zA-Z][a-zA-Z0-9_-]*)=(?:[\'\"])?(?P<value>(?:[^\'\"\n])*)(?:[\'\"])?$",
        re.MULTILINE
    )

    if not os.path.isfile(path):
        module.fail_json(msg="'%s' does not exist or is not a file" % path, **result)

    if prefix and not regex_valid_name.match(prefix):
        module.fail_json(
            msg="'%s' is not a valid prefix it must starts with a letter or underscore"
            " character, and contains only letters, numbers and underscores" % prefix,
            **result
        )

    with open(path) as path_fh:
        # load file content and get all "key=value"
        content = path_fh.read()
        content_match = regex_key_value.findall(content)

        for key, value in content_match:
            # merge prefix + key
            if prefix:
                key = "%s%s" % (prefix, key)

            # lower key
            if lower:
                key = key.lower()

            # check key validity
            if not regex_valid_name.match(key):
                module.fail_json(
                    msg="'%s' is not a valid variable name it must starts with a letter or "
                    "underscore character, and contains only letters, numbers and underscores"
                    % key,
                    **result
                )

            # handle list value
            if "," in value:
                value = re.split("[,\n]", value)

            # handle dict value
            if ";" in value and "=" in value:
                value = {i.split("=")[0]: i.split("=")[1] for i in value.split(";")}

            # handle bool value
            if isinstance(value, string_types) and value.lower() in BOOLEANS:
                value = boolean(value)

            # build variables dict
            variables[key] = value

            result["changed"] = True

            if not module.check_mode:
                result["ansible_facts"] = variables

    module.exit_json(**result)


def main():
    run_module()


if __name__ == "__main__":
    main()
