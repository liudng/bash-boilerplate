#!/bin/bash
# Copyright 2020 The bash-boilerplate Authors. All rights reserved.
# Use of this source code is governed by Apache
# license that can be found in the LICENSE file.

# trace ERR through pipes
set -o pipefail

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

# The dev package version
declare -gr dev_global_version="1.0.0"

# The dev execution file path
declare -gr dev_global_self="$(realpath $0)"

# The dev execution base path
declare -gr dev_global_base="$(dirname $(dirname $dev_global_self))"

dev_kernel_help_usage() {
    echo "Usage: $dev_global_project [--trace] [--verbose] <cmd-file> <cmd-function>"
    echo "           [cmd-arguments...]"
    echo "       $dev_global_project [--help] [--version]"
    echo ""
    echo "Optional arguments:"
    echo "  --trace            Print command traces before executing command"
    echo "  --verbose          Produce more output about what the program does"
    echo "  --version          Output version information and exit"
    echo "  --help             Help topic and usage information"
}

main() {
    case "$1" in
        --help)
            dev_kernel_help_usage
            exit 0
            ;;
        --version)
            echo "$dev_global_version" >&2
            exit 0
            ;;
        --trace)
            set -o xtrace
            ;;
        --verbose)
            declare -gr dev_global_verbose="1"
            ;;
        *)
            # Optional argument not found
            ;;
    esac

    #
    # Write your code here.
    #
    echo "This is a sample bash script."
}

main $@
