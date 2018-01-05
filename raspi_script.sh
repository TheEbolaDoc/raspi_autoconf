#!/bin/bash
user1="chris"
ssh_key_1=$(cat ./ssh_key.pub)
passwd pi

if ! grep pi /etc/hostname
then

    echo -n "Please enter a hostname: "
    read hostname_new
    echo $hostname_new > /etc/hostname
    sed -i '$ d' /etc/hosts
    echo "127.0.1.1    $hostname_new" >> /etc/hosts
    echo "new hostname is $hostname_new"
fi

if [[ ! -d /home/pi/.ssh ]]; then
    mkdir /home/pi/.ssh
fi

if [[ ! -f /home/pi/.ssh/authorized_keys ]]; then
    touch /home/pi/.ssh/authorized_keys
    echo "creating /home/pi/.ssh"
fi

adduser $user1
adduser $user1 sudo 

if [[ ! -d /home/$user1/.ssh ]]; then
    mkdir /home/$user1/.ssh
    echo "creating /home/$user1/.ssh"
fi

if [[ ! -f /home/$user1/.ssh/authorized_keys ]]; then
    touch /home/$user1/.ssh/authorized_keys
fi

systemctl enable ssh
systemctl start ssh

echo $ssh_key_1 >> /home/$user1/.ssh/authorized_keys
echo "echo $ssh_key_1 >> /home/$user1/.ssh/authorized_keys"
echo $ssh_key_1 >> /home/pi/.ssh/authorized_keys
echo -n "echo $ssh_key_1 >> /home/pi/.ssh/authorized_keys"
cat ascii_art.txt > /etc/motd
cat ./sshd_conf > /etc/ssh/sshd_conf
echo "cat ./sshd_conf > /etc/ssh/sshd_conf"

sudo raspi-config nonint do_expand_rootfs

git config --global user.email "christian@heusel.eu"
git config --global user.name "Chris Heusl"

apt  update
apt -y upgrade
apt -y dist-upgrade
apt install -y fail2ban vim sl zsh

cat ./zshrc > /root/.zshrc
echo "cat ./zshrc > /root/.zshrc"
sudo -H -u pi bash -c 'cat ./zshrc > /home/pi/.zshrc'
echo "cat ./zshrc > /home/pi/.zshrc"
sudo -H -u pi bash -c 'cat ./zshrc_chris > /home/$user1/.zshrc'
echo "cat ./zshrc_chris > /home/$user1/.zshrc"

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sudo -H -u pi bash -c  'sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"'
sudo -H -u $user1 bash -c 'sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"'
