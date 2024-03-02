#!/bin/bash

promp_root="\${debian_chroot:+(\$debian_chroot)}"
prompt_signature="${txtblu}┌─ 🤖 ${txtred}{ ${txtylw}dev ${txtred}: ${txtylw}flc${txtred} }"
prompt_directory="${txtblu}[ ${txtrst}${undgrn}\w${txtrst}${txtblu} ]"
prompt_branch="${txtblu}└──┤▶ ${txtgrn}\$(find_git_branch)${txtrst}"
prompt_check_git="\$(check_git_changes)"

export PS1="$promp_root$prompt_signature$prompt_directory\n$prompt_branch $prompt_check_git\$ "
