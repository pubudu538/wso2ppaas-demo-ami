#!/bin/bash
SCRIPTS_PATH=/home/ubuntu/scripts
PACKS_PATH=/home/ubuntu/packs
SAMPLES_PATH=/home/ubuntu/samples
CARTRIDGES_REPO_PATH=/home/ubuntu/wso2-repos/private-paas-cartridges.git


echo "Undeploying all artifacts..."
$SCRIPTS_PATH/undeploy-all.sh

echo "Stopping WSO2 PPaaS 4.1.0..."
/opt/wso2ppaas-4.1.0/bin/wso2server.sh stop

echo "Stopping WSO2 DAS 3.0.0..."
/opt/wso2das-3.0.0/bin/wso2server.sh stop

echo "Stopping nginx service..."
sudo nginx -s stop
sudo service nginx stop

echo "Stopping AWS Extension..."
ps -ef | awk '/stratos-nginx/ {print $2}' > /tmp/nginx-pids
echo "" >> /tmp/nginx-pids

cat /tmp/nginx-pids

cat /tmp/nginx-pids | while read word; do
   if [[ ! -z "$word" ]] ; then
      echo "Killing process with pid: $word"
      sudo kill -9 $word
   fi
done

echo "Stopping Apache ActiveMQ..."
/opt/apache-activemq-5.12.0/bin/activemq stop

echo "Cleaning temp..."
sudo rm -rf /tmp/*

echo "Cleaning samples..."
sudo rm -rf $SAMPLES_PATH/*

echo "Cleaning logs..."
sudo rm -rf /opt/wso2ppaas-4.1.0/repository/logs/*
sudo rm -rf /opt/wso2das-3.0.0/repository/logs/*
sudo rm /opt/apache-stratos-nginx-extension-4.1.4/*.log
sudo rm -rf /opt/logs


if [[ $1 == "clean" ]] ; then
   echo "Cleaning up deployment and redeploying packs..."
   # clean /opt/ dir
   sudo rm -rf /opt/wso2ppaas-4.1.0/
   sudo rm -rf /opt/wso2das-3.0.0/
   sudo rm -rf /opt/apache-stratos-nginx-extension-4.1.4/   
   sudo rm -rf /opt/apache-activemq-5.12.0/

   unzip -q $PACKS_PATH/wso2ppaas-4.1.0.zip -d /opt
   unzip -q $PACKS_PATH/wso2das-3.0.0.zip -d /opt
   unzip -q $PACKS_PATH/apache-stratos-nginx-extension-4.1.4.zip -d /opt   
   tar -zxf $PACKS_PATH/apache-activemq-5.12.0-bin.tar.gz -C /opt   


    pushd ${CARTRIDGES_REPO_PATH}/wso2am/1.9.1/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2as/5.2.1/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2bps/3.5.0/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2brs/2.1.0/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2das/3.0.0/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2dss/3.2.2/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2esb/4.8.1/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2greg/5.0.0/template-module/
    mvn -q clean
    popd


    pushd ${CARTRIDGES_REPO_PATH}/wso2is/5.0.0/template-module/
    mvn -q clean
    popd

    pushd ${CARTRIDGES_REPO_PATH}/wso2mb/3.0.0/template-module/
    mvn -q clean
    popd
fi

echo "End of destroy script"
