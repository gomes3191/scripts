#!/bin/bash
# Shell script to backup MySQL database
# Criado por: Francisco Gomes | gomes.tisystem@gmail.com

#crontab -e
# Execução 1 | 07:10
#10 07 * * * betad683 cd /home/betad683/; /bin/bash bkp_bancos.sh

# Execução 2 | 12:10
#10 12 * * * betad683 cd /home/betad683/; /bin/bash bkp_bancos.sh

# Execução 3 | 20:10
#10 20 * * * betad683 cd /home/betad683/; /bin/bash bkp_bancos.sh

# Setando variáveis
MyUSER=""	# DB_USERNAME
MyPASS=""	# DB_PASSWORD
MyHOST="localhost"	# DB_HOSTNAME

# Destino do backup
DEST="/home/betad683/dumps_bkp/" # /home/username/backups/DB

# E-mail a ser notificado
EMAIL="gomes.tisystem@gmail.com"

# Armazena o número de dias, para que os backups antigos possa ser removido após essa data
DAYS=3

# Linux bin paths
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"

# Pega hora minutos e dia Formato 00h00m_dd
NOW=`date +%Hh%Mm_%a`
# Create Backup sub-directories

install -d $DEST

# Lista de bancos a ignorar
SKIP="information_schema another_one_db betad683_teste01"

# Pega todas as bases de dados do MySQL
DBS="$($MYSQL -h $MyHOST -u $MyUSER -p$MyPASS -Bse 'show databases')"

# Condição que efetua o dump das base de dados
for db in $DBS
do
    skipdb=-1
    if [ "$SKIP" != "" ];
    then
		for i in $SKIP
		do
			[ "$db" == "$i" ] && skipdb=1 || :
		done
    fi
    
    if [ "$skipdb" == "-1" ] ; then
        # Configura o caminho e o nome das base de dados
    	FILE="$DEST/${db}_${NOW}.sql"

	    $MYSQLDUMP -h $MyHOST -u $MyUSER -p$MyPASS $db > $FILE
    fi
done

# Efetua a compactação dos sql em um único arquivo
cd $DEST

tar -cf $NOW.tar *.sql

$GZIP -9f $NOW.tar

chmod 775 $NOW.tar.gz

# Envia o E-mail para o remetente seguido do anexo via mutt
echo "Segue em anexo o backup: ${NOW}.tar.gz | Efetuado as: `date +%Hh%Mm`" | mutt -s "Aviso de backup" $EMAIL -a "${DEST}${NOW}.tar.gz"

# remove os sql após a compactação
rm -rf *.sql

# Remove backup antigos após um certo período de tempo
# find $DEST -mtime +$DAYS -exec rm -f {} \;
