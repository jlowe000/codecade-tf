# this is a placeholder to put the scripts required to bootstrap the compute
useradd oracle
yum install -y git
yum install -y python3-pip
yum install -y python36-oci-cli
yum install -y oracle-instantclient18.3-sqlplus
mkdir /home/oracle/.oci
mv /tmp/terraform_api_public_key.pem /home/oracle/.oci
mv /tmp/terraform_api_key.pem /home/oracle/.oci
mv /tmp/config /home/oracle/.oci
chown -R oracle:oracle /home/oracle/.oci
chmod 600 /home/oracle/.oci/terraform_api_key.pem
mkdir /home/oracle/wallet
mv /tmp/codecard-wallet.zip /home/oracle/wallet
chown -R oracle:oracle /home/oracle/wallet