#!/bin/bash

DB_USER_NAME=root
DB_PASSWORD=root
DB_SCRIPTS_PATH=/home/ubuntu/dbscripts

if [[ $1 == "clean" ]]; then
   echo "Dropping databases..."
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE userstore_420;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE registry_420;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE userstore_44x;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE registry_44x;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE apim_191_mgt;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE identity_500;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE bps_350_bpel;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE bps_350_activiti;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_apim_191;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_is_500;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_as_521;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_bps_350;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_brs_210;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_das_300;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_dss_322;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_esb_481;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_greg_500;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_mb_300;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_cep_400;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_esb_490;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE config_db_greg_510;'

   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE das_300_analytics_fs;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE das_300_analytics_event_store;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE das_300_analytics_processed_data_store;'

   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE ppaas_das_300_analytics_fs;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE ppaas_das_300_analytics_event_store;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE ppaas_das_300_analytics_processed_data_store;'

   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE mb_300_metrics;'
   mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'DROP DATABASE mb_300_store;'
fi


mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS userstore_420;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS registry_420;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS userstore_44x;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS registry_44x;'

mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS apim_191_mgt;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS identity_500;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS bps_350_bpel;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS bps_350_activiti;'

mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_apim_191;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_is_500;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_as_521;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_bps_350;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_brs_210;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_das_300;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_dss_322;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_esb_481;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_greg_500;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_mb_300;'

mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS das_300_analytics_fs;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS das_300_analytics_event_store;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS das_300_analytics_processed_data_store;'

# DAS dbs for WSO2 PPaaS monitoring and metering
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS ppaas_das_300_analytics_fs;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS ppaas_das_300_analytics_event_store;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS ppaas_das_300_analytics_processed_data_store;'

mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS mb_300_metrics;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS mb_300_store;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_cep_400;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_esb_490;'
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE DATABASE IF NOT EXISTS config_db_greg_510;'

echo "Populating userstore-420..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} userstore_420 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating userstore-44x..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} userstore_44x < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating registry-420..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} registry_420 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating registry-44x..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} registry_44x < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating apimgt..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} apim_191_mgt < ${DB_SCRIPTS_PATH}/apimgt-191/mysql.sql

echo "Populating api application-mgt..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} apim_191_mgt < ${DB_SCRIPTS_PATH}/identity-500/application-mgt/mysql.sql

echo "Populating identity-500..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} identity_500 < ${DB_SCRIPTS_PATH}/identity-500/mysql.sql

echo "Populating identity-500 application-mgt..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} identity_500 < ${DB_SCRIPTS_PATH}/identity-500/application-mgt/mysql.sql

echo "Populating bps-350_bpel..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} bps_350_bpel < ${DB_SCRIPTS_PATH}/bps-350/bpel/create/mysql.sql

echo "Populating bps-350_activiti..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} bps_350_activiti < ${DB_SCRIPTS_PATH}/bps-350/bpmn/create/activiti.mysql.create.engine.sql
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} bps_350_activiti < ${DB_SCRIPTS_PATH}/bps-350/bpmn/create/activiti.mysql.create.history.sql
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} bps_350_activiti < ${DB_SCRIPTS_PATH}/bps-350/bpmn/create/activiti.mysql.create.identity.sql

echo "Populating das-300_analytics_fs..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} das_300_analytics_fs < ${DB_SCRIPTS_PATH}/das-300/metrics/mysql.sql

echo "Populating das-300_analytics_event_store..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} das_300_analytics_event_store < ${DB_SCRIPTS_PATH}/das-300/metrics/mysql.sql

echo "Populating das-300_analytics_processed_data_store..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} das_300_analytics_processed_data_store < ${DB_SCRIPTS_PATH}/das-300/metrics/mysql.sql

#########################################
# WSO2 PPaaS monitoring and metering
echo "Populating ppaas_das-300_analytics_fs..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} ppaas_das_300_analytics_fs < ${DB_SCRIPTS_PATH}/das-300/metrics/mysql.sql

echo "Populating ppaas_das-300_analytics_event_store..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} ppaas_das_300_analytics_event_store < ${DB_SCRIPTS_PATH}/das-300/metrics/mysql.sql

echo "Populating ppaas_das-300_analytics_processed_data_store..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} ppaas_das_300_analytics_processed_data_store < ${DB_SCRIPTS_PATH}/das-300/metrics/mysql.sql

echo "Populating MEMBER_STATUS table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_processed_data_store.MEMBER_STATUS(Time long, ApplicationId VARCHAR(150), ClusterAlias VARCHAR(150), MemberId VARCHAR(150), MemberStatus VARCHAR(50));'

echo "Populating MEMBER_COUNT table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_processed_data_store.MEMBER_COUNT(Time long, ApplicationId VARCHAR(150), ClusterAlias VARCHAR(150), CreatedInstanceCount int, InitializedInstanceCount int, ActiveInstanceCount int, TerminatedInstanceCount int);'

echo "Populating MEMBER_INFORMATION table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_processed_data_store.MEMBER_INFORMATION(MemberId VARCHAR(150), InstanceType VARCHAR(150), ImageId VARCHAR(150), HostName VARCHAR(150), PrivateIPAddresses VARCHAR(150), PublicIPAddresses VARCHAR(150), Hypervisor VARCHAR(150), CPU VARCHAR(10) , RAM VARCHAR(10), OSName VARCHAR(150), OSVersion VARCHAR(150));'

echo "Populating AVERAGE_MEMORY_CONSUMPTION_STATS table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_event_store.AVERAGE_MEMORY_CONSUMPTION_STATS(Time long, ClusterId VARCHAR(150), ClusterInstanceId VARCHAR(150), NetworkPartitionId VARCHAR(150), Value DOUBLE);'

echo "Populating MEMBER_AVERAGE_MEMORY_CONSUMPTION_STATS table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_event_store.MEMBER_AVERAGE_MEMORY_CONSUMPTION_STATS(Time long, MemberId VARCHAR(150), ClusterId VARCHAR(150), ClusterInstanceId VARCHAR(150), NetworkPartitionId VARCHAR(150), Value DOUBLE);'

echo "Populating AVERAGE_LOAD_AVERAGE_STATS table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_event_store.AVERAGE_LOAD_AVERAGE_STATS(Time long, ClusterId VARCHAR(150), ClusterInstanceId VARCHAR(150), NetworkPartitionId VARCHAR(150), Value DOUBLE);'

echo "Populating MEMBER_AVERAGE_LOAD_AVERAGE_STATS table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_event_store.MEMBER_AVERAGE_LOAD_AVERAGE_STATS(Time long, MemberId VARCHAR(150), ClusterId VARCHAR(150), ClusterInstanceId VARCHAR(150), NetworkPartitionId VARCHAR(150), Value DOUBLE);'

echo "Populating AVERAGE_IN_FLIGHT_REQUESTS table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_event_store.AVERAGE_IN_FLIGHT_REQUESTS(Time long, ClusterId VARCHAR(150), ClusterInstanceId VARCHAR(150), NetworkPartitionId VARCHAR(150), COUNT DOUBLE);'

echo "Populating SCALING_DETAILS table..."
mysql -u ${DB_USER_NAME} -p${DB_PASSWORD} -e 'CREATE TABLE ppaas_das_300_analytics_event_store.SCALING_DETAILS(Time VARCHAR(50), ScalingDecisionId VARCHAR(150), ClusterId VARCHAR(150), MinInstanceCount INT, MaxInstanceCount INT, RIFPredicted INT, RIFThreshold INT ,RIFRequiredInstances INT, MCPredicted INT, MCThreshold INT, MCRequiredInstances INT ,LAPredicted INT, LAThreshold INT,LARequiredInstances INT,RequiredInstanceCount INT ,ActiveInstanceCount INT, AdditionalInstanceCount INT, ScalingReason VARCHAR(150));'
####################################

echo "Populating mb-300_metrics..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} mb_300_metrics < ${DB_SCRIPTS_PATH}/mb-300/metrics/mysql.sql


echo "Populating mb-300_store..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} mb_300_store < ${DB_SCRIPTS_PATH}/mb-300/mb-store/mysql-mb.sql


echo "Populating config apim-191..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_apim_191 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating config is-500..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_is_500 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating config as-521..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_as_521 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating config bps-350..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_bps_350 < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating config brs-210..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_brs_210 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating config das-300..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_das_300 < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating config dss-322..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_dss_322 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating config esb-481..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_esb_481 < ${DB_SCRIPTS_PATH}/carbon-420/mysql.sql

echo "Populating config greg-500..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_greg_500 < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating config mb-300..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_mb_300 < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating config cep-400..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_cep_400 < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating config esb-490..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_esb_490 < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql

echo "Populating config greg-510..."
mysql -f -u ${DB_USER_NAME} -p${DB_PASSWORD} config_db_greg_510 < ${DB_SCRIPTS_PATH}/carbon-44x/mysql.sql
