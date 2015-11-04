#!/bin/bash

CARTRIDGES_REPO_PATH=/home/ubuntu/wso2-repos/private-paas-cartridges.git
TEMPLATES_PATH=/home/ubuntu/template_modules
PUPPET_PATH=/etc/puppet
VERSION=4.1.1-SNAPSHOT
PRIVATE_IP=`wget -qO- http://instance-data/latest/meta-data/local-ipv4`
PUBLIC_IP=`wget -qO- http://instance-data/latest/meta-data/public-ipv4`
PACKS_PATH=/home/ubuntu/packs
puppet_mode=false
force_mode=false

while getopts ":pf" opts
do
  case $opts in
    p)
        echo "Puppet mode enabled"
        export puppet_mode="true"
        ;;
    f)
        echo "Force mode enabled"
        export force_mode="true"
        ;;
    *)
        echo "Error! Invalid option: -${OPTARG}"
        exit 1
    ;;
  esac
done


echo "Private IP: ${PRIVATE_IP}"
echo "Public IP: ${PUBLIC_IP}"
sudo hostname puppet.demo.ppaas.wso2.com

# cleanup /tmp/ppaas dir
rm -rf /tmp/ppaas || true
mkdir /tmp/ppaas

if [[ $puppet_mode == "true" ]]; then
    # cleanup puppet modules and manifests
    rm -rf /etc/puppet/modules
    rm -rf /etc/puppet/manifests

    # extract vm tools distribution to /tmp/ppaas
    pushd ${CARTRIDGES_REPO_PATH}/common/vm
    mvn -q clean install
    unzip -q target/wso2ppaas-vm-tools-${VERSION}.zip -d /tmp/ppaas
    popd

    cp -a /tmp/ppaas/wso2ppaas-vm-tools-${VERSION}/puppet/modules/   /etc/puppet
    cp -a /tmp/ppaas/wso2ppaas-vm-tools-${VERSION}/puppet/manifests/   /etc/puppet
fi

# extract configurator to /tmp/ppaas
pushd ${CARTRIDGES_REPO_PATH}/common/configurator/modules/distribution
mvn -q clean install
cp target/wso2ppaas-configurator-${VERSION}.zip ${PACKS_PATH}
unzip -q target/wso2ppaas-configurator-${VERSION}.zip -d /tmp/ppaas
popd


cp -a ${TEMPLATES_PATH}/* /tmp/ppaas/wso2ppaas-configurator-${VERSION}/template-modules/
pushd /tmp/ppaas/wso2ppaas-configurator-${VERSION}/
chmod -R 755 ./

# Base params
export PPAAS_CARTRIDGE_VERSION=${VERSION}
export PCA_VERSION=4.1.4
export MB_IP=${PRIVATE_IP}
export LB_IP=${PUBLIC_IP}
export CEP_URLS=${PRIVATE_IP}:7711
export METADATA_SERVICE_URL=https://${PRIVATE_IP}:9443

if [[ $force_mode == "true" ]] ; then
    export EC2_IDENTITY=
    export EC2_SECRET=
    export EC2_OWNER_ID=
    export EC2_SECURITY_GROUP=
    export EC2_KEY_PAIR=
    export EC2_BASE_AMI=ap-southeast-1/ami-cab1a298
    export EC2_INSTANCE_TYPE=t2.medium
    export EC2_REGION=ap-southeast-1
    export EC2_AVAILABILITY_ZONE_ID_1=ap-southeast-1a
    export EC2_AVAILABILITY_ZONE_ID_2=ap-southeast-1b
fi

export DB_USER_NAME=root
export DB_PASSWORD=root
export PUPPET_MASTER_IP=${PRIVATE_IP}
export MB_IP=${PRIVATE_IP}
export MB_PORT=1883
export PUPPET_MASTER_HOSTNAME=puppet.demo.ppaas.wso2.com

# Userstore DB settings
export UM_420_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/userstore_420
export REG_420_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/registry_420
export UM_44x_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/userstore_44x
export REG_44x_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/registry_44x

# APIM
export APIMGT_191_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/apim_191_mgt
export APIM_191_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_apim_191
export IS_500_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_is_500
export AS_521_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_as_521
export BPS_350_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_bps_350
export BPS_350_BPEL_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/bps_350_bpel
export BPS_350_ACTIVITI_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/bps_350_activiti
export BRS_210_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_brs_210
export DAS_300_ANALYTICS_FS_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/das_300_analytics_fs
export DAS_300_ANALYTICS_EVENT_STORE_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/das_300_analytics_event_store
export DAS_300_ANALYTICS_PROCESSED_DATA_STORE_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/das_300_analytics_processed_data_store
export DAS_300_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_das_300
export DSS_322_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_dss_322
export GREG_500_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_greg_500
export IS_500_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_is_500
export MB_300_CONFIG_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/config_db_mb_300
export MB_300_METRICS_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/mb_300_metrics
export MB_300_STORE_DB_URL=jdbc:mysql://${PRIVATE_IP}:3306/mb_300_store

# PPaaS monitoring and metering with DAS 3.0.0
export PPAAS_DAS_METERING_URL=https://${PUBLIC_IP}:9444/portal/dashboards/ppaas-metering-dashboard
export PPAAS_DAS_MONITORING_URL=https://${PUBLIC_IP}:9444/portal/dashboards/ppaas-monitoring-dashboard
export PPAAS_DAS_300_ANALYTICS_FS_DB_URL=jdbc:mysql://localhost:3306/ppaas_das_300_analytics_fs
export PPAAS_DAS_300_ANALYTICS_EVENT_STORE_DB_URL=jdbc:mysql://localhost:3306/ppaas_das_300_analytics_event_store
export PPAAS_DAS_300_ANALYTICS_PROCESSED_DATA_STORE_DB_URL=jdbc:mysql://localhost:3306/ppaas_das_300_analytics_processed_data_store
export PPAAS_DAS_300_PORT_OFFSET=1

# Run the Python Configurator
python ./configurator.py
popd


if [[ $puppet_mode == "true" ]]; then
    pushd ${CARTRIDGES_REPO_PATH}/wso2am/1.9.1/template-module/
    mvn -q clean install
    cp target/wso2am-1.9.1-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2am191/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2am191/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2am191/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2am191/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2am191/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2as/5.2.1/template-module/
    mvn -q clean install
    cp target/wso2as-5.2.1-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2as521/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2as521/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2as521/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2as521/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2as521/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2bps/3.5.0/template-module/
    mvn -q clean install
    cp target/wso2bps-3.5.0-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2bps350/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2bps350/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2bps350/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2bps350/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2bps350/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2brs/2.1.0/template-module/
    mvn -q clean install
    cp target/wso2brs-2.1.0-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2brs210/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2brs210/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2brs210/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2brs210/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2brs210/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2das/3.0.0/template-module/
    mvn -q clean install
    cp target/wso2das-3.0.0-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2das300/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2das300/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2das300/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2das300/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2das300/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2dss/3.2.2/template-module/
    mvn -q clean install
    cp target/wso2dss-3.2.2-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2dss322/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2dss322/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2dss322/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2dss322/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2dss322/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2esb/4.8.1/template-module/
    mvn -q clean install
    cp target/wso2esb-4.8.1-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2esb481/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2esb481/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2esb481/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2esb481/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2esb481/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2greg/5.0.0/template-module/
    mvn -q clean install
    cp target/wso2greg-5.0.0-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2greg500/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2greg500/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2greg500/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2greg500/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2greg500/plugins/
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2is/5.0.0/template-module/
    mvn -q clean install
    cp target/wso2is-5.0.0-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2is500/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2is500/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2is500/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2is500/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2is500/plugins/

    # WSO2 IS as Key Manager
    cp target/wso2is-5.0.0-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2isaskm500/packs/
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2isaskm500/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2isaskm500/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2isaskm500/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2isaskm500/plugins/
    popd

    pushd ${CARTRIDGES_REPO_PATH}/wso2mb/3.0.0/template-module/
    mvn -q clean install
    cp target/wso2mb-3.0.0-template-module-${VERSION}.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2mb300/packs/wso2mb-3.0.0-BETA-template-module-${VERSION}.zip
    cp ../plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2mb300/plugins/
    cp ../plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2mb300/plugins/

    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.py ${PUPPET_PATH}/modules/wso2installer/files/wso2mb300/plugins/
    cp ${CARTRIDGES_REPO_PATH}/common/plugins/*.yapsy-plugin ${PUPPET_PATH}/modules/wso2installer/files/wso2mb300/plugins/
    popd

    cp ${PACKS_PATH}/wso2ppaas-configurator-${VERSION}.zip ${PUPPET_PATH}/modules/configurator/files
    cp ${PACKS_PATH}/jdk-7u80-linux-x64.tar.gz ${PUPPET_PATH}/modules/java/files/
    cp ${PACKS_PATH}/apache-stratos-python-cartridge-agent-4.1.4.zip ${PUPPET_PATH}/modules/python_agent/files

    cp ${PACKS_PATH}/wso2am-1.9.1.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2am191/packs/
    cp ${PACKS_PATH}/wso2as-5.2.1.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2as521/packs/
    cp ${PACKS_PATH}/wso2bps-3.5.0.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2bps350/packs/
    cp ${PACKS_PATH}/wso2brs-2.1.0.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2brs210/packs/
    cp ${PACKS_PATH}/wso2das-3.0.0.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2das300/packs/
    cp ${PACKS_PATH}/wso2dss-3.2.2.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2dss322/packs/
    cp ${PACKS_PATH}/wso2esb-4.8.1.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2esb481/packs/
    cp ${PACKS_PATH}/wso2greg-5.0.0.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2greg500/packs/
    cp ${PACKS_PATH}/wso2isaskm/wso2is-5.0.0.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2isaskm500/packs/

    #cp ${PACKS_PATH}/wso2is-5.0.0.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2is500/packs/
    cp ${PACKS_PATH}/wso2isaskm/wso2is-5.0.0.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2is500/packs/
    cp ${PACKS_PATH}/wso2mb-3.0.0-BETA.zip ${PUPPET_PATH}/modules/wso2installer/files/wso2mb300/packs/
fi
