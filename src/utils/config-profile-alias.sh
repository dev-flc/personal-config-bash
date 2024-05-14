#!/bin/bash

# S Y S T E M
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# L I S - F I L E S
alias l='ls -CF'
alias ll='ls -al'
alias la='ls -A'

# B A S H
alias reload='source ~/.bashrc'
alias configbash='code ~/.bashrc'
alias configbashwin='code /etc/bash.bashrc'
alias suspend='systemctl suspend'

# N P M
alias dev='npm run dev'
alias devwin='npm run dev:win'
alias start="npm start"
alias build="npm run build"
alias buildwin="npm run build:win"

# D I R E C T O R Y
alias projects="cd ${HOME}/Documentos/projects"
alias projectswin="cd ${HOME}/Documents/projects"

# G I T
alias configgit='git config --global -e'
alias commit=gitcomit
alias com='npm run commit'
alias push=gitpush
alias status='git status'
alias add='git add .'
