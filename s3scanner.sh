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
    CODE=$(curl -I http://$i.s3.amazonaws.com 2>/dev/null | head -n1 | cut -d" " -f2)
    if [[ $CODE == "200" ]]; then
        echo "$i.s3.amazonaws.com is public!"
    fi
done
