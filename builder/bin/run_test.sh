#!/bin/bash

# Copyright 2017 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fail fast
set -e

# Ensure we are in the builder directory
pushd $(dirname $0)/.. > /dev/null
  pushd steps > /dev/null
    pushd gen-dockerfile > /dev/null
      docker build -t test/gen-dockerfile .
      ../../bin/ext_run.sh -i test/gen-dockerfile -v --config test_config.yaml
      pushd contents/ > /dev/null
        npm install
        npm test
      popd > /dev/null
    popd > /dev/null
  popd > /dev/null
popd > /dev/null
