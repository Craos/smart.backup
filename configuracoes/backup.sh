#!/bin/bash

data=`date '+%Y-%m-%d'`
destino_htdocs=/craos/onedrive/backups/clientes/anima/htdocs
destino_config=/craos/onedrive/backups/clientes/anima/config

echo "Backup dos arquivos de configuração"
cp /etc/samba/smb.conf $destino_config
cp /etc/passw* $destino_config
cp -rf /opt/lamp/apache2/conf/ $destino_config/apacheconf
cp /var/lib/pgsql/data/pg_hba.conf $destino_config
cp /var/lib/pgsql/data/postgresql.conf $destino_config
cp -rf /craos/api $destino_config

echo "Backup dos arquivos do sistema"
tar -cvzf $destino_htdocs/htdocs.tar.gz /opt/lamp/apache2/htdocs/ | split -b 1GB -d - "htdocs-"