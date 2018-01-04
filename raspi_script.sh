#!/bin/bash
user1="chris"
ssh_key_1="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAEAQC0t72Q8M6xMcmDXMcgF9MAOUcZKAzcaYB7F6rgl9OPycFOWcIUA3/ZUXJnEDN/Ynh63EUlP25aGxCbRBT6DV6S8Oi3VufcYwRyZcOytwymOsm+CqffyZkx0jzWMtj3bhCBk9HIE4C/wQsSRpfr1ek8RkUfAXwdSQBm9MS5RevLwvaJyD7m2xiW7X9KxKRwrKF5ECLjjgR0Uv4xtA1MR50fZwzeVV3JU5yJeR9wsQYbCVbizh6iM9cbhy6ceudjDtlx8qokysoM2BXykT9FRuCrcCE3UFKRgy/mHaNFguK0Wr0PSmHh1BWUdZHHzZVAjnkR+F9evMuyVrb9/i+4geWTRnZQkw0sMEfh99T7kBuIUhuYYUL+MqqZ7VKILrV+YROBotfMoeL18lgf+uTGS4KoGgBRvt2TmqmSkZqaRB07YjmG8QPbShPKHPUSXhIalmxZ7s70V40iY+ezrcXTnF2PHfSePbGooRB5Q0YXK3YtNg37JqTly5Gg51UJvjjITp1GVNkhd1xs/ZmH7MmX3lj6G40y2U3PL1lTLMRTA4O3X5ur4caZW/l6VNaR4R5awvnZARwjE5e7wAF8BfDg348JgfIRBnm9PQTYUC9YPYVZmY8YCNt0Qagjay5WVZ6KrKgzXnweTxRGb6DbXAqqquBGL8E3dn2Lk9dW25pV57bEUS0zCPl4WHvAuPbslR9mAijY5loaDF39duhMGsyQtQ/VagXf4iX6S6CeaFPyboMFdE8H7d+G1rRx9KAhlujjHQvn0CEUVBfmvbnssfuROOFa5gT9E1m8udy99MkrsDUue3KEFQBXUHN0zHmBMLQ3IZI/1mGCye3uiyXFsRpZypjjzQtdnJ/xe2aK4agq8BvyUtUMnS7tR9DAqe7ELg5iMVWJdUt9TJfR40eqLOYnBnbk3T8XmhB807e2Bh/PfzdV7by3/lxfuUhwa1ig4vE9CV/sN5B8WCxsYqAnXxCeaBB6f2KLQrlMJ1qUNJX2iUYC0BzseeZwCp8jYM/miz/t8vxgRqLfH6/mKkMlMjKwDwirbjK3+D/98fE5wUZ41pFWNSKO7PIsNFsMXyE7bYeYvYYQT0pNAX87MJyS21y50yeDQPQ7z1OyjTynQIKalGyeEat2IAsJoK1F4S5y6bYvUP5dG8J0kPUE9szX6+OviNGCDWlQjS7VT6ZR9MdUQJZERgLnWgp0WoBJ3rS1kTAIDAvClswbC9NKHIYbvgAnsHIZFCbIb395hyNPMKaahT9VLz+IWEoNg/1csu4BuPkaZxwJBjsJ65RJIoa45vEkKgxwmU3LVPN5r24ADOWOSxocyWZM0zj+rz++zeFv0M6HjZQsV7fS0WwpWZwRrEBI01bZ chris@x"

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
echo "echo $ssh_key_1 >> /home/pi/.ssh/authorized_keys"
cat ./sshd_conf > /etc/ssh/sshd_conf
echo "cat ./sshd_conf > /etc/ssh/sshd_conf"

cat /boot/cmdline.txt            # show original cmdline.txt
sudo raspi-config nonint do_expand_rootfs

apt  update
apt -y upgrade
apt -y dist-upgrade
apt install -y fail2ban vim sl zsh

cat ./zshrc > /root/.zshrc
echo "cat ./zshrc > /root/.zshrc"
cat ./zshrc > /home/pi/.zshrc
echo "cat ./zshrc > /home/pi/.zshrc"
cat ./zshrc_chris > /home/$user1/.zshrc
echo "cat ./zshrc_chris > /home/$user1/.zshrc"

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sudo -H -u pi bash -c  'sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"'
sudo -H -u $user1 bash -c 'sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"'
