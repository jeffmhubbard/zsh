#!/usr/bin/zsh

#
# zsh config
# ln -s zshrc $HOME/.zshrc
#

# set path to zsh directory
export ZSH=$HOME/.zsh

# set prompt theme
ZSH_THEME="antsy"

# define plugins
typeset -a plugins
plugins+=(zsh-completions)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-autopair)
plugins+=(z)
plugins+=(fz)
plugins+=(forgit)
plugins+=(fast-syntax-highlighting)
plugins+=(you-should-use)
plugins+=(auto-notify)
plugins+=(autoswitch_virtualenv)

# load init script
source ${ZSH}/init.zsh

# basics
export PAGER=less
export EDITOR=vim
export DIFFPROG=vimdiff
export LESS='-RFW'

# vim: set ft=zsh ts=2 sw=0 et:
