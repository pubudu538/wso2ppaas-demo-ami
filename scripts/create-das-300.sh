#!/bin/bash
# --------------------------------------------------------------
#  Copyright 2005-2015 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# --------------------------------------------------------------
HOST_IP="localhost"
HOST_PORT=9443
ARTIFACTS_PATH=/home/ubuntu/samples

set -e


echo "Adding WSO2 DAS 3.0.0 Manager cartridge..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridges/wso2das-300/wso2das-300.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges
echo ""

echo "Adding WSO2 DAS 3.0.0 cartridge group..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridge-groups/wso2das-300/wso2das-300-group.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridgeGroups
echo ""

echo "Adding WSO2 DAS 3.0.0 application..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/applications/wso2das-300-application/wso2das-300-application.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applications
echo ""
