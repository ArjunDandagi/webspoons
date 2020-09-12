# Task-3 


## solution approach 
Route53 -> us-east-1 DNS
        -> us-west-2 DNS
I would create a hosted Zone with registering a Domain to serve the customer like this 

since the billing didnt allow me request a domain name. 

I am partially creating two stack in two different region
output:
```
us-east-dns = tf-lb-20200912130640827600000001-49299620.us-east-1.elb.amazonaws.com
us-west-dns = tf-lb-20200912131812801700000001-1321873644.us-west-2.elb.amazonaws.com
```

Note:
AWS has expanded its infra and have added many components to its AZs 
this command was needed for me to filter the AZs that we wont use when crating a web infra
   `aws ec2 describe-availability-zones --region us-west-2 --all-availability-zones`

