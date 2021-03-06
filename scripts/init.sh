#!/bin/bash
SCRIPTS_PATH=/home/ubuntu/scripts
PACKS_PATH=/home/ubuntu/packs
HOST_IP="localhost"
HOST_PORT=9443
PPAAS_VERSION=4.1.1

echo "Initializing WSO2 PPaaS $PPAAS_VERSION Demo Instance..."

mkdir -p /tmp/payload
wget http://instance-data/latest/user-data -O /tmp/payload/launch-params

# Add a trailing comma to get the last key val pair
echo "," >> /tmp/payload/launch-params

echo "Exporting user data as environmental variables..."
pushd /tmp/payload
cat launch-params | sed -n 1'p' | tr ',' '\n' | while read word; do
   if [[ ! -z "$word" ]] ; then
      echo "Property line = $word"
      KEY=`echo $word | cut -d "=" -f 1`
      VAL=`echo $word | cut -d "=" -f 2`   
      echo "KEY=$KEY VAL=$VAL"
      echo "export $KEY=$VAL" >> /tmp/payload/set-env.sh
   fi
done
popd

if [[ $1 == "clean" ]] ; then

   # clean /opt/ dir
   sudo rm -rf /opt/wso2ppaas-$PPAAS_VERSION/
   sudo rm -rf /opt/wso2das-3.0.0/
   sudo rm -rf /opt/apache-stratos-nginx-extension-4.1.5/
   sudo rm -rf /opt/apache-activemq-5.12.0/

   unzip -q $PACKS_PATH/wso2ppaas-$PPAAS_VERSION.zip -d /opt
   unzip -q $PACKS_PATH/wso2das-3.0.0.zip -d /opt
   unzip -q $PACKS_PATH/apache-stratos-nginx-extension-4.1.5.zip -d /opt
   tar -zxf $PACKS_PATH/apache-activemq-5.12.0-bin.tar.gz -C /opt   
fi

echo "Deploying packs and template modules..."
source /tmp/payload/set-env.sh
source $SCRIPTS_PATH/deploy-packs-and-template-modules.sh

echo "Starting ActiveMQ..."
/opt/apache-activemq-5.12.0/bin/activemq start

echo "Starting WSO2 DAS 3.0.0..."
/opt/wso2das-3.0.0/bin/wso2server.sh start
sleep 1m

echo "Starting WSO2 PPaaS $PPAAS_VERSION..."
/opt/wso2ppaas-$PPAAS_VERSION/bin/wso2server.sh start

echo "Starting AWS Extension..."
pushd /opt/apache-stratos-nginx-extension-4.1.5/
sudo nohup ./bin/nginx-extension.sh > /opt/apache-stratos-nginx-extension-4.1.5/nginx-extension.log 2>&1 &
popd

echo "Waiting for servers to be active..."
sleep 1m
response=$(curl -X GET -H "Content-Type: application/json" --write-out %{http_code} --silent --output /dev/null -k -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/users)
echo "Response received from Stratos API: $response"

while [ $response -ne 200  ] ; do
   response=$(curl -X GET -H "Content-Type: application/json" --write-out %{http_code} --silent --output /dev/null -k -u admin:admin https://${HOST_IP}:${HOST_PORT}/api/users)
   echo "Response received from Stratos API: $response"
   echo "Waiting for servers to be active..."
   sleep 10   
done

echo "Deploying artifacts..."

$SCRIPTS_PATH/deploy-common.sh
$SCRIPTS_PATH/create-apim-191.sh
$SCRIPTS_PATH/create-as-521.sh
$SCRIPTS_PATH/create-bps-350.sh
$SCRIPTS_PATH/create-brs-210.sh
$SCRIPTS_PATH/create-das-300.sh
$SCRIPTS_PATH/create-dss-322.sh
$SCRIPTS_PATH/create-esb-481.sh
$SCRIPTS_PATH/create-greg-500.sh
$SCRIPTS_PATH/create-is-500.sh
$SCRIPTS_PATH/create-mb-300.sh
$SCRIPTS_PATH/create-cep-400.sh
$SCRIPTS_PATH/create-esb-490.sh
$SCRIPTS_PATH/create-greg-510.sh
$SCRIPTS_PATH/create-as-530.sh

echo "End of init script"
