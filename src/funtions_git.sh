#!/bin/sh

# F - U - N - C - T - I - O - N - S

gitcomit() {
  # Show the options available for the type with colors
  echo -e "${bldundwht}SELECT THE TYPE OF COMMIT:${txtrst}"

  echo -e "${bldblu}{${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 1 ${bldylw}: ${txtrst}${bakgrn} ${TYPE_FEAT} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 2 ${bldylw}: ${txtrst}${bakred} ${TYPE_FIX} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 3 ${bldylw}: ${txtrst}${bakblu} ${TYPE_REFACTOR} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 4 ${bldylw}: ${txtrst}${bakylw} ${TYPE_STYLE} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 5 ${bldylw}: ${txtrst}${bakpur} ${TYPE_TEST} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 6 ${bldylw}: ${txtrst}${bakcyn} ${TYPE_DOCS} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 7 ${bldylw}: ${txtrst}${txtrst} ${TYPE_EXIT} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "${bldblu}}${txtrst}"

  # Prompt the user to select an option
  read opcion_type
  local selected_option
  # Evaluate the selected option
  case $opcion_type in
    1)
      type="${TYPE_FEAT}"
      typeColor="${bakgrn} ${TYPE_FEAT} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    2)
      type="${TYPE_FIX}"
      typeColor="${bakred} ${TYPE_FIX} ${txtrst}"
    selected_option="${opcion_type}"
      ;;
    3)
      type="${TYPE_REFACTOR}"
      typeColor="${bakblu} ${TYPE_REFACTOR} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    4)
      type="${TYPE_STYLE}"
      typeColor="${bakylw} ${TYPE_STYLE} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    5)
      type="${TYPE_TEST}"
      typeColor="${bakpur} ${TYPE_TEST} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    6)
      type="${TYPE_DOCS}"
      typeColor="${bakcyn} ${TYPE_DOCS} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    7)
      type="${TYPE_EXIT}"
      typeColor="${txtrst} ${TYPE_EXIT} ${txtrst}"
      selected_option="${opcion_type}"
      return
      ;;
    *)
      type="${TYPE_FEAT}"
      typeColor="${bakgrn} ${TYPE_FEAT} ${txtrst}"
      selected_option="default"
      echo -e "${bldred}Invalid option. The type will be set as : ${txtrst}${typeColor}.${txtrst}"
      ;;
  esac

  echo -e "${bldblu}{ ${bldcyn} Option ${bldylw}: ${txtblu}{ ${bldcyn}${selected_option} ${bldylw}:${txtrst} ${typeColor} ${txtblu}} ${bldblu}}${txtrst}"

  # Prompt user to enter scope
  echo -e "${bldundwht}SCOPE [ MODULE, FILE, CONFIG ] COMMIT:${txtrst}"

  read scope

  # Prompt user to enter description
  echo -e "${bldundwht}DESCRIPTION COMMIT:${txtrst}"

  read description

  echo -e "git add . && git commit -m '${type}(${scope}): ${description}'"

  git add . && git commit -m "${type}(${scope}): ${description}"
}

# P U S H
gitpush() {
  git push origin $git_branch
}