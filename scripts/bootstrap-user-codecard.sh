export USER_PWD=$1
shift
export ORDS_HOSTNAME=`echo $1 | cut -d "/" -f 3`
shift
export API_KEY_ENABLED=$1
shift
export BUCKET_NS=$1
shift
export GIT_REPO=$1
mkdir /home/oracle/repos
cd /home/oracle/repos/
git clone ${GIT_REPO}
pip3 install oci --user
cd /home/oracle/wallet/
unzip /home/oracle/wallet/codecard-wallet.zip
cd /home/oracle/repos/codecard-avatar
cat designer-database/schema.sql.template | envsubst > designer-database/schema.sql
echo "WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY=\"/home/oracle/wallet\")))" > /home/oracle/wallet/sqlnet.ora
echo "SSL_SERVER_DN_MATCH=yes" >> /home/oracle/wallet/sqlnet.ora
echo 'export BUCKET_NS=${BUCKET_NS}' >> ~/.bash_profile
echo 'export TNS_ADMIN=/home/oracle/wallet' >> ~/.bash_profile
echo 'export ORACLE_HOME=/usr/lib/oracle/18.3/client64' >> ~/.bash_profile
echo 'export LD_LIBRARY_PATH=${ORACLE_HOME}/lib' >> ~/.bash_profile
echo 'export PATH=${PATH}:${ORACLE_HOME}/bin' >> ~/.bash_profile
. ~/.bash_profile
exit | sqlplus admin/${USER_PWD}@codecard_low @ designer-database/schema.sql
exit | sqlplus admin/${USER_PWD}@codecard_low @ designer-database/init.sql
exit | sqlplus code_card/${USER_PWD}@codecard_low @ designer-database/tables.sql
exit | sqlplus code_card/${USER_PWD}@codecard_low @ designer-database/ords.sql
chmod 755 bin/*.sh
if [ "${API_KEY_ENABLED}" == "true" ]; then
  bin/codecard-designer-build.sh ${ORDS_HOSTNAME} ${BUCKET_NS}
fi
