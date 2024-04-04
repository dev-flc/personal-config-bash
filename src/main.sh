#!/bin/sh
NEW_NAME=".config-profile"

eval $(dircolors -b $HOME/${NEW_NAME}/src/utils/.config-profile-dircolors)

source "${HOME}/${NEW_NAME}/src/utils/config-profile-const.sh"
source "${HOME}/${NEW_NAME}/src/utils/config-profile-funtions.sh"
source "${HOME}/${NEW_NAME}/src/utils/config-profile-alias.sh"
#source "${HOME}/${NEW_NAME}/src/utils/config-profile-prompt.sh"
