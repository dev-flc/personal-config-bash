#!/bin/bash

archivo="example.json"
nuevo_valor="nuevo_valor"

# Leer el contenido del archivo JSON
contenido=$(cat "$archivo")

# Buscar y reemplazar el valor de "$VAR_USER"
nuevo_contenido=$(echo "$contenido" | sed -E 's/"template": "(\$VAR_USER)"/"template": "'"$nuevo_valor"'"/g')

# Sobrescribir el archivo con el nuevo contenido
echo "$nuevo_contenido" > "$archivo"