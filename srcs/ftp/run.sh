
useradd -m $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

chmod -R 777 /var/www/html

vsftpd /etc/vsftpd.conf