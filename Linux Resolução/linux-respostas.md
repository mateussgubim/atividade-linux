
# Resolução

## Criando o NFS
```
aws efs create-file-system
--creation-token atividade-token
--performance-mode generalPurpose
```

<img src="/atividade-prints/criando-efs.png" alt="Criando EFS." />

## Anexando o NFS a uma instância
O comando abaixo retornará os IDs das instâncias atuais, basta copiar o ID da instância desejada.

`aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId'`

O comando abaixo retornará os IDs dos EFSs ativos.

`aws efs describe-file-systems --query 'FileSystems[*].FileSystemId'`

`aws efs create-mount-target --file-system-id fsID --subnet-id ID --security-groups ID`

<img src="/atividade-prints/criando-target-efs.png" alt="Anexando o NFS à instância." />

## Montando o EFS automaticamente
Para realizar o mount do EFS, precisaremos do utilitário "amazon-efs-utils", que já foi instalado na criação da instância.

Basta apenas criar um diretório onde deseja que o EFS seja montado e os seguintes comandos:
```
mkdir /efs
sudo echo "fs-05bdb98d91eaae644.efs.amazonaws.com:/ /efs nfs defaults 0 0" >> /etc/fstab
sudo mount -a
```

Isso permitirá que o EFS seja montado automaticamente ao iniciar o sistema.
<img src="/atividade-prints/mount-auto.png" alt="Montando o EFS." />


## Criar um diretório dentro do FS com seu nome
<img src="/atividade-prints/criand-diretorio.png" alt="Criando um diretório com o meu nome." />

## Subir um apache no servidor - o apache deve estar online e rodando
Como o apache foi instalado junto com a instância, basta apenas verificar se ele está executando normalmente, para isso usaremos o comando:
`systemctl status httpd`

Como não veio um arquivo index.html no diretório do apache, criaremos um, adicionaremos o boilerplate padrão e uma mensagem informando que o serviço está ativo e funcionando:
`nano /va/www/html/index.html`

<img src="/atividade-prints/create-index.png" alt="Criando o arquivo index.html." />

Para comprovarmos que o apache está rodando, basta conectarmos ao Elastic IP da nossa instância.

<img src="/atividade-prints/site-up.png" alt="Confirmando que o apache está funcionando" />

## Criando um script para verificar se o serviço está ativo
O script tem uma função muito simple, primeiro verificará se o serviço "httpd" está com o status "active"; independente do resultado, ele armazenará uma mensagem personalizada em um arquivo de log, sendo um arquivo para ativo e outro para inativo.

Por uma questão de organização será criada uma pasta no diretório / para armazenar o script. O script será criado da seguinte maneira:

`nano check_apache.sh`

```
#!/usr/bin/env bash

# VERIFICA QUE O SERVIÇO HTTPD ESTÁ SENDO EXECUTADO, APÓS ISSO ENVIA O RESULTADO PARA UM ARQUIVO DE LOG.

# DEFININDO VARIÁVEIS

SERVICE="httpd"
ISACTIVE=$(systemctl is-active $SERVICE)
HOUR=$(TZ="America/Sao_Paulo" date +"%H:%M:%S")
DATE=$(date +"%d/%b/$Y")

# VERIFICANDO SE O SERVIÇO ESTÁ ATIVO E ENVIANDO A SAÍDA PARA O ARQUIVO DE LOG

if [ $ISACTIVE == "active" ]
then
    	STATUS="O httpd ESTÁ ATIVO"
        echo "$STATUS | $HOUR - $DATE" > /efs/mateus/serviceup.txt
else
    	STATUS="$SERVICE ESTÁ INATIVO"
        echo "$STATUS | $HOUR - $DATE" > /efs/mateus/servicedown.txt
fi
```
Permitindo a execução do script: `chmod +x check_apache.sh`

<img src="/atividade-prints/apache_script_perm.png" alt="Permitindo a execução, executando e mostrando o resultado" />

## Execução automatiza do script a cada 5 min
Para essa tarefa, será utilizado um agendador de tarefas chamado cron. 

O crontab possui seis colunas, que correspondem aos minutos, horas, dias, meses, semanas e, no final, os comandos que serão executados.

As tabelas de um usuário ficam armazenadas no diretório `/var/spool/cron/crontab`, e os agendamentos globais ficam armazenados no arquivo `/etc/crontab`.

O comando abaixo será executado com o usuário root, esse comando fará com que o script seja executado a cada cinco minutos.

```
crontab -e
*/5 * * * * /scripts/check_apache.sh
```