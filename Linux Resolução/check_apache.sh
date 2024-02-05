#!/usr/bin/env bash

# VERIFICA QUE O SERVIÇO HTTPD ESTÁ SENDO EXECUTADO, APÓS ISSO ENVIA O RESULTADO PARA UM ARQUIVO DE LOG.

# DEFININDO VARIÁVEIS

SERVICE="httpd"
ISACTIVE=$(systemctl is-active $SERVICE)
HOUR=$(date +"%H:%M:%S")
DATE=$(date +"%d/%b/$Y")

# VERIFICANDO SE O SERVIÇO ESTÁ ATIVO E ENVIANDO A SAÍDA PARA O ARQUIVO DE LOG

if [ $ISACTIVE == "active" ]
then
    	STATUS="O httpd ESTÁ ATIVO"
        echo "$STATUS | $HOUR - $DATE" >> /efs/mateus/serviceup.txt
else
    	STATUS="$SERVICE ESTÁ INATIVO"
        echo "$STATUS | $HOUR - $DATE" >> /efs/mateus/servicedown.txt
fi
