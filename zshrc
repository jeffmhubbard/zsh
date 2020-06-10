#!/usr/bin/zsh

#
# zsh config
# ln -s zshrc $HOME/.zshrc
#

# set path to zsh directory
export ZSH=$HOME/.zsh

# set prompt theme
#ZSH_THEME="none"

# define plugins
typeset -a plugins=(
  zsh-completions
  zsh-autosuggestions
  zsh-autopair
  z
  fz
  forgit
  you-should-use
  auto-notify
  autoswitch_virtualenv
  fast-syntax-highlighting
  zsh-history-substring-search
)

# load init script
source ${ZSH}/init.zsh

# basics
export PAGER=less
export EDITOR=vim
export DIFFPROG=vimdiff
export LESS='-RFW'

# vim: set ft=zsh ts=2 sw=0 et:
