#!/bin/bash

destino=/craos/onedrive/backups/clientes/anima/
psql -h localhost -p 5432 -U postgres -w -d smt -t -A -f tabelas.sql > tabelas.txt

fileItemString=$(cat tabelas.txt | tr "\n" " ")
tabelas=($fileItemString)

for i in "${tabelas[@]}"; do
  echo "backup da tabela $i"

  cpulimit -l 20 -- \
    pg_dump \
    -f $destino$i.gz \
    -F t \
    -v \
    -C \
    -E UTF8 \
    -O \
    -t $i \
    --column-inserts \
    --inserts \
    -d smt \
    -h localhost \
    -p 5432 \
    -U postgres \
    -w
done

echo "Divide os arquivos acima de 1GB"

find $destino  -size +1G -exec ls -1  {} \+ > arquivos.log

listaarquivos=$(cat arquivos.log |tr "\n" " ")
lista=($listaarquivos)

for i in "${lista[@]}"
do
    echo "arquivo grande $i"
    nome=`basename -s .gz $destino$i`
    split -b 1GB -d $i $destino$nome && rm -rfv $i
done

onedrive --synchronize

echo "backup finalizado"
