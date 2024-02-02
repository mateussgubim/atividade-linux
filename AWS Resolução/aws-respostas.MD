
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

<img src="/atividade-prints/criando-chave.png" alt="Criando a chave de acesso" />

## Criando o script para user data
Esse script será utilizado na criação da instância. Seu objeto é realizar a atualização do sistema, instalar e executar o serviço do apache.

A sua criação pode ser realizada em qualquer diretório, pois iremos importá-lo depois para a instância.
> nano script.txt
>
> > #!/bin/bash
> 
> > yum install httpd -y
> 
> > service httpd start
> 
> > chkconfig httpd on

## Criando a instância