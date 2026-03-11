#!/bin/bash

# 1. Esconder la Flag 3 en el directorio de root (Protegida)
cp /flags/flag3.txt /root/flag.txt
chown root:root /root/flag.txt
chmod 400 /root/flag.txt # Solo el usuario root puede leerla

# 2. Iniciar SSH y Web
/usr/sbin/sshd
service apache2 start

# 3. Iniciar el servicio TCP Interactivo (Puerto 1337)
python3 -c "
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('0.0.0.0', 1337))
s.listen(5)
while True:
    conn, addr = s.accept()
    conn.sendall(b'========================================\n')
    conn.sendall(b'  SERVICIO DE DIAGNOSTICO RETRO-OS v1.0 \n')
    conn.sendall(b'========================================\n')
    conn.sendall(b'Introduzca el PIN de acceso: ')
    try:
        # Recibir la respuesta del usuario
        data = conn.recv(1024).decode().strip()
        if data == '8492':
            with open('/flags/flag2.txt', 'rb') as f:
                conn.sendall(b'\n[+] PIN CORRECTO. Flag: ' + f.read() + b'\n\n')
            conn.sendall(b'[SYSTEM LOG] Usuario generado: ctf_player\n')
            conn.sendall(b'[SYSTEM LOG] Password: R3tr0H4ck3r\n')
        else:
            conn.sendall(b'\n[-] PIN INCORRECTO. Intruso detectado.\n')
    except Exception as e:
        pass
    conn.close()
" &

# Bucle infinito
tail -f /dev/null