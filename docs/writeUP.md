# Write-Up Oficial: Retro-OS

Este documento detalla el "Kill Chain" (cadena de explotación) previsto para resolver la máquina Retro-OS y obtener las 3 flags.

## Paso 1: Falsificación de Cookies (Flag 1)
1. Al acceder al puerto `8080` a través del navegador, la web muestra un mensaje de "ACCESO DENEGADO".
2. Inspeccionando el almacenamiento del navegador (Herramientas de Desarrollador > Aplicación > Cookies), se observa una cookie llamada `role` con el valor `user`.
3. Al modificar el valor de la cookie a `admin` y recargar la página, el sistema concede el acceso, mostrando la animación retro y revelando la **Flag 1**: `CTF{w3b_r3tr0_c0mpl3t4d4}`.

## Paso 2: Enumeración de Código Fuente y Conexión TCP (Flag 2)
1. Con los privilegios de administrador activos en la web, al inspeccionar el código fuente HTML (`Ctrl+U`), se descubre un comentario oculto al final del archivo:
   ```html
   ```
2. Utilizando la herramienta `netcat`, el atacante se conecta al puerto mencionado:
   ```bash
   nc 127.0.0.1 1337
   ```
3. El servicio solicita un PIN. Al introducir `8492`, el sistema valida la entrada y devuelve la **Flag 2**: `CTF{pu3rt0_s3cr3t0_d3scub13rt0}`. 
4. Adicionalmente, el servicio revela la existencia de un usuario del sistema llamado `ctf_player` y lanza una advertencia indicando que su contraseña es débil, sugiriendo una auditoría de fuerza bruta en el puerto SSH (2222).

## Paso 3: Ataque de Fuerza Bruta SSH (Hydra)
1. Conociendo el usuario (`ctf_player`) y teniendo la pista de que su clave se encuentra en diccionarios públicos, el atacante utiliza la herramienta `hydra` junto con el famoso diccionario `rockyou.txt` para atacar el servicio SSH mapeado en el puerto 2222:
   ```bash
   hydra -l ctf_player -P /usr/share/wordlists/rockyou.txt ssh://127.0.0.1:2222
   ```
2. Tras unos segundos de ejecución, la herramienta confirma el hallazgo de credenciales válidas. La contraseña es: `qwerty`.
3. El atacante utiliza estas credenciales para iniciar sesión en la máquina:
   ```bash
   ssh -p 2222 ctf_player@127.0.0.1
   ```

## Paso 4: Escalada de Privilegios por Abuso de Sudo (Flag 3)
1. Una vez dentro de la máquina, se verifica que la última flag se encuentra protegida en `/root/flag.txt`, sin permisos de lectura para usuarios rasos.
2. Al comprobar los privilegios del usuario (`sudo -l` o asumiendo mala configuración), se descubre que `ctf_player` puede ejecutar el binario `/usr/bin/base64` como administrador sin necesidad de contraseña.
3. Se explota esta configuración errónea para leer el archivo protegido codificándolo en base64:
   ```bash
   sudo base64 /root/flag.txt
   ```
4. Finalmente, se decodifica la cadena devuelta para obtener la **Flag 3**: `CTF{4cc3s0_ssh_c0ns3gu1d0}`.
   ```bash
   echo "Q1RGezRjYzNzMF9zc2hfYzBuczVndTFiMH0K" | base64 -d
   ```

## Validación de Flags
Para confirmar que las flags obtenidas durante el proceso de explotación son correctas, el entorno incluye un script de validación interactivo.

1. Abre una terminal (como Git Bash o WSL en Windows, o la terminal estándar en Linux/macOS) en el directorio raíz del proyecto.
2. Ejecuta el validador con el siguiente comando:
   ```bash
   ./validador.sh
   ```
3. El script solicitará que introduzcas la flag. Pega la flag obtenida (incluyendo el formato `CTF{...}`) y presiona **Enter**.
4. El sistema procesará el texto ingresado y te confirmará con un mensaje si la flag corresponde a la Fase 1, Fase 2 o Fase 3, o mostrará un mensaje de error en caso de ser inválida.