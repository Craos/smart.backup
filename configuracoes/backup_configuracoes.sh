#!/bin/bash

data=`date '+%Y-%m-%d'`
destino=/craos/conf

cp /etc/samba/smb.conf $destino
cp /etc/passw* $destino
cp -rfv /opt/lamp/apache2/conf/ $destino/apacheconf
cp /var/lib/pgsql/data/pg_hba.conf $destino

tar -zcvf /craos/backups/conf-$data.tar.gz /craos/conf/