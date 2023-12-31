#!/bin/bash
# Copyright 2023 Liu Dong <liudng@hotmail.com>. All rights reserved.
# Use of this source code is governed by Apache License
# that can be found in the LICENSE file.

# The dev execution file path
declare -gr dev_global_self="$(realpath $0)"

# The dev execution base directory
declare -gr dev_global_base="$(dirname $dev_global_self)"

# Include dev-core
. $dev_global_base/lib/dev-core.bash

#
# Declare custom global variables here.
#


#
# Write your own tasks here.
#


dev_task_main() {
  echo "This is a sample bash script."
  echo "demo_key = $demo_key"
  echo "Custom arguments: $@"
  echo "dev_global_base: $dev_global_base"
}

dev_help_usage() {
  #
  # Add custom help here.
  #
  echo "      --demo=VALUE          Example key and value"
}

dev_optional_arguments() {
  #
  # Insert custom optional arguments here.
  #
  case "$dev_arg_key" in
    --demo)
      declare -gr demo_key="$dev_arg_val"
      ;;

    # Nothing was matched.
    *)
      echo "Optional argument not found: $1" >&2
      exit
      ;;
  esac
}

dev_validation() {
  #
  # Write your own validations here.
  #
  if [[ -z $demo_key ]]; then
    echo "Error: --demo is required." >&2
    return 1
  fi
}

dev_main $@
