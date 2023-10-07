find_git_branch() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch=" { ${branch} }"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty=" 🔥 "
  else
    git_dirty=" "
  fi
}
PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"


export PS1="\${debian_chroot:+(\$debian_chroot)}\
${txtblu}┌─${BOLD}${txtrst}${bldred}{ ${txtrst}${BOLD}${bldylw}dev : F.L.C${txtrst}${bldred} } ${bldblu}[ ${txtrst}${txtgrn}\w${txtrst}${bldblu} ]${txtrst}${BOLD}${txtrst}\n\
${txtblu}└──┤▶${txtrst}${bldcyn}\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$"

#export PS1="\${debian_chroot:+(\$debian_chroot)}\
#\[\033[38;5;208m\]┌─\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;197m\]<\
#\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;226m\]FernandoLC\
#\[$(tput sgr0)\]\[\033[38;5;197m\]/>\
#\[\033[38;5;208m\](\[$(tput sgr0)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\]\[\033[38;5;208m\])\
#\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;1m\]\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;208m\]\n\
#└──┤▶\[$txtblu\]\$batery\$git_branch\[$txtred\]\$git_dirty\[$txtrst\] \$"

