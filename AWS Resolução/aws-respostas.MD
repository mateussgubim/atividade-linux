
# Resolução 

## Configurando as credenciais de usuário
> aws configure sso
> 
> SSO session name: xxx
> 
> SSO start url: xxx
> 
> SSO region: xxx
> 
> SSO registration scopes: enter

## Gerando uma chave de acesso para o ambiente
Uma chave pública é algo essencial para acessarmos remotamente nossa instância. Nos comandos abaixo, estaremos criando e definindo a permissão para a nossa chave.

> aws ec2 create-key-pair \
> 
> --key-name keyname \
> 
> --output text > keyname.pem \
> 
> --query 'KeyMaterial'
> 
> chmod 400 keyname.pem 

<img src="/atividade-prints/criando-chave.png" alt="Criando a chave de acesso." />

## Criando o script para user data
Esse script será utilizado na criação da instância. Seu objeto é realizar a atualização do sistema, instalar e executar o serviço do apache.

A sua criação pode ser realizada em qualquer diretório, pois iremos importá-lo depois para a instância.
> nano script.txt
>
> #!/bin/bash
> 
> yum install httpd -y
> 
> service httpd start
> 
> hkconfig httpd on

<img src="/atividade-prints/criando-script.png" alt="Criando a primeira parte do script." />


## Criando a instância
> aws ec2 run-instance \
> --image-id "id-da-imagem-da-instancia" \
> --count 1 \
> --instance-type "tipo-da-instancia" \
> --key-name nome-da-chave
> --security-group-ids "id-do-security-group" \
> --subnet-id "id-subnet" \
> --tag-specification 'ResourceType=instance,Tags=[{Key=Name,Value=value}] \

<img src="/atividade-prints/criando-instancia.png" alt="Criando a instância." />

## Criando e associando o elastic IP
O Elastic IP é um endereço IPv4 fixo que podemos utilizar para conectar a uma instância.
> aws ec2 allocate-address
> 
> aws ec2 associate-address ID-da-instancia --public-ip IP

<img src="/atividade-prints/criando-elastic-ip.png" alt="Criando o elastic IP." />

## Liberando as portas para acesso
<img src="/atividade-prints/portas.png" alt="Liberando as portas de acesso." />

## Conectando à instância
> ssh -i "local-da-chave" ec2-user@ec2-54-237-133-88.compute-1.amazonaws.com

<img src="/atividade-prints/conectando-instancia.png" alt="Conectado à instância." />
