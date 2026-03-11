FROM ubuntu:22.04

# Evitar prompts interactivos durante apt install
ENV DEBIAN_FRONTEND=noninteractive

# Copiamos la carpeta src, la web y AHORA LAS FLAGS al contenedor
COPY ./src /src
COPY ./html /var/www/html
COPY ./flags /flags

# Ejecutamos el script de preparación de la máquina
RUN chmod +x /src/prepare.sh && /src/prepare.sh

# Damos permisos de ejecución al entrypoint
RUN chmod +x /src/execute.sh

# El contenedor ejecutará execute.sh al arrancar
CMD ["/src/execute.sh"]