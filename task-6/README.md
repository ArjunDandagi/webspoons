# Task-6 



## NOTES:
There is a opensource cluster setup if we have mysql instances (new to me)

[Galera](https://galeracluster.com/) <br/>



[Medium Blog](https://medium.com/@davidgurevich_11928/how-to-setup-mysql-master-master-replication-with-aws-rds-and-an-on-premises-server-d434fae824f8)

There is no default multi master setup in mysql RDS. we need to run commands inside mysql to achieve this
The medium blog actually explains about the onprem vm to mysql RDS
neverthless the solution should work with proper flags ,features enabled in both servers(/services)

steps:
1. RDS (task-4)(use aws console) -- > “auto_increment_increment” and “auto_increment_offset” are set to “2” and “1” respectively.

2. Create RDS read-only replica of the master ( task -5 )

3. Use a MySQL command line client to connect to the RDS master and run the following command:
   mysql> call mysql.rds_set_configuration(‘binlog retention hours’, 24);
 (RDS does not give root user access via the command line interface. So, you have to use these AWS commands instead of native MySQL.)
 
4. On RDS master create replication user:
   mysql> CREATE USER ‘replicator’@’%’ IDENTIFIED BY ‘replicator’;
   mysql> GRANT REPLICATION SLAVE ON *.* TO ‘replicator’@’%’;

5. Use a MySQL command line client to connect to the RDS read-only replica and run the following commands:
   mysql> call mysql.rds_stop_replication;
   mysql> SHOW SLAVE STATUS;

6. Save values of Exec_Master_Log_Pos and Relay_Master_Log_File.
   Run mysqldump from RDS slave replica (assume RDS replica IP address is 172.0.0.103 and IP address of the on-premises server is 10.0.0.101) and import the backup into the on-premises MySQL database:
   $ mysqldump –h172.0.0.103 –u root –p password --single-transaction --routines --triggers --databases test | mysql –h10.0.0.101 –u root –p password

7. Use MySQL command line client to connect to the server. Configure is as a slave of RDS master:
   mysql> CHANGE MASTER TO MASTER_HOST=’172.0.0.102', MASTER_USER=’replicator’, MASTER_PASSWORD=’replicator’, MASTER_LOG_FILE=’Relay_Master_Log_File’, MASTER_LOG_POS=Exec_Master_Log_Pos;
   
8. 