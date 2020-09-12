# Task-5

## read replica

1. Data source is used to point to the DB created in task-4
2. db_instance with replicate_source_db is created so the slave is ready with read only replica

## how to read from read replica while write goes to master?
There is no magic bullet; you have an endpoint for the master db and an endpoint for EACH read replica.
You have to account for this in your application code, i.e. have a pool of read DB connections that point to your read replicas
 and a pool of write DB connections that point to your master db. In your application code, when you are doing reads, you use the read connection and writes, the master connection.

though we can to some extent have a single endpoint for mulitple read-replicas using route53 

