#!/bin/bash

# F - U - N - C - T - I - O - N - S

find_git_branch() {
  local branch
  branch=$(git branch --show-current 2>/dev/null | sed 's/\*//')
  if [ "$branch" ]; then
    echo "$branch"
  else
    echo ""
  fi
}

#find_git_branch() {
#  local branch
#  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
#  if [ "$branch" = "HEAD" ]; then
#    echo 'detached*'
#  elif [ "$branch" != "HEAD" ]; then
#    echo $branch
#  else
#    echo ""
#  fi
#}

# git diff --quiet --exit-code --name-only "$branch"; then
# git diff --cached --quiet --exit-code --name-only "$branch"; then

# Función para verificar cambios en una rama de git
# check_git_changes() {
#     local branch=$(find_git_branch)
#     if [ -n "$branch" ]; then
#       local changes=$(git diff --name-only "$branch")
#       local staged=$(git diff --name-only --cached "$branch")
#       local status=$(git status --porcelain 2> /dev/null)
#       if [ -n "$staged" ]; then
#           #"Cambios en staged area:"
#           echo "🚀"
#       elif [ -n "$changes" ]; then
#           #"Cambios detectados en la rama"
#           echo "✏️"
#       fi
#
#       if [ -z "$changes" ] && [ -z "$staged" ]; then
#           echo ""
#       fi
#     else
#       echo ""
#     fi
# }

check_git_changes() {
    local branch=$(find_git_branch)
    if [ -n "$branch" ]; then
      # Obtener el estado del repositorio en un formato por líneas
      local status=$(git status --porcelain 2> /dev/null)

      # Variables para indicar el estado
      changes_to_commit=false
      changes_not_staged=false

      # Iterar sobre cada línea del estado
      while IFS= read -r line; do
          # Verificar si la línea indica cambios que están listos para ser comprometidos
          if [[ $line == "A"* || $line == "M"* || $line == "R"* || $line == "C"* || $line == "U"* || $line == "D"* || $line == "?"* ]]; then
              changes_to_commit=true
              # Si encontramos un cambio que está listo para ser comprometido, salimos del bucle
              break
          # Verificar si la línea indica cambios que no están preparados para ser comprometidos
          elif [[ $line == " "* ]]; then
              changes_not_staged=true
          fi
      done <<< "$status"

      # Imprimir el resultado
      if [ "$changes_to_commit" = true ]; then
          echo "🚀"
      elif [ "$changes_not_staged" = true ]; then
          echo "🔥"
      else
        echo ""
      fi
    else
      echo ""
    fi
}

gitcomit() {
  # ========= Imprimiendo objeto de opciones ==========

  keys=("1" "2" "3" "4" "5" "6" "7")
  values=("🎸 feat" "🐛 fix" "💡 refactor" "💄 style" "💍 test" "✏️ docs" "🏹 exit")
	_array_as_json_colors keys values

  printf "$(_generate_message 2 '🍻 SELECT THE TYPE OF COMMIT: ')"
  read opcion_type
  # ========= Verificar si el valor es igual a "7" o no está en el arreglo ==========
  if [[ "$opcion_type" == "7" ]]; then
      echo "$(_generate_message 3 'Bye... 😉')"
      return
  elif [[ ! " ${keys[*]} " =~ " ${opcion_type} " ]]; then
      echo "$(_generate_message 3 'Invalid option. 🤮')"
      return
  else
    # ========= Imprimiendo objeto de opcion seleccionada ==========
    local opcion_value="${values["${opcion_type}"]}"
    opcion_type_keys=("${opcion_type}")
    opcion_type_values=("${opcion_value}")
    _array_as_json_colors opcion_type_keys opcion_type_values

    # ========= Imprimiendo Scope del commit ==========
    printf "$(_generate_message 2 '📌 SCOPE [ MODULE, FILE, CONFIG ] COMMIT: ')"
    read scope
    scope_keys=("SCOPE")
    scope_values=("${scope}")
    _array_as_json_colors scope_keys scope_values

    # ========= Imprimiendo descripcion del commit ==========
    printf "$(_generate_message 2 '📕 DESCRIPTION COMMIT: ')"
    read description
    description_keys=("DESCRIPTION")
    description_values=("${description}")
    _array_as_json_colors description_keys description_values

    # ========= Imprimiendo el commit completo ==========
    echo "$(_generate_message 2 '🚀 COMMAND')"
    IFS=' ' read -r icon type <<< "$opcion_value"
    description_commit="${type}(${scope}):${icon}_${description}"
    command_keys=("COMMAND")
    command_values=("git commit -m '${description_commit}'")
    _array_as_json_colors command_keys command_values

    # ========= ejecutando el comando ==========
    git add . && git commit -m "${description_commit}"
  fi
}


# P U S H
gitpush() {
  local branch=$(find_git_branch)
  if [ -n "$branch" ]; then
    git push origin "$branch"
  fi
}


# D O C K E R

dockerbuild() {
  read -p "Enter the name of the image: " name
  name=${name:-"docker-image"}

  read -p "Enter the version of the image: " version
  version=${version:-"1.0.0"}

  newname="gcr.io/gnp-sica/${name}:v${version}"
  echo "Building the image with the name: $newname"

  docker build -t $newname .
}

dockerrun() {
  read -p "Enter the name of the image: " name
  name=${name:-"docker-image"}

  read -p "Enter the version of the image: " version
  version=${version:-"1.0.0"}

  newname="gcr.io/gnp-sica/${name}:v${version}"
  echo "Building the image with the name: $newname"

  docker run -p 8080:8080 $newname
}

dockerpush() {
  read -p "Enter the name of the image: " name
  name=${name:-"docker-image"}

  read -p "Enter the version of the image: " version
  version=${version:-"1.0.0"}

  newname="gcr.io/gnp-sica/${name}:v${version}"
  echo "Building the image with the name: $newname"

  docker push $name
}

# Función para convertir un arreglo a JSON coloreado
_array_as_json_colors() {
    local -n keys_ref="$1"    # Referencia al array de claves
    local -n values_ref="$2"  # Referencia al array de valores
    local json=""

    # Definir colores ANSI
    local txtylw='\e[1;33m'
    local bldblu='\e[1;34m'
    local txtgrn='\e[1;32m'
    local txtrst='\e[0m'

    # Imprimir apertura de JSON
    printf "${txtylw}{${txtrst}\n"

    # Construcción del JSON
    for i in "${!keys_ref[@]}"; do
        printf "  ${bldblu}\"%s\"${txtrst}: ${txtgrn}\"%s\"${txtrst}" "${keys_ref[$i]}" "${values_ref[$i]}"
        # Agregar coma si no es el último elemento
        [[ $i -lt $((${#keys_ref[@]} - 1)) ]] && printf ","
        printf "\n"
    done

    # Cierre de JSON
    printf "${txtylw}}${txtrst}\n"
}


# Función para generar dos tipos de mensajes
_generate_message() {
    local message_type="$1"  # Primer argumento: tipo de mensaje (1 o 2)
    local message="$2"       # Segundo argumento: texto del mensaje
	printf "\n"

    if [ "$message_type" -eq 1 ]; then
		printf "${bldblu}========== ${bakblu}$message${txtrst} ${bldblu}========== ${txtrst}"
    elif [ "$message_type" -eq 2 ]; then
        printf "${txtylw}$message${txtrst}"
    elif [ "$message_type" -eq 3 ]; then
        printf "${bldred}$message${txtrst}"
    elif [ "$message_type" -eq 4 ]; then
        printf "${bldgrn}========== ${bakgrn}$message${txtrst} ${bldgrn}========== ${txtrst}"
    else
        echo "Tipo de mensaje no válido. Usa 1 o 2."
    fi
	printf "\n"
}

command_menu() {
    local commands=("${!1}")  # Recibir lista de comandos como referencia

    # Lista de iconos asignados automáticamente (se repetirá si hay más comandos)
    local icons=("🤖" "🐛" "👽" "🔥" "🚀" "🎸" "📌" "⚡️" "💡" "🏹" "💄" "💍")

    local keys=()
    local values=()
    local num_commands=${#commands[@]}
    local num_icons=${#icons[@]}

    # Asignar iconos automáticamente, repitiéndolos si es necesario
    for ((i = 0; i < num_commands; i++)); do
        keys+=("$((i+1))")  # Generar los números de opción
        local icon="${icons[$((i % num_icons))]}"  # Usar icono, repitiéndolos si es necesario
        values+=("$icon ${commands[$i]}")  # Asignar el icono al comando
    done

    # Agregar opción de salida
    keys+=("$((${num_commands} + 1))")
    values+=("🏹 exit")

    # Mostrar menú con colores
    _array_as_json_colors keys values

    # Solicitar la opción al usuario
    printf "\n"
    printf "%s" "$(_generate_message 2 '📌 SELECT A COMMAND: ')"
    read -r option

    # Validar si el usuario quiere salir
    if [[ "$option" == "${keys[-1]}" ]]; then
        echo "$(_generate_message 3 'Bye... 😉')"
        return
    elif [[ ! " ${keys[*]} " =~ " ${option} " ]]; then
        echo "$(_generate_message 3 'Invalid option. 🤮')"
        return
    fi

    # Obtener el comando seleccionado (quitando el icono)
    local command="${commands[$((option-1))]}"

    # Mostrar el comando seleccionado
    command_keys=("COMMAND")
    command_values=("$command")
    _array_as_json_colors command_keys command_values

    # Ejecutar el comando
    eval "$command"
}
