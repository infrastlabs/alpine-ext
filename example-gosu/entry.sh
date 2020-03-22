#!/usr/bin/env bash
echo $@

function test_gosu_usage(){
    #scripts to run
    file=/tmp/gosu-root.sh
cat > $file <<EOF
echo "--test root's permission---"
ls -la /root          #test1
chown -R www:www /srv #test2

echo "--reset root's password---"
erpasswd root      #random password
epasswd root root  #set password to `root`

echo "--drop root's permision---"
gsc drop #drop root's permision
EOF
    chmod +x $file

    printf "\n>>gosu exec as root--------------------\n"
    gosu root bash -c $file && rm -f $file

    printf "\n>>Root's exec finished, Validate droped permission-----------------\n"
    gosu root ls -la /root
    gsc add entry #try grant root's permision for `entry`
}

test_gosu_usage()

exec /bin/bash