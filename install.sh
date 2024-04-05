customize_shell_config() {

  local OH_MY_POSH=$1
  local NEW_NAME=".dev-flc"
  local CURRENT_NAME="personal-config-bash"
  local CURRENT_PATH=$(pwd)
  local NEW_RUTE="$HOME/$NEW_NAME"
  local COLOR_GREEN="\e[0;32m"
  local COLOR_YELLOW="\033[1;34m"
  local COLOR_RESET="$(tput sgr 0 2>/dev/null || echo '\e[42m')"
  local TOTAL_STEPS=5  # Número total de pasos
  local CURRENT_STEP=0  # Inicializamos el contador de pasos actual


  local LINES_TO_ADD=(
   "eval \"\$(oh-my-posh init bash --config $NEW_RUTE/src/theme/dev-flc.omp.json)\""
    "source \"$NEW_RUTE/src/main.sh\""
  )

    # Función para mostrar el porcentaje de avance
  show_progress() {
    ((CURRENT_STEP++))
    local percentage=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    local progress_bar_length=$((percentage / 2))  # Longitud de la barra de progreso
    local progress_bar=""
    for ((i = 0; i < progress_bar_length; i++)); do
        progress_bar+="▓"  # Carácter de progreso
    done
    for ((i = progress_bar_length; i < 50; i++)); do
        progress_bar+="░"  # Carácter de espacio en blanco
    done
    echo -en "\r\033[K"
    echo -n -e "${COLOR_GREEN}Install : ${COLOR_YELLOW}${progress_bar} ${COLOR_GREEN}$percentage%${COLOR_RESET}"
  }

  show_progress


  if ! $OH_MY_POSH; then
    # Si oh-my-posh no está instalado, omitir la línea de inicialización
    LINES_TO_ADD=("source \"$NEW_RUTE/src/main.sh\"")
  fi


  # Definir FILES según OSTYPE
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    local FILES=(
      "$HOME/.bashrc"
      "$HOME/.profile"
      "$HOME/.bash_profile"
    )
  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    local FILES=(
      "/etc/bash.bashrc"
    )
  else
    echo "Unknown"
    return 1
  fi

  # Función para agregar las líneas al final del archivo con un salto de línea
  add_lines_to_file() {
    local file="$1"
    for line in "${LINES_TO_ADD[@]}"; do
      # Agregar la línea al final del archivo solo si aún no existe
      if ! grep -qF "$line" "$file"; then
        # Agregar un salto de línea si el archivo no está vacío
        if [ -s "$file" ]; then
          echo >> "$file"
        fi
        echo "$line" >> "$file"
      fi
    done
  }



  # Mostrar progreso inicial
  show_progress

  # Comprobar si la carpeta actual existe
  if [ -d "$CURRENT_PATH" ]; then
    # Eliminar el directorio existente y copiar archivos a la nueva ubicación
    show_progress  # Mostrar progreso después de completar un paso
    rm -rf "$NEW_RUTE"
    mkdir -p "$NEW_RUTE/src"
    cp -r "$CURRENT_PATH/src" "$NEW_RUTE"
    cp -r "$CURRENT_PATH/LICENSE" "$NEW_RUTE"
    cp -r "$CURRENT_PATH/README.md" "$NEW_RUTE"
  else
    echo "Folder $CURRENT_NAME does not exist in $CURRENT_PATH"
    return 1
  fi

  # Iterar sobre los archivos y agregar las líneas
  show_progress  # Mostrar progreso después de completar otro paso
  for file in "${FILES[@]}"; do
    if [ -e "$file" ]; then
      add_lines_to_file "$file"
      break
    else
      echo "The file $file does not exist and will be ignored."
    fi
  done

  show_progress  # Mostrar progreso después de completar otro paso
  echo -e "\n${COLOR_GREEN}{ I N S T A L L : S U C C E S S F U L L Y 👻 }${COLOR_RESET}"
}

apply_install_oh_my_posh=true
if ! command -v oh-my-posh &> /dev/null; then
  apply_install_oh_my_posh=false
  echo "oh-my-posh not found. Skipping oh-my-posh initialization."
fi

customize_shell_config "$apply_install_oh_my_posh"