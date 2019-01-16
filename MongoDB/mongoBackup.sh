#!/bin/bash

TIMESTAMP=`date +%F-%H%M`
MONGODUMP_PATH=`which mongodump`
MONGO_PATH=`which mongo`
BACKUPS_DIR="./"
ADMIN_DATABASE="admin"
AUTHENTICATION=""

echo 'Enter a project alias for dump file:'
read project_name

BACKUP_NAME="$project_name-$TIMESTAMP"

echo 'Is it a (l)ocal or (r)emote script:'
read where
if [ $where = 'r' ]
then
    read -p 'MongoDB HOST: ' host
    read -p 'MongoDB PORT: ' port
fi

echo 'Does your database requires authentication (y)/(n)'
read authentication
if [ $authentication = 'y' ]
then
    read -p 'MongoDB USER: ' user
    read -p 'MongoDB PASSWORD: ' password
    read -p 'MongoDB ADMIN DATABASE: (admin)' admin_database

    if [ $admin_database = '' ]
    then
        ADMIN_DATABASE=$admin_database
    fi


    AUTHENTICATION="--username $user --authenticationDatabase $ADMIN_DATABASE --password $password"
fi

mkdir mongo_dump
cd mongo_dump

databases=`$MONGO_PATH $AUTHENTICATION --eval "db.getMongo().getDBNames()" | grep '"' | tr -d '",' `

for database in $databases; do
    if [ $where = 'r' ]
    then
        $MONGODUMP_PATH $AUTHENTICATION --archive=$database-$BACKUP_NAME -h $host:$port -d $database
    else
        $MONGODUMP_PATH $AUTHENTICATION --archive=$database-$BACKUP_NAME -d $database
    fi
done

cd ..
tar -zcvf dump-$BACKUP_NAME.tgz mongo_dump
rm -rf mongo_dump
