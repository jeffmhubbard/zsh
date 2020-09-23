# custom functions

# create and move into new directory
function take() {
  mkdir -p $@ && cd ${@:$#}
}

# color man pages
function _termcap_custom_colors() {
  command env \
    LESS_TERMCAP_mb=$(printf "\e[1;34m") \
    LESS_TERMCAP_md=$(printf "\e[1;35m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[0;107;30m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;4;32m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    "$@"
}

function man() {
  _termcap_custom_colors man "$@"
}

# vi mode indicator for prompt
function vi_mode_prompt_info() {
  echo "${${VI_KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# python virtualenv for prompt
function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}
export VIRTUAL_ENV_DISABLE_PROMPT=1
