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


echo "Adding WSO2 APIM 1.9.1 Gateway Manager cartridge..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridges/wso2am-191/wso2am-191-gw-manager.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges
echo ""

echo "Adding WSO2 APIM 1.9.1 Gateway Worker cartridge..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridges/wso2am-191/wso2am-191-gw-worker.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges
echo ""

echo "Adding WSO2 APIM 1.9.1 Keymanager cartridge..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridges/wso2am-191/wso2am-191-km.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges
echo ""

echo "Adding WSO2 APIM 1.9.1 with Identity Server 5.0.0 as Key Manager cartridge..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridges/wso2am-191/wso2is-as-km-500-manager.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges
echo ""

echo "Adding WSO2 WSO2 APIM 1.9.1 Publisher cartridge..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridges/wso2am-191/wso2am-191-pub.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges
echo ""

echo "Adding WSO2 APIM 1.9.1 Store cartridge..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridges/wso2am-191/wso2am-191-store.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges
echo ""

echo "Adding WSO2 APIM 1.9.1 cartridge Group 1 ..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridge-groups/wso2am-191/wso2am-191-group1.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridgeGroups
echo ""

echo "Adding WSO2 APIM 1.9.1 cartridge Group 2 ..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridge-groups/wso2am-191/wso2am-191-group2.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridgeGroups
echo ""

echo "Adding WSO2 APIM 1.9.1 cartridge Group 3 ..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/cartridge-groups/wso2am-191/wso2am-191-group3.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridgeGroups
echo ""

echo "Adding WSO2 APIM 1.9.1 application..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/applications/wso2am-191-application/wso2am-191-application.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applications
echo ""

echo "Adding WSO2 APIM 1.9.1 application..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/applications/wso2am-191-application-with-identity-server/wso2am-191-application.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applications
echo ""
