#!/bin/bash
# Copyright 2020 Liu Dng. All rights reserved.
# Use of this source code is governed by Apache License
# that can be found in the LICENSE file.

. lib/framework.bash

#
# Declare custom global variables
#


cmd_body() {
    #
    # Write your own source code here.
    #
    echo "This is a sample bash script."
    echo "--key = $demo_key"
    echo "Custom arguments: $@"
}

dev_custom_help_usage() {
    #
    # Append your custom help here.
    #
    echo "  --key=value        Example key and value"
}

dev_custom_optional_arguments() {
    case "$dev_arg_key" in
        #
        # Add custom optional arguments here.
        #
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
