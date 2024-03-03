#!/bin/bash

# Función que actualiza las variables del prompt
update_prompt() {
  local branch=$(find_git_branch)

  if [ -n "$branch" ]; then
    prompt_branch="${txtgrn}${branch}"

    local check_changes=$(check_git_changes)
    if [ -n "$check_changes" ]; then
      prompt_check_git="$check_changes"
    else
      prompt_check_git=""
    fi
  else
    prompt_branch=""
  fi

  if [ -n "$prompt_branch" ] && [ -n "$prompt_check_git" ]; then
    PS1="$promp_root${BOLD}$prompt_signature$prompt_directory\n${BOLD}$prompt_arrow$prompt_branch $prompt_check_git${txtrst} \$"
  elif [ -n "$prompt_branch" ]; then
    PS1="$promp_root${BOLD}$prompt_signature$prompt_directory\n${BOLD}$prompt_arrow$prompt_branch${txtrst} \$"
  else
    PS1="$promp_root${BOLD}$prompt_signature$prompt_directory\n${BOLD}$prompt_arrow${txtrst}\$"
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
