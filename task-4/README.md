# Task-4


## Storing Passwords in DB
1. Don't store them as plain text , no  - A strict No
2. base64 is encoding not encryption you can easily look and decode it back
3. using a Hashing is good. but what if users use most common password?
    solutions:
    3.1 enforce the user to have a minimum set of criteria to create a password when they create account
    3.2 use point #4
4. Use a Salt and Hash method: to randomize storing the password

more:<br/>
[GeeksForGeeks](https://www.geeksforgeeks.org/store-password-database/) <br/>
[Naked Security](https://nakedsecurity.sophos.com/2013/11/20/serious-security-how-to-store-your-users-passwords-safely/)

## Attack Surface / mitigations

[GruntWork Blog](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1)

surface:
1. DB is not n/w secure - i havent create a subnet / vpc in any of the solutions to simply make use of default vpc resources
this is a neat surface for attack . everything in default vpc is public by default 

2. The DB is allowed from entire world 0.0.0.0/0

3. DB can get overloaded with limit of requests and hence become unresponsive

4. DB can become choice of attack with new vulns found in mysql 5.7 

Mitigation:
1. should have deployed a private SUbnet with vpc and NACL to secure connection only
2. should have made use of security group ids to limit the connection to private ips within
3. choose a fairly larger instance at first to not overwhelm server and then migrate to bigger / scale out 
4. Apply patch immediately whenever one is avaialable from mysql community


## DB choice justification
The question hints about the data type its going to use creation of users 
and the details specific to them. this seems like a requirement knowns scenario
where you are aware of the data you feed into the system and it hardly changes.

A schema of such requirement is greatly a fit for Relational Databases

I have chosen Mysql as the DB here  for that reason 

how does it compare to others?
1. widely used RDBMS solution with great community support 
2. can easily migrate to a managed solution by cloud providers
3. ACID properties in a RDBMS solution


## Backup Strategy
1. you can enable point in snapshot 
2. manual snapshots 
3. backup and migrate to different region also is support in managed RDS

## connecting to DB
a terminal based connection will look like this
`mysql -u webspoons -h terraform-20200912103843804200000001.cku8b705dcrd.us-east-1.rds.amazonaws.com -p`
figure out a password :) its there somewhere here ( yeah for this reason s3 is best to store "that" file)


## version selected 
[Known issues](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MySQL.KnownIssuesAndLimitations.html)