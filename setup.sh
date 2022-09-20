#!/bin/bash

verbose=""
if [ $3 = true ] 
then
 verbose="-v"
fi


# fail if both passwords are set
pwd1=`echo $1 | jq -r .password`
pwd2=`echo $2 | jq -r .password`

if ([ -v "$pwd1" ] || [ ! "$pwd1" = "null" ]) && ([ -v "$pwd2" ] || [ ! "$pwd2" = "null" ])
then 
    echo "SCP with remote source and target using password not supported. Two step process is required with copying file to local first."
    exit 1
fi



mkdir -p .ssh && chmod 700 .ssh
touch .ssh/config
chmod 600 .ssh/config

handle() {

    # if there is a remote set    
    host=`echo $1 | jq -r .host`
    scp=""
    full=""

    if [ ! -z "$host" ] | [ ! "$host" = "null" ]
    then

        # write identify file
        port=`echo $1 | jq -r .port`
        if [ -z "$port" ] | [ "$port" = "null" ]
        then
            port=22
        fi

        user=`echo $1 | jq -r .user`
        printf "Host $2\n   Hostname $host\n   Port $port\n   User $user\n" >> .ssh/config

        # write identity file if attached
        identity=`echo $1 | jq -r .identity`
        if [ ! -z "$identity" ] | [ ! "$identity" = "null" ]
        then
            i=`echo $1 | jq -r .identity`
            printf -- "$i"  > .ssh/$2.pem
            printf "   IdentityFile .ssh/$2.pem\n" >> .ssh/config
            chmod 400 .ssh/$2.pem
        fi
        printf "\n" >> .ssh/config

        scp="scp://$2/"
        full="scp://$user@$host:$port/"
    fi

    # get file path
    file=`echo $1 | jq -r .file`

    echo "$scp$file" "$full$file"

}

# read shortcut and full url for logging
read var1 var2 < <(handle "$1" host1) 
read var3 var4 < <(handle "$2" host2) 

echo "copying from $var2 to $var4"

# check if one has a password
if [ -v "$pwd1" ] || [ ! "$pwd1" = "null" ]
then 
    sshpass -p "$pwd1" scp $verbose -o StrictHostKeyChecking=accept-new -F .ssh/config $var1 $var3
elif [ -v "$pwd2" ] || [ ! "$pwd2" = "null" ]
then
    sshpass -p "$pwd2" scp $verbose -o StrictHostKeyChecking=accept-new -F .ssh/config $var1 $var3
else
    scp $verbose -o StrictHostKeyChecking=accept-new -F .ssh/config $var1 $var3
fi



