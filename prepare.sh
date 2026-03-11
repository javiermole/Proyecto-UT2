#!/bin/bash

# Toma los parámetros o asigna valores por defecto
MACHINE_NAME=${1:-"ctf_sanity_machine"}
PORTIN=${2:-80}
PORTOUT=${3:-8080}

# Crea el archivo .env para docker-compose
echo "NAME=$MACHINE_NAME" > .env
echo "PORTIN=$PORTIN" >> .env
echo "PORTOUT=$PORTOUT" >> .env

# Crea el archivo de texto con el nombre de la máquina
echo "$MACHINE_NAME" > dockername.txt

echo "[+] Entorno preparado:"
echo "    Máquina: $MACHINE_NAME"
echo "    Puerto interno: $PORTIN"
echo "    Puerto externo: $PORTOUT"