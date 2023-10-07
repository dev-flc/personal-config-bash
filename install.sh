#!/bin/bash
NEW_NAME=".config-profile-flc"
CURRENT_NAME=".personal_config"

CURRENT_PATH=$(pwd)
NEW_RUTE="$HOME/$NEW_NAME"

TOTAL_STEPS=4
CURRENT_STEP=0

COLOR_GREEN="\033[1;32m"
COLOR_BLUE="\033[1;34m"
COLOR_RESET="\033[0m"

LINES_TO_ADD=(
  "source \"$NEW_RUTE/src/main.sh\""
)

# The lines of code to add
files=(
  "$HOME/.bashrc"
  #"$HOME/.profile"
  #"$HOME/.bash_profile"
)

# show bar progress
show_progress() {
  local progress=$((CURRENT_STEP * 100 / TOTAL_STEPS))

  printf "${COLOR_GREEN}[%3d%%] 🛠️ ${COLOR_BLUE}" "$progress"
  local i
  for ((i = 0; i < progress; i+=2)); do
    printf "#"
  done
  printf "${COLOR_RESET}\n"
}

# Increase step counter and show progress bar.
increment_step() {
  ((CURRENT_STEP++))
  show_progress
}

# Check if the current folder exists
if [ -d "$CURRENT_PATH" ]; then
	rm -rf $NEW_RUTE
  cp -r "$CURRENT_PATH"  $NEW_RUTE
  increment_step
else
  echo "Folder $CURRENT_NAME does not exist in $CURRENT_PATH"
fi

# Function to add the lines to the end of the file with a line break
add_lines_to_file() {
  local file="$1"
  for line in "${LINES_TO_ADD[@]}"; do
    # Add a line break if the file is not empty
    if [ -s "$file" ]; then
      echo >> "$file"
    fi
    # Add the line to the end of the file only if it does not already exist
    if ! grep -qF "$line" "$file"; then
      echo "$line" >> "$file"
    fi
  done
  increment_step
}

# Iterate over the files and add the lines
for file in "${files[@]}"; do
  if [ -e "$file" ]; then
    increment_step
    add_lines_to_file "$file"
  else
    echo "El archivo $file no existe y será omitido."
  fi
done

increment_step

echo -e "${COLOR_GREEN}< S U C C E S S F U L L Y 👻 />${COLOR_RESET}"
