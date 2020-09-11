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
The output will show the `public_ip` you need to hit 
i have deployed it already 
so you can peek inside terraform.tfstate 
or just 

`cat terraform.tfstate |  jq -r .outputs.public_ip.value`


#VEGETA? 
Install on mac: `brew install vegeta`

I didn't know this tool , it looks cool :)
```
example:
  cd task-1
  host="$(cat terraform.tfstate | jq -r .outputs.public_ip.value)"~~~~
  echo "GET http://$host" | vegeta attack -duration=5s | tee results.bin | vegeta report
  vegeta report -type=json results.bin > metrics.json
  cat results.bin | vegeta plot > plot.html
  cat results.bin | vegeta report -type="hist[0,100ms,200ms,300ms]"
```