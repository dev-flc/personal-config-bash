#!/bin/bash

# Función que actualiza las variables del prompt
update_prompt() {
  local branch=$(find_git_branch)
  if [ -n "$branch" ]; then
    prompt_branch="${txtgrn}${branch} "
    prompt_check_git="\$(check_git_changes)"
  else
    prompt_branch=""
    prompt_check_git="🐛"
  fi

  if [ -n "$prompt_branch" ] || [ -n "$prompt_check_git" ]; then
    echo "one"
    PS1="$promp_root${BOLD}$prompt_signature$prompt_directory\n${BOLD}$prompt_arrow$prompt_branch$prompt_check_git${txtrst}  \$ "
  else
    echo "two"
    PS1="$promp_root${BOLD}$prompt_signature$prompt_directory\n${BOLD}$prompt_arrow${txtrst}\$ "
  fi
}

# Hook que se ejecuta antes de mostrar el prompt
PROMPT_COMMAND=update_prompt

# V A R
promp_root="\${debian_chroot:+(\$debian_chroot)}"
prompt_signature="${txtblu}┌─ 🤖 ${txtred}{ ${txtylw}dev ${txtred}: ${txtylw}flc${txtred} }"
prompt_directory="${txtblu}[ ${txtrst}${undgrn}\w${txtrst}${txtblu} ]"
prompt_arrow="${txtblu}└──┤▶ "

# Inicializar el prompt
update_prompt
