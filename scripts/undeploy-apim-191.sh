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
HOST_IP="localhost"
HOST_PORT=9443

set -e

echo "Undeploying application..."
curl -X POST -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applications/wso2am-191-application/undeploy
echo ""


echo "Undeploying APIM with IS application..."
curl -X POST -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applications/wso2am-191-application-with-is/undeploy
echo ""


echo "Deleting application..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applications/wso2am-191-application
echo ""

echo "Deleting APIM with IS application..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applications/wso2am-191-application-with-is
echo ""

echo "Removing cartridge Groups ..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridgeGroups/keymanager-gw-manager-gw-worker
echo ""

curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridgeGroups/pub-store-grp
echo ""

curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridgeGroups/identityserver-gw-manager-gw-worker
echo ""

echo "Removing cartridges..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges/wso2am-191-gw-manager
echo ""

curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges/wso2am-191-gw-worker
echo ""

curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges/wso2am-191-km
echo ""

curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges/wso2am-191-pub
echo ""

curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges/wso2is-as-km-500-manager
echo ""

curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/cartridges/wso2am-191-store
echo ""
