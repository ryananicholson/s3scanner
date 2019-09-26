#!/bin/bash

function usage {
    echo "USAGE: s3scanner.sh <file-with-bucket-names>"
    exit 1
}

if [ -z "$1" ]; then
    usage
fi

if ! [ -f $1 ]; then
    usage
fi

for i in $(cat $1); do
    CODE=$(curl -o /dev/null --silent --head --write-out '%{http_code}' http://$i.s3.amazonaws.com)
    if [[ $CODE == "200" ]]; then
        echo "$i.s3.amazonaws.com is public!"
    fi
done
