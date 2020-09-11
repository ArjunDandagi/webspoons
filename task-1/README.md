# Task-1

## Required Tools:
`Terraform version = 0.12.29` <br/>

get it from here  :<br/>
[Darwin](terraform_0.12.29_darwin_amd64.zip)
<br/>
[Linux](https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip)
<br/>
[windows](https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_windows_amd64.zip)

## Steps :
```
1. cd task-1
2. alias tf=terraform
2. tf init 
3. tf validate
4. tf plan  # make sure everything looks good 
5. tf apply --auto-approve
```

RESULT:<br/>
The output will show the `public_ip` you need to hit the ip in browser to see the website
i have deployed it already 
so you can peek inside terraform.tfstate 
or just run this command.

`cat terraform.tfstate |  jq -r .outputs.public_ip.value`


#VEGETA? 
Install on mac: `brew install vegeta`

I didn't know this tool , it looks cool :) . Be Nice , I just used t2.micro
```
example:
  cd task-1
  host="$(cat terraform.tfstate | jq -r .outputs.public_ip.value)"~~~~
  echo "GET http://$host" | vegeta attack -duration=5s | tee results.bin | vegeta report
  vegeta report -type=json results.bin > metrics.json
  cat results.bin | vegeta plot > plot.html
  cat results.bin | vegeta report -type="hist[0,100ms,200ms,300ms]"
```
I also explored this 
   `brew install hey`
   This is a sample run for the same server (I am in india , server in us-east-1)
```hey -c 1000 -q 100 -n 50000 http://52.206.131.240
   
   Summary:
     Total:	64.2879 secs
     Slowest:	8.1092 secs
     Fastest:	0.0462 secs
     Average:	1.2584 secs
     Requests/sec:	777.7508
     
     Total data:	2500000 bytes
     Size/request:	50 bytes
   
   Response time histogram:
     0.046 [1]	|
     0.853 [4283]	|■■■■
     1.659 [44500]	|■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
     2.465 [728]	|■
     3.271 [250]	|
     4.078 [213]	|
     4.884 [22]	|
     5.690 [2]	|
     6.497 [0]	|
     7.303 [0]	|
     8.109 [1]	|
   
   
   Latency distribution:
     10% in 0.8623 secs
     25% in 1.1112 secs
     50% in 1.2874 secs
     75% in 1.4082 secs
     90% in 1.5235 secs
     95% in 1.5654 secs
     99% in 2.0098 secs
   
   Details (average, fastest, slowest):
     DNS+dialup:	0.0057 secs, 0.0462 secs, 8.1092 secs
     DNS-lookup:	0.0000 secs, 0.0000 secs, 0.0000 secs
     req write:	0.0000 secs, 0.0000 secs, 0.0012 secs
     resp wait:	1.2526 secs, 0.0461 secs, 8.1092 secs
     resp read:	0.0000 secs, 0.0000 secs, 0.0020 secs
   
   Status code distribution:
     [200]	50000 responses

```   