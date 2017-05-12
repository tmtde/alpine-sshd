#!/bin/sh
for algorithm in rsa dsa ecdsa ed25519
do
    keyfile=/etc/ssh/ssh_host_${algorithm}_key
    [ -f $keyfile ] || ssh-keygen -q -N '' -f $keyfile -t $algorithm
    grep -q "HostKey $keyfile" /etc/ssh/sshd_config || echo "HostKey $keyfile" >> /etc/ssh/sshd_config
done

echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

mkdir -p /root/.ssh
echo "$SSH_KEY"	> /root/.ssh/authorized_keys

/usr/sbin/sshd -D
