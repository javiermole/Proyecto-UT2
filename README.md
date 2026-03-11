# 👾 CTF Machine: Retro-OS

Bienvenido a **Retro-OS**, una máquina vulnerable de nivel fácil/intermedio diseñada para practicar enumeración web, descubrimiento de servicios ocultos y escalada de privilegios en sistemas Linux.

## 📝 Descripción del Reto
El administrador de este antiguo sistema ha dejado un portal de acceso de diagnóstico abierto al público. Afirma que el servidor es impenetrable gracias a su "tecnología CRT de última generación" y a su robusto sistema de cookies, pero los rumores en la red dicen que se ha dejado varios servicios de depuración expuestos por error.

**Tu misión:** Comprometer la máquina por completo, saltar de la web al sistema base y convertirte en el usuario `root`. 

## 🎯 Objetivos
A lo largo de tu intrusión, deberás encontrar **3 flags** que demuestran tu avance en la cadena de explotación (Kill Chain):

1. **Flag 1 (Web):** Demuestra que has logrado burlar el panel de acceso.
2. **Flag 2 (User):** Demuestra que has interactuado con los servicios internos y obtenido acceso al sistema.
3. **Flag 3 (Root):** Demuestra que has escalado privilegios y dominas la máquina.

Todas las flags tienen el formato estándar: `CTF{texto_de_ejemplo}`

---

## ⚙️ Requisitos Previos
Para desplegar esta máquina en tu entorno local necesitas tener instalados:
* **Docker** y **Docker Compose**
* Una terminal compatible con bash (En Linux/macOS viene por defecto. En **Windows**, se recomienda usar **Git Bash** o **WSL**).

---

## 🚀 Instalación y Despliegue

Sigue estos pasos desde tu terminal para iniciar el reto:

1. **Clona o descarga** este repositorio y sitúate en la carpeta raíz.
2. **Prepara el entorno** y genera los archivos de configuración necesarios:
   ./prepare.sh
3. **Construye y levanta la máquina** (la primera vez puede tardar un poco mientras descarga las dependencias):
    ./start.sh
Una vez que el script finalice, el reto estará activo. Puedes comenzar tu ataque accediendo a:
👉 http://127.0.0.1:8080

## ✅ Validación de Flags
No tienes que adivinar si lo has hecho bien. El proyecto incluye un script validador interactivo y seguro (sin spoilers en el código fuente).

Cuando encuentres una flag, ejecuta este comando en tu terminal para comprobarla:
./validador.sh
Pega tu flag y el sistema te confirmará si es correcta.


## 🧹 Limpieza del Entorno
Cuando hayas completado el reto (¡o si necesitas reiniciarlo por completo!), puedes detener los contenedores y borrar las redes creadas ejecutando:
./remove.sh

(Si solo quieres detener la máquina temporalmente sin borrarla, puedes usar ./stop.sh).

⚠️ Aviso: Este entorno ha sido creado con fines puramente educativos. No ejecutes la máquina en servidores de producción públicos, ya que contiene vulnerabilidades de seguridad intencionadas.