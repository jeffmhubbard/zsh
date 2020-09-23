# color support

autoload -U colors && colors

export LSCOLORS="Gxfxcxdxbxegedabagacad"
eval "$(dircolors -b $ZDOTTHEME/dircolors)"
