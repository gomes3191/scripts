#!/bin/bash
clear
echo -n "Digite o nome do usuário: "
read us

# Verifica se usuário existe
#teste=$(grep -w ^$us /etc/passwd | cut -d: -f 1)
if id -u $us > /dev/null 2>&1; then
    echo "----------Informações do usuário $us----------------------------"
    echo "Login de usuário:  $us "
    echo "Nome do usuário:  $(cat /etc/passwd |grep ^$us | cut -d : -f 5|cut -d , -f 1)"
    echo "O UID do $us é:  $(id -u $us)"
    echo "O GID do $us é:  $(id -g $us)"
    echo "O GID é:  $(id -gn $us)"
    echo "O diretorio pessoal do $us é:  $(cat /etc/passwd |grep ^$us | cut -d : -f 6)"
    echo "O Pid é:  $$"
    echo "grupos:  $(id -Gn $us)"
    echo "grupos  $(id -G $us)"
    echo "Camando  $0"
    echo "----------------------Fim informações de $us---------------------"

sudo usermod -a -G $us www-data
sudo usermod -a -G www-data $us

#Mudar a permissão da pasta 
sudo rm -rv /var/www/*
sudo ln -s ~/development/glinic /var/www/
sudo chmod 4775 -R /var/www
sudo chown www-data:$us -R /var/www

sudo chmod 4775 -R $(cat /etc/passwd |grep ^$us | cut -d : -f 6)/development
sudo chown www-data:$us -R $(cat /etc/passwd |grep ^$us | cut -d : -f 6)/development
   
# se usuário não existir faz isso
else
diretorio=$(dirname "$0")
 echo "ERRO!"
    echo
    echo "Parametro invalido!!!"
    echo "Aguarde..."
    sleep 2
    /bin/bash ~/autoconfig.sh
fi
