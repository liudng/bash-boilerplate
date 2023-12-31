#!/bin/bash
# Copyright 2023 Liu Dong <liudng@hotmail.com>. All rights reserved.
# Use of this source code is governed by Apache License
# that can be found in the LICENSE file.

# trace ERR through pipes
set -o pipefail

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

# The dev package version
declare -gr dev_global_version="2.0.0"

declare -g dev_task="main"

declare -g dev_arg_key

declare -g dev_arg_val

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

  dev_help_usage
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
    *)
      dev_optional_arguments $1
      ;;
  esac
}

dev_main() {
  while [[ $# -gt 0 && "${1:0:1}" == "-" ]]; do
    dev_kernel_optional_arguments "$1"
    shift
  done

  dev_validation

  [[ "$dev_global_trace" -eq "1" ]] && set -o xtrace
  dev_task_$dev_task $@
}
