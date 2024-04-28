
chgrp -R oinstall /u01
chmod g+s /u01
mkdir -p /u01/app/oracle
mkdir -p /u01/app/oraInventory
chmod -R 775 /u01
chown -R oracle:oinstall /u01/app/oracle
chown -R oracle:oinstall /u01/app/oraInventory

