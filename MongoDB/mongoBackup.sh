#!/bin/bash

TIMESTAMP=`date +%F-%H%M`
MONGODUMP_PATH=`which mongodump`
MONGO_PATH=`which mongo`

# Defaults
BACKUPS_DIR="./"
ADMIN_DATABASE="admin"
AUTHENTICATION=""
REMOTE=""

echo 'Enter a project alias for dump file:'
read project_name

BACKUP_NAME="$project_name-$TIMESTAMP"

echo 'Is it a (l)ocal or (r)emote mongo instance:'
read where
if [[ $where == "r" ]]
then
    read -p 'MongoDB HOST: ' host
    read -p 'MongoDB PORT: ' port
    REMOTE="--host $host --port $port"
fi

echo 'Does your database requires authentication (y)/(n)'
read authentication
if [[ $authentication == "y" ]]
then
    read -p 'MongoDB USER: ' user
    read -s -p 'MongoDB PASSWORD: ' password
    printf "\n"
    read -p 'MongoDB ADMIN DATABASE (admin): ' admin_database

    if [[ -n $admin_database ]]
    then
        ADMIN_DATABASE=$admin_database
    fi

    AUTHENTICATION="--username $user --authenticationDatabase $ADMIN_DATABASE --password $password"
fi

mkdir mongo_dump
cd mongo_dump

databases=`$MONGO_PATH $AUTHENTICATION $REMOTE --eval "db.getMongo().getDBNames()" | grep '"' | tr -d '",[]' `
echo "Databases: "
echo "$databases"

for database in $databases; do
    $MONGODUMP_PATH $AUTHENTICATION $REMOTE --archive=$database-$BACKUP_NAME -d $database
done

cd ..
tar -czvf dump-$BACKUP_NAME.tar.gz mongo_dump
rm -rf mongo_dump
