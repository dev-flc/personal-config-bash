#!/bin/sh

# F - U - N - C - T - I - O - N - S

gitcomit() {
  # Show the options available for the type with colors
  echo "Select the type of commit:"
  echo -e "1 : ${bakgrn}${TYPE_FEAT}${txtrst}"
  echo -e "2 : ${bakred}${TYPE_FIX}${txtrst}"
  echo -e "3 : ${bakblu}${TYPE_REFACTOR}${txtrst}"
  echo -e "4 : ${bakylw}${TYPE_STYLE}${txtrst}"
  echo -e "5 : ${bakpur}${TYPE_TEST}${txtrst}"
  echo -e "6 : ${bakcyn}${TYPE_DOCS}${txtrst}"
  echo -e "7 : ${txtrst}${TYPE_EXIT}${txtrst}"

  # Prompt the user to select an option
  read opcion_type
  # Evaluate the selected option
  case $opcion_type in
    1)
      type="${TYPE_FEAT}"
      typeColor="${bakgrn}${TYPE_FEAT}${txtrst}"
      ;;
    2)
      type="${TYPE_FIX}"
      typeColor="${bakred}${TYPE_FIX}${txtrst}"
      ;;
    3)
      type="${TYPE_REFACTOR}"
      typeColor="${bakblu}${TYPE_REFACTOR}${txtrst}"
      ;;
    4)
      type="${TYPE_STYLE}"
      typeColor="${bakylw}${TYPE_STYLE}${txtrst}"
      ;;
    5)
      type="${TYPE_TEST}"
      typeColor="${bakpur}${TYPE_TEST}${txtrst}"
      ;;
    6)
      type="${TYPE_DOCS}"
      typeColor="${bakcyn}${TYPE_DOCS}${txtrst}"
      ;;
    7)
      type="${TYPE_EXIT}"
      typeColor="${txtrst}${TYPE_EXIT}${txtrst}"
      return
      ;;
    *)
      echo -e "${bldred}Opción no válida. Se establecerá el type como: ${TYPE_FEAT}.${txtrst}"
      type="${TYPE_FEAT}"
      typeColor="${txtgrn}${TYPE_FEAT}${txtrst}"
      ;;
  esac

  echo -e "${bldblu}{ ${bldcyn} Option ${bldylw}: ${txtblu}{ ${bldcyn}${opcion_type} ${bldylw}:${txtrst} ${typeColor} ${txtblu}} ${bldblu}}${txtrst}"

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
  #local branch
  #if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
  #  if [[ "$branch" == "HEAD" ]]; then
  #    branch='detached*'
  #  fi
  #  branch_push=$branch
  #else
  #  branch_push=""
  #fi
  git push origin $git_branch
}