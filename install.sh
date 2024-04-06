customize_shell_config() {

  local NAME_USER="$1"
  local NEW_NAME=".dev-flc"
  local CURRENT_NAME="personal-config-bash"
  local CURRENT_PATH=$(pwd)
  local NEW_RUTE="$HOME/$NEW_NAME"
  local COLOR_GREEN="\e[0;32m"
  local COLOR_YELLOW="\033[1;34m"
  local COLOR_RESET="$(tput sgr 0 2>/dev/null || echo '\e[42m')"
  local FILE_THEME="$NEW_RUTE/src/theme/dev-flc.omp.json"
  local TOTAL_STEPS=5
  local CURRENT_STEP=0
  local LINES_TO_ADD=(
    "eval \"\$(oh-my-posh init bash --config $FILE_THEME)\""
    "source \"$NEW_RUTE/src/main.sh\""
  )

  show_progress() {
    ((CURRENT_STEP++))
    local percentage=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    local progress_bar_length=$((percentage / 2))
    local progress_bar=""
    for ((i = 0; i < progress_bar_length; i++)); do
        progress_bar+="▓"
    done
    for ((i = progress_bar_length; i < 50; i++)); do
        progress_bar+="░"
    done
    echo -en "\r\033[K"
    echo -n -e "${COLOR_GREEN}Install : ${COLOR_YELLOW}${progress_bar} ${COLOR_GREEN}$percentage%${COLOR_RESET}"
  }

  show_progress

  if ! command -v oh-my-posh &> /dev/null; then
    LINES_TO_ADD=("source \"$NEW_RUTE/src/main.sh\"")
    echo "oh-my-posh not found. Skipping oh-my-posh initialization."
  fi

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

  add_lines_to_file() {
    local file="$1"
    for line in "${LINES_TO_ADD[@]}"; do
      if ! grep -qF "$line" "$file"; then
        if [ -s "$file" ]; then
          echo >> "$file"
        fi
        echo "$line" >> "$file"
      fi
    done
  }

  show_progress

  if [ -d "$CURRENT_PATH" ]; then
    rm -rf "$NEW_RUTE"
    mkdir -p "$NEW_RUTE/src"
    cp -r "$CURRENT_PATH/src" "$NEW_RUTE"
    cp -r "$CURRENT_PATH/LICENSE" "$NEW_RUTE"
    cp -r "$CURRENT_PATH/README.md" "$NEW_RUTE"
  else
    echo "Folder $CURRENT_NAME does not exist in $CURRENT_PATH"
    return 1
  fi

  show_progress
  for file in "${FILES[@]}"; do
    if [ -e "$file" ]; then
      add_lines_to_file "$file"
      break
    else
      echo "The file $file does not exist and will be ignored."
    fi
  done

  show_progress

  contenido=$(cat "$FILE_THEME")
  nuevo_contenido=$(echo "$contenido" | sed -E 's/"template": "(\$USERNAME)"/"template": "'"$NAME_USER "'"/g')
  echo "$nuevo_contenido" > "$FILE_THEME"

  show_progress

  echo -e "\n${COLOR_GREEN}{ I N S T A L L : S U C C E S S F U L L Y 👻 }${COLOR_RESET}"
}

read -p "Do you want to create a custom user? (Y/N):" appy_user
if [ "$appy_user" == "Y" ] || [ "$appy_user" == "y" ]; then
  read -p "Username : " username
  customize_shell_config "$username"
elif [ "$appy_user" == "N" ] || [ "$appy_user" == "n" ]; then
  customize_shell_config "{{ .UserName }}"
else
    echo "Invalid option. Select Y or N."
fi

