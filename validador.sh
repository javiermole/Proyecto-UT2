#!/bin/bash

echo -e "\n======================================="
echo "   🛡️ VALIDADOR DE FLAGS - RETRO OS 🛡️"
echo "======================================="

read -p "[>] Introduce tu flag (ej. CTF{...}): " input_flag

# Limpiamos lo que escriba el usuario de cualquier salto de línea invisible de Windows (\r) o espacios extra
clean_flag=$(echo "$input_flag" | tr -d '\r' | tr -d '\n' | tr -d ' ')

echo ""
if [ "$clean_flag" == "CTF{w3b_r3tr0_c0mpl3t4d4}" ]; then
    echo "✅ ¡CORRECTO! Has validado la Flag 1 (Vulnerabilidad Web)."
elif [ "$clean_flag" == "CTF{pu3rt0_s3cr3t0_d3scub13rt0}" ]; then
    echo "✅ ¡CORRECTO! Has validado la Flag 2 (Servicio TCP Oculto)."
elif [ "$clean_flag" == "CTF{4cc3s0_ssh_c0ns3gu1d0}" ]; then
    echo "✅ ¡CORRECTO! Has validado la Flag 3 (Escalada de Privilegios SSH)."
else
    echo "❌ ERROR: La flag introducida no es válida o está mal escrita."
fi
echo "======================================="
echo ""