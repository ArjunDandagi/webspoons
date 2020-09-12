# Task-2

## required Tools: 
`terraform version 0.12.x `(0.12.29 is what i used)


# Issues faced:

This is particulary sad 
```
>>> curl  tf-lb-20200912072538825000000001-1573979322.us-east-1.elb.amazonaws.com 
Warning: Binary output can mess up your terminal. Use "--output -" to tell 
Warning: curl to output it to your terminal anyway, or consider "--output 
Warning: <FILE>" to save to a file.

# but this shows the server infact is returning text/html
curl  -v tf-lb-20200912072538825000000001-1573979322.us-east-1.elb.amazonaws.com
*   Trying 107.20.106.153...
* TCP_NODELAY set
* Connected to tf-lb-20200912072538825000000001-1573979322.us-east-1.elb.amazonaws.com (107.20.106.153) port 80 (#0)
> GET / HTTP/1.1
> Host: tf-lb-20200912072538825000000001-1573979322.us-east-1.elb.amazonaws.com
> User-Agent: curl/7.64.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< Content-Encoding: gzip
< Content-Type: text/html
< Date: Sat, 12 Sep 2020 07:47:56 GMT
< ETag: W/"5f5c78af-2f"
< Last-Modified: Sat, 12 Sep 2020 07:28:47 GMT
< Server: nginx/1.18.0 (Ubuntu)
< Content-Length: 64
< Connection: keep-alive
< 
Warning: Binary output can mess up your terminal. Use "--output -" to tell 
Warning: curl to output it to your terminal anyway, or consider "--output 
Warning: <FILE>" to save to a file.
* Failed writing body (0 != 64)
* Closing connection 0
```
I am still digging on that one 


## NOTES (To: Reviewer):
 
my curl version on mac = `curl 7.64.1`

I tried it on one of the ec2 it worked perfectly fine:
the curl version in that vm is `curl 7.68.0`

i see nginx uses gzip on by default. again here they dont normally apply 
on text/html as i have read it 

```
gzip on;

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
```

I have made use of a public module to quickly get the solution. but doing so landed me in understanding the module itself indepth.


# Infra:
you can destroy and recreate, no harm.
but the infra is already up and running with 4 t2.micro nodes(hence HA in region)

```
terraform init 
terraform plan 
terraform apply --auto-approve #dont use this flag if you want to see and then approve manually
```
