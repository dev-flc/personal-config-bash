#!/bin/bash

# F U N T I O N S
find_branch=$(find_git_branch)
check_changes=$(check_git_changes)

# V A R
promp_root="\${debian_chroot:+(\$debian_chroot)}"
prompt_signature="${txtblu}┌─ 🤖 ${txtred}{ ${txtylw}dev ${txtred}: ${txtylw}flc${txtred} }"
prompt_directory="${txtblu}[ ${txtrst}${undgrn}\w${txtrst}${txtblu} ]"
prompt_branch="${txtblu}└──┤▶ ${txtgrn}${find_branch}${txtrst}"
prompt_check_git="${check_changes}"

# P R O M P T
export PS1="$promp_root${BOLD}$prompt_signature$prompt_directory\n${BOLD}$prompt_branch $prompt_check_git\$ "
