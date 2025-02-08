#!/bin/bash

commands_java=(
    "./gradlew bootRun"
    "./gradlew checkstyleMain"
    "./gradlew test"
    "./gradlew jacocoTestReport"
    "./gradlew clean"
    "./gradlew clean build"
    "./gradlew clean build --refresh-dependencies"
)
commands_kubernetes=(
"kubectl apply -f deployment.yaml"
"kubectl delete -f deployment.yaml"
)

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

# N P M
alias dev='npm run dev'
alias start="npm start"
alias build="npm run build"

# J A V A
alias jclean='./gradlew clean build --refresh-dependencies'
alias jbuild='./gradlew clean build'
alias jrun='./gradlew bootRun'
alias jv='command_menu commands_java[@]'

alias kb='command_menu commands_kubernetes[@]'

# D O C K E R
alias initdocker='sudo systemctl start docker'
alias dockerbuild=dockerbuild
alias dockerrun=dockerrun
alias dockerpush=dockerpush


# D I R E C T O R Y
alias pj="cd ${HOME}/projects"


# G I T
alias configgit='git config --global -e'
alias commit=gitcomit
alias com='npm run commit'
alias push=gitpush
alias status='git status'
alias add='git add .'
