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
  # Show the options available for the type with colors
  echo -e "${bldcyn}SELECT THE TYPE OF COMMIT:${txtrst}"

  echo -e "${bldblu}{${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 1 ${bldylw}: ${txtrst} 🎸 ${TYPE_FEAT} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 2 ${bldylw}: ${txtrst} 🐛 ${TYPE_FIX} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 3 ${bldylw}: ${txtrst} 💡 ${TYPE_REFACTOR} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 4 ${bldylw}: ${txtrst} 💄 ${TYPE_STYLE} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 5 ${bldylw}: ${txtrst} 💍 ${TYPE_TEST} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 6 ${bldylw}: ${txtrst} ✏️  ${TYPE_DOCS} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "   ${bldblu}{ ${bldcyn} 7 ${bldylw}: ${txtrst} 🏹 ${TYPE_EXIT} ${txtrst} ${bldblu}}${txtrst}"
  echo -e "${bldblu}}${txtrst}"

  # Prompt the user to select an option
  read opcion_type
  local selected_option
  # Evaluate the selected option
  case $opcion_type in
    1)
      type="${TYPE_FEAT}"
      icon="🎸"
      typeColor="${icon} ${TYPE_FEAT} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    2)
      type="${TYPE_FIX}"
      icon="🐛"
      typeColor="${icon} ${TYPE_FIX} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    3)
      type="${TYPE_REFACTOR}"
      icon="💡"
      typeColor="${icon} ${TYPE_REFACTOR} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    4)
      type="${TYPE_STYLE}"
      icon="💄"
      typeColor="${icon} ${TYPE_STYLE} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    5)
      type="${TYPE_TEST}"
      icon="💍"
      typeColor="${icon} ${TYPE_TEST} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    6)
      type="${TYPE_DOCS}"
      icon="✏️"
      typeColor="${icon} ${TYPE_DOCS} ${txtrst}"
      selected_option="${opcion_type}"
      ;;
    7)
      type="${TYPE_EXIT}"
      icon="$"
      typeColor="${icon} ${txtrst} ${TYPE_EXIT} ${txtrst}"
      selected_option="${opcion_type}"
      return
      ;;
    *)
      type="${TYPE_FEAT}"
      icon="🎸"
      typeColor="${icon} ${TYPE_FEAT} ${txtrst}"
      selected_option="default"
      echo -e "${bldred}Invalid option. The type will be set as : ${txtrst}${typeColor}.${txtrst}"
      ;;
  esac

  echo -e "${bldblu}{ ${bldcyn} Option ${bldylw}: ${txtblu}{ ${bldcyn}${selected_option} ${bldylw}:${txtrst} ${typeColor} ${txtblu}} ${bldblu}}${txtrst}"

  # Prompt user to enter scope
  echo -e "${bldcyn}SCOPE [ MODULE, FILE, CONFIG ] COMMIT:${txtrst}"

  read scope

  # Prompt user to enter description
  echo -e "${bldcyn}DESCRIPTION COMMIT:${txtrst}"

  read description

  echo -e "${bldgrn}git commit -m '${type}(${scope}): ${icon}${description}'${txtrst}"

  git add . && git commit -m "${type}(${scope}): ${icon}${description}"
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