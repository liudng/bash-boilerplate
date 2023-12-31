#!/bin/bash
# Copyright 2021 Liu Dong <liudng@hotmail.com>. All rights reserved.
# Use of this source code is governed by Apache License
# that can be found in the LICENSE file.

# trace ERR through pipes
set -o pipefail

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

# The dev package version
declare -gr dev_global_version="1.1.0"

# The dev execution file path
declare -gr dev_global_self="$(realpath $0)"

# The dev execution base path
declare -gr dev_global_base="$(dirname $(dirname $dev_global_self))"

#
# Declare custom global variables
#


cmd_body() {
    #
    # Write your own source code here.
    #
    echo "This is a sample bash script."
    echo "Custom arguments: $@"
}

cmd_body $@
