
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