#!/usr/bin/env bash
set +e

#etc
chmod u+s /bin/ping
echo "welcome to ct~ (alpine-ext: ${VER})" > /etc/motd
# echo -n "Kernel: "     >>/etc/motd
# uname -a               >>/etc/motd #TODO `uname -a`
sed -i 's^/root:/bin/ash^/root:/bin/bash^g' /etc/passwd #root use bash
echo "Defaults visiblepw" >> /etc/sudoers

#domain="mirrors.ustc.edu.cn"
domain="mirrors.aliyun.com"
echo "http://$domain/alpine/v3.8/main" > /etc/apk/repositories
echo "http://$domain/alpine/v3.8/community" >> /etc/apk/repositories

#xshell: grep gawk
#procps: free -h
#shadow: chpasswd jumpserver, expect<mkpasswd>
#tmux: libevent ncurses (2.7-VimEnter-err, by hand with low ver); compile with src: v2.3
#findutils: for k3s agent node.
#coreutils: base64 for secrets
#busybox-extras: telnet  ## nc -vzw 2 host port
apk add --no-cache \
ca-certificates tzdata curl wget \
sed grep gawk findutils sudo tree unzip procps htop \
expect shadow xterm bash bash-completion coreutils busybox-extras \
libevent ncurses openssl vim #git

TIMEZONE=Asia/Shanghai #ENV
ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

#bin1: gosu lrzsz tmux
chown root:root /usr/bin/gosu #
chmod 751 /usr/bin/rz && chmod 751 /usr/bin/sz

#bin2
mv /bin/sh /bin/busy_sh && ln -s /bin/bash /bin/sh #sh->bash
dir=/usr/bin
mv $dir/vi $dir/busy_vi && ln -s $dir/vim $dir/vi

#dotfiles
mkdir -p /etc/skel
cp -a /root/. /etc/skel/ #.bashrc .profile .tmux.conf

#gosuctl: gsc add xxx; gsc drop
file=/usr/bin/gsc
cat > $file <<EOF
gosu=/usr/bin/gosu
cmd=\$1
case "\$cmd" in
  add)
    chown root:\$2 \$gosu && chmod +s \$gosu
    if [ "\$?" = "0" ]; then
      echo "gosu permissions added to: \$2"
    else 
      echo "warning: gosu permissions add failed."
    fi
    ;;
  drop)
    chown root:root \$gosu && chmod -s \$gosu
    echo "gosu permissions droped"
    ;;
esac
EOF
chmod +x $file

#expect passwd
file=/usr/bin/epasswd
cat > $file <<EOF
#!/bin/sh
# \\
exec expect -f "\$0" \${1+"\$@"}
if { \$argc != 2 } {
    puts "Usage: \$argv0 "
    exit 1
}
set password [lindex \$argv 1]
spawn passwd [lindex \$argv 0]
sleep 1
expect "assword:"
send "\$password\r"
expect "assword:"
send "\$password\r"
expect eof
EOF
chmod +x $file

#expect random passwd
file=/usr/bin/erpasswd
cat > $file <<EOF
user=\$1
pass=\`mkpasswd -l 10\` && echo -e "\033[32mNew Password: [ \${user}:\${pass} ] \033[0m" #pwgen -1cny 10
epasswd \$user \${pass} #must exec with root
EOF
chmod +x $file

#profile
cat > /etc/profile <<EOF
if [ "\$(id -u)" -eq 0 ]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
  PATH="/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
fi
export PATH
export CHARSET=UTF-8
#export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PAGER=less
export PS1='\h:\w\$ '
umask 022

for script in /etc/profile.d/*.sh ; do
        if [ -r \$script ] ; then
                . \$script
        fi
done
EOF
echo "export TERM=xterm" >> /etc/profile

##user entry
useradd -m -d /home/entry -s /bin/bash -u 664 entry #id 664
echo 'entry ALL = (ALL)  ALL' >> /etc/sudoers

#rootpw: erpasswd in example

rm -f /build.sh