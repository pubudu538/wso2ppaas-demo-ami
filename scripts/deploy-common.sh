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

echo "Adding autoscale policy..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/autoscaling-policies/autoscaling-policy-economy.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/autoscalingPolicies
echo ""

echo "Adding network partitions..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/network-partitions/network-partition-ec2.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/networkPartitions
echo ""

echo "Adding deployment policy..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/deployment-policies/deployment-policy-ec2.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/deploymentPolicies
echo ""

echo "Adding application policy..."
curl -X POST -H "Content-Type: application/json" -d "@${ARTIFACTS_PATH}/application-policies/application-policy-ec2.json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applicationPolicies
echo ""
