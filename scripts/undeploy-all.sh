#!/bin/bash
# ------------------------------------------------------------------------
#
# Copyright 2005-2015 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# ------------------------------------------------------------------------
SCRIPTS_PATH=/home/ubuntu/scripts

set -e

/bin/bash $SCRIPTS_PATH/undeploy-apim-191.sh
/bin/bash $SCRIPTS_PATH/undeploy-as-521.sh
/bin/bash $SCRIPTS_PATH/undeploy-bps-350.sh
/bin/bash $SCRIPTS_PATH/undeploy-brs-210.sh
/bin/bash $SCRIPTS_PATH/undeploy-das-300.sh
/bin/bash $SCRIPTS_PATH/undeploy-dss-322.sh
/bin/bash $SCRIPTS_PATH/undeploy-esb-481.sh
/bin/bash $SCRIPTS_PATH/undeploy-greg-500.sh
/bin/bash $SCRIPTS_PATH/undeploy-is-500.sh
/bin/bash $SCRIPTS_PATH/undeploy-mb-300.sh
/bin/bash $SCRIPTS_PATH/undeploy-common.sh

