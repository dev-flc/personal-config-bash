#!/bin/sh

# F - U - N - C - T - I - O - N - S

gitcomit() {
  # Show the options available for the type with colors
  echo "Select the type of commit:"
  echo -e "1 : ${COLORS_GREEN_LIGHT}${TYPE_FEAT}${COLORS_RESET}"
  echo -e "2 : ${COLORS_RED_LIGHT}${TYPE_FIX}${COLORS_RESET}"
  echo -e "3 : ${COLORS_BLUE_LIGHT}${TYPE_REFACTOR}${COLORS_RESET}"
  echo -e "4 : ${COLORS_YELLOW_LIGHT}${TYPE_STYLE}${COLORS_RESET}"
  echo -e "5 : ${COLORS_MAGENTA_LIGHT}${TYPE_TEST}${COLORS_RESET}"
  echo -e "6 : ${COLORS_CYAN_LIGHT}${TYPE_DOCS}${COLORS_RESET}"
  echo -e "7 : ${COLORS_RESET}${TYPE_EXIT}${COLORS_RESET}"

  # Prompt the user to select an option
  # echo -e "Options: { ${COLORS_GREEN}1${COLORS_RESET} , ${COLORS_RED}2${COLORS_RESET} , ${COLORS_BLUE}3${COLORS_RESET} , ${COLORS_YELLOW}4${COLORS_RESET} , ${COLORS_MAGENTA}5${COLORS_RESET} , ${COLORS_CYAN}6${COLORS_RESET}, ${COLORS_RESET}7${COLORS_RESET} }"
  read opcion_type
  # Evaluate the selected option
  case $opcion_type in
    1)
      type="${TYPE_FEAT}"
      typeColor="${COLORS_GREEN_LIGHT}${TYPE_FEAT}${COLORS_RESET}"
      ;;
    2)
      type="${TYPE_FIX}"
      typeColor="${COLORS_RED_LIGHT}${TYPE_FIX}${COLORS_RESET}"
      ;;
    3)
      type="${TYPE_REFACTOR}"
      typeColor="${COLORS_BLUE_LIGHT}${TYPE_REFACTOR}${COLORS_RESET}"
      ;;
    4)
      type="${TYPE_STYLE}"
      typeColor="${COLORS_YELLOW_LIGHT}${TYPE_STYLE}${COLORS_RESET}"
      ;;
    5)
      type="${TYPE_TEST}"
      typeColor="${COLORS_MAGENTA_LIGHT}${TYPE_TEST}${COLORS_RESET}"
      ;;
    6)
      type="${TYPE_DOCS}"
      typeColor="${COLORS_CYAN_LIGHT}${TYPE_DOCS}${COLORS_RESET}"
      ;;
    7)
      type="${TYPE_EXIT}"
      typeColor="${COLORS_RESET}${TYPE_EXIT}${COLORS_RESET}"
      return
      ;;
    *)
      echo -e "${COLORS_RED}Opción no válida. Se establecerá el type como: ${TYPE_FEAT}.${COLORS_RESET}"
      type="${TYPE_FEAT}"
      typeColor="${COLORS_GREEN_LIGHT}${TYPE_FEAT}${COLORS_RESET}"
      ;;
  esac

  echo -e "${COLORS_BLUE}{ ${COLORS_CYAN}Option ${COLORS_YELLOW}: ${COLORS_BLUE_LIGHT}{ ${COLORS_CYAN}${opcion_type} ${COLORS_YELLOW}: ${typeColor} ${COLORS_BLUE_LIGHT}} ${COLORS_BLUE}}${COLORS_RESET}"

  # Prompt user to enter scope
  echo -e "Scope (Module, File, Config) commit:"
  read scope

  # Prompt user to enter description
  echo -e "Description commit:"
  read description

  echo -e "git add . && git commit -m '${type}(${scope}): ${description}'"

  git add . && git commit -m "${type}(${scope}): ${description}"
}

# P U S H
gitpush() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    branch_push=$branch
  else
    branch_push=""
  fi
  git push origin $branch_push
}