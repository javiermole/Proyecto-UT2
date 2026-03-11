#!/bin/bash

# Añadimos 'sudo' a la lista de instalaciones
apt-get update
apt-get install -y apache2 php libapache2-mod-php openssh-server python3 netcat-openbsd sudo

# Configurar SSH y usuario
mkdir /var/run/sshd
useradd -m -s /bin/bash ctf_player
echo 'ctf_player:R3tr0H4ck3r' | chpasswd
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Configurar Escalada de Privilegios:
# Permitimos a ctf_player ejecutar /usr/bin/base64 como root sin pedir contraseña
echo 'ctf_player ALL=(ALL) NOPASSWD: /usr/bin/base64' >> /etc/sudoers

# Limpiar Apache y dependencias
rm -f /var/www/html/index.html
chown -R www-data:www-data /var/www/html/
apt-get clean && rm -rf /var/lib/apt/lists/*