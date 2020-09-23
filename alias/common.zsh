# common
alias _='sudo '

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'
alias rd=rmdir

alias ls='ls --color=auto'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

alias grep="grep -s --color=auto"
alias egrep="egrep -s --color=auto"
alias fgrep="fgrep -s --color=auto"

alias cat="bat -pp"
alias less=bat

alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'

alias ip="ip -c"

alias fp='pgrep -ax '

alias psc="ps -eo pid,cmd,%cpu --sort=-%cpu | head -11"
alias psm="ps -eo pid,cmd,%mem --sort=-%mem | head -11"

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

# vim: set ft=zsh ts=2 sw=0 et:
