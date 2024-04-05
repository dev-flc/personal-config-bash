
#!/bin/sh
NEW_NAME=".dev-flc"
NEW_RUTE="$HOME/$NEW_NAME"

eval $(dircolors -b $HOME/${NEW_NAME}/src/utils/.config-profile-dircolors)
source "${NEW_RUTE}/src/utils/config-profile-const.sh"
source "${NEW_RUTE}/src/utils/config-profile-funtions.sh"
source "${NEW_RUTE}/src/utils/config-profile-alias.sh"
#source "${NEW_RUTE}/src/utils/config-profile-prompt.sh"
