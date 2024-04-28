/usr/sbin/groupadd -g 54327 asmdba
/usr/sbin/groupadd -g 54328 asmoper
/usr/sbin/groupadd -g 54322 dba
/usr/sbin/groupadd -g 54323 oper
/usr/sbin/groupadd -g 54324 backupdba
/usr/sbin/groupadd -g 54325 dgdba
/usr/sbin/groupadd -g 54326 kmdba
/usr/sbin/groupadd -g 54330 racdba
/usr/sbin/groupadd -g 54321 oinstall
/usr/sbin/useradd -u 54321 -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba oracle
/usr/sbin/usermod -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba,oper oracle
/usr/sbin/usermod -a -G oinstall,dba,asmdba,backupdba,dgdba,kmdba,racdba,oper kevin