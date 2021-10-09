#!/bin/bash
# Copyright 2021 Liu Dng. All rights reserved.
# Use of this source code is governed by Apache License
# that can be found in the LICENSE file.

. $(dirname $(realpath $0))/lib/framework.bash

#
# Declare custom global variables
#


#
# Write your own source code here.
#
cmd_body() {
    echo "This is a sample bash script."
    echo "--key = $demo_key"
    echo "Custom arguments: $@"
    echo "dev_global_base: $dev_global_base"
}

#
# Append your custom help here.
#
dev_custom_help_usage() {
    echo "  --key=value        Example key and value"
}

#
# Add custom optional arguments here.
#
dev_custom_optional_arguments() {
    case "$dev_arg_key" in
        --key)
            declare -gr demo_key="$dev_arg_val"
            ;;
        *)
            echo "Optional argument not found: $1" >&2
            ;;
    esac
}

dev_custom_validation() {
    if [[ -z $demo_key ]]; then
        echo "Error: --key is required." >&2
        return 1
    fi
}

dev_main $@
