#!/bin/sh

# S Y S T E M
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ll='ls -al'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# B A S H
alias reload='source ~/.bashrc'
alias editbash='code ~/.bashrc'
alias suspend='systemctl suspend'

# N P M
alias dev='npm run dev'
alias start="npm start"
alias build="npm run build"

## d i r e c t o r y ##
alias projects="cd ${HOME}/Documentos/projects"

# g  i t
alias editgit='git config --global -e'
alias commit=gitcomit
alias com='npm run commit'
alias push=gitpush
alias status='git status'
