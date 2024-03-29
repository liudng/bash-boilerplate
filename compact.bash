#!/bin/bash
# Copyright 2023 Liu Dong <liudng@hotmail.com>. All rights reserved.
# Use of this source code is governed by Apache License
# that can be found in the LICENSE file.

# trace ERR through pipes
set -o pipefail

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

# The dev package version
declare -gr dev_global_version="1.2.0"

# The dev execution file path
declare -gr dev_global_self="$(realpath $0)"

# The dev execution base path
declare -gr dev_global_base="$(dirname $(dirname $dev_global_self))"

declare -g dev_task="default"

declare -g dev_arg_key

declare -g dev_arg_val

#
# Declare custom global variables here.
#



#
# Write your own tasks here.
#


dev_task_default() {
  echo "This is a sample bash script."
  echo "demo_key = $demo_key"
  echo "Custom arguments: $@"
  echo "dev_global_base: $dev_global_base"
}

dev_kernel_help_usage() {
  echo "Usage: $(basename $dev_global_self) [--task=TASK] [--trace] [--verbose]"
  echo "       $(basename $dev_global_self) [--help]"
  echo "       $(basename $dev_global_self) [--version]"
  echo ""
  echo "Optional arguments:"
  echo "      --help                Help topic and usage information"
  echo "  -t, --task=TASK           Task name"
  echo "  -T, --trace               Print command traces before executing task"
  echo "      --verbose             Produce more output about what the program does"
  echo "      --version             Output version information and exit"

  #
  # Append your custom help here.
  #
  echo "      --demo=VALUE          Example key and value"
}

dev_kernel_optional_arguments() {
  # %: most right
  # %%: most left
  # #: most left
  # ##: most right
  dev_arg_key=${1%%=*}
  dev_arg_val="${1#*=}"

  case "$dev_arg_key" in
    --help)
      dev_kernel_help_usage
      exit 0
      ;;
    --task|-t)
      dev_task="$dev_arg_val"
      ;;
    --trace|-T)
      declare -gr dev_global_trace="1"
      ;;
    --verbose)
      declare -gr dev_global_verbose="1"
      ;;
    --version)
      echo "$dev_global_version" >&2
      exit 0
      ;;

    #
    # Insert custom optional arguments here.
    #
    --demo)
      declare -gr demo_key="$dev_arg_val"
      ;;

    # Nothing was matched.
    *)
      echo "Optional argument not found: $1" >&2
      ;;
  esac
}

dev_main() {
  while [[ $# -gt 0 && "${1:0:1}" == "-" ]]; do
    dev_kernel_optional_arguments "$1"
    shift
  done

  [[ "$dev_global_trace" -eq "1" ]] && set -o xtrace
  dev_task_$dev_task $@
}

dev_main $@
