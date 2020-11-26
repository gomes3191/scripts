#!/bin/sh
# bkp_seubanco.sh

#  crontab -e
# 10 08 * * * /home/user-adm/banco_bkp.sh
# 10 12 * * * /home/user-adm/banco_bkp.sh
# 10 17 * * * /home/user-adm/banco_bkp.sh

# DATA vai imprimir a data no estio dia-mes-ano
DATA=`/bin/date +%Hh-%Mm-%a`

# NOME armazena o nome do arquivo de backup e
# o diretorio onde o arquivo será salvo no meu caso
# /www/virtual/backup é uma pasta publica do apache,
# coloque o diretório onde quer guardar o backup.

NOME="/home/user-adm/backup_db/gerenciador-$DATA.sql"

# variaveis do MySQL
HOST="localhost"
USER="root"
PASSWORD="123456"
DATABASE="gerenciador"

echo “Realizando Dump MYSQL”

mysqldump -h $HOST -u $USER -p$PASSWORD $DATABASE > $NOME


#cd /backup

#tar -zcvf meubanco-$DATA.tar.gz meubanco-$DATA.sql

#sshpass -p 'zaq1xsw2' scp /home/redmine/backup/redmine_production-$DATA.sql root@10.67.198.230:/root/backup_redmine

#backup incremental

#cp -rp -u /var/www /backup/wwww

#compactar arquivos www

#DATA=`/bin/date +%Y%m%d`

#DIR_ORIG=”/backup/www”
#DIR_DEST=”/backup/”
#BKP_NAME=”php-$DATA.tar.gz”

# compactação do diretório de origem diretamente no diretório de destino
#tar -czpf ${DIR_DEST}${BKP_NAME} ${DIR_ORIG}

#scp -i /root/.ssh/id_rsa /backup/php-$DATA.tar.gz root@192.168.0.241:/arquivos/pasta

#excluir arquivos sql para diminuir espaço em disco

#rm /backup/*.sql

# mensagem de resultado
echo “Seu backup foi realizado com sucesso.”
