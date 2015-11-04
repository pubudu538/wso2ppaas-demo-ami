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


echo "Removing application policies..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/applicationPolicies/application-policy-ec2
echo ""

echo "Removing deployment policies..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/deploymentPolicies/deployment-policy-ec2
echo ""

echo "Removing network partitions..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/networkPartitions/network-partition-ec2
echo ""

echo "Removing autoscale policies..."
curl -X DELETE -H "Content-Type: application/json" -k  -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/autoscalingPolicies/autoscaling-policy-economy
echo ""
