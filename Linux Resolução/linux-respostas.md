
# Resolução

## Criando o NFS
> aws efs create-file-system
> 
> --creation-token atividade-token
> 
> --performance-mode generalPurpose

<img src="/atividade-prints/criando-efs.png" alt="Criando EFS." />

## Anexando o NFS a uma instância
O comando abaixo retornará os IDs das instâncias atuais, basta copiar o ID da instância desejada.

> aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' 
> 
O comando abaixo retornará os IDs dos EFSs ativos
> aws efs describe-file-systems --query 'FileSystems[*].FileSystemId'
> 
> aws efs create-mount-target --file-system-id fsID --subnet-id ID --security-groups ID

<img src="/atividade-prints/criando-target-efs.png" alt="Anexando o NFS à instância." />

## Montando o EFS automaticamente
Para realizar o mount do EFS, precisaremos do utilitário "amazon-efs-utils", que já foi instalado na criação da instância.

Basta apenas criar um diretório onde deseja que o EFS seja montado e os seguintes comandos:
> mkdir /efs
> 
> sudo "fs-05bdb98d91eaae644.efs.amazonaws.com:/ /efs nfs defaults 0 0" >> /etc/fstab
>
> sudo mount -a

Isso permitirá que o EFS seja montado automaticamente ao iniciar o sistema.
<img src="/atividade-prints/mount-auto.png" alt="Montando o EFS." />


## Criar um diretório dentro do FS com seu nome
<img src="/atividade-prints/criand-diretorio.png" alt="Criando um diretório com o meu nome." />

## Subir um apache no servidor - o apache deve estar online e rodando
Como o apache foi instalado junto com a instância, basta apenas verificar se ele está executando normalmente, para isso usaremos o comando:
> systemctl status httpd

Como não veio um arquivo index.html no diretório do apache, criaremos um, adicionaremos o boilerplate padrão e uma mensagem informando que o serviço está ativo e funcionando:
> nano /var/www/html/index.html

<img src="/atividade-prints/create-index.png" alt="Criando o arquivo index.html." />

Para comprovarmos que o apache está rodando, basta conectarmos ao Elastic IP da nossa instância.

<img src="/atividade-prints/site-up.png" alt="Confirmando que o apache está funcionando" />
