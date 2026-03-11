#!/bin/bash
if [ ! -f .env ]; then
    echo "[!] Advertencia: No se encontró .env. Ejecutando ./prepare.sh con valores por defecto..."
    ./prepare.sh
fi

docker-compose up --build -d
echo "[+] Máquina iniciada. Web disponible en http://127.0.0.1:$(grep PORTOUT .env | cut -d '=' -f2)"