# conf/prompt.zsh

#
# build interactive prompt
# 

# comment this out for lame terminals
ZLE_RPROMPT_INDENT=-1

setopt prompt_subst
setopt transient_rprompt

# load prompt theme
if test -f $ZDOTTHEME/$ZSH_THEME.zsh-theme
then
  source $ZDOTTHEME/$ZSH_THEME.zsh-theme
fi

# default theme
typeset -A PROMPT_DEFAULTS=(
  [USER_COLOR]="%B%F{green}"
  [USER_ICON]=""
  [ROOT_COLOR]="%B%F{red}"
  [ROOT_ICON]=""
  [HOST_COLOR]="%b%F{green}"
  [HOST_ICON]="@"
  [SSH_COLOR]="%F{yellow}"
  [SSH_ICON]="@"
  [PATH_COLOR]="%B%F{blue}"
  [PATH_ICON]=""
  [PATH_FORMAT]="%(4~|%2~|%~)"
  [GIT_COLOR]="%B%F{magenta}"
  [GIT_ICON]=" "
  [GIT_SHA_COLOR]="%B%F{magenta}"
  [GIT_STATE_COLOR]="%B%F{magenta}"
  [GIT_STATE_ADDED]=" ✚"
  [GIT_STATE_MODIFIED]=" ●"
  [GIT_STATE_DELETED]=" ✖"
  [GIT_STATE_RENAMED]=" ➤"
  [GIT_STATE_UNMERGED]=" ♦"
  [GIT_STATE_UNTRACKED]=" ✱"
  [GIT_STATE_AHEAD]=" ▲"
  [JOBS_COLOR]="%B%F{yellow}"
  [JOBS_ICON]=" "
  [HISTORY_COLOR]="%B%F{black}"
  [HISTORY_ICON]=""
  [TIME_COLOR]="%B%F{black}"
  [TIME_ICON]=""
  [VENV_COLOR]="%B%F{cyan}"
  [VENV_ICON]=""
  [VIM_COLOR]="%B%F{white}"
  [VIM_COLOR_ALT]="%F{cyan}"
  [VIM_ICON]="➜"
  [PROMPT_COLOR]="%B%F{white}"
  [PROMPT_ICON]="%#"
  [STATUS_COLOR]="%B%F{red}"
  [STATUS_ICON]="↵"
  [CONTINUE_COLOR]="%B%F{black}"
  [CONTINUE_ICON]="..."
  [SELECT_COLOR]="%B%F{white}"
  [SELECT_ICON]="➜ ?"
  [MARKER_COLOR]="%B%F{black}"
)

# end string format
endf="%f%b"

# show user@host with detection for root and ssh
function prompt_userhost {
  local user_color user_icon
  local host_color host_icon
  user_color=${PROMPT_USER_COLOR:-${PROMPT_DEFAULTS[USER_COLOR]}}
  user_icon=${PROMPT_USER_ICON:-${PROMPT_DEFAULTS[USER_ICON]}}
  host_color=${PROMPT_HOST_COLOR:-${PROMPT_DEFAULTS[HOST_COLOR]}}
  host_icon=${PROMPT_HOST_ICON:-${PROMPT_DEFAULTS[HOST_ICON]}}

  # detect root
  if [ $UID -eq 0 ]
  then
    user_color=${PROMPT_ROOT_COLOR:-${PROMPT_DEFAULTS[ROOT_COLOR]}}
    user_icon=${PROMPT_ROOT_ICON:-${PROMPT_DEFAULTS[ROOT_ICON]}}
  fi

  # detect ssh
  if [ -v SSH_CONNECTION ]
  then
    host_color=${PROMPT_SSH_COLOR:-${PROMPT_DEFAULTS[SSH_COLOR]}}
    host_icon=${PROMPT_SSH_ICON:-${PROMPT_DEFAULTS[SSH_ICON]}}
  fi

  echo "${user_color}${user_icon}%n${host_color}${host_icon}%m${endf} "
}

# show current path
function prompt_path {
  local color icon pathfmt
  color=${PROMPT_PATH_COLOR:-${PROMPT_DEFAULTS[PATH_COLOR]}}
  icon=${PROMPT_PATH_ICON:-${PROMPT_DEFAULTS[PATH_ICON]}}
  pathfmt=${PROMPT_PATH_FORMAT:-${PROMPT_DEFAULTS[PATH_FORMAT]}}

  echo "${color}${icon}${pathfmt}${endf} "
}

# show git info (branch, commit, and status)
# PROMPT_GIT_SHA_ICON must be set to display commit hash
function prompt_gitinfo {
  if typeset -f git_prompt_info >/dev/null
  then
    typeset -g ZSH_THEME_GIT_PROMPT_PREFIX=""
    typeset -g ZSH_THEME_GIT_PROMPT_SUFFIX=""
    typeset -g ZSH_THEME_GIT_PROMPT_ADDED=${PROMPT_GIT_STATE_ADDED:-${PROMPT_DEFAULTS[GIT_STATE_ADDED]}}
    typeset -g ZSH_THEME_GIT_PROMPT_MODIFIED=${PROMPT_GIT_STATE_MODIFIED:-${PROMPT_DEFAULTS[GIT_STATE_MODIFIED]}}
    typeset -g ZSH_THEME_GIT_PROMPT_DELETED=${PROMPT_GIT_STATE_DELETED:-${PROMPT_DEFAULTS[GIT_STATE_DELETED]}}
    typeset -g ZSH_THEME_GIT_PROMPT_RENAMED=${PROMPT_GIT_STATE_RENAMED:-${PROMPT_DEFAULTS[GIT_STATE_RENAMED]}}
    typeset -g ZSH_THEME_GIT_PROMPT_UNMERGED=${PROMPT_GIT_STATE_UNMERGED:-${PROMPT_DEFAULTS[GIT_STATE_UNMERGED]}}
    typeset -g ZSH_THEME_GIT_PROMPT_UNTRACKED=${PROMPT_GIT_STATE_UNTRACKED:-${PROMPT_DEFAULTS[GIT_STATE_UNTRACKED]}}
    typeset -g ZSH_THEME_GIT_PROMPT_AHEAD=${PROMPT_GIT_STATE_AHEAD:-${PROMPT_DEFAULTS[GIT_STATE_AHEAD]}}

    local color icon state_color
    local branch state commit
    local sha_icon sha_color
    color=${PROMPT_GIT_COLOR:-${PROMPT_DEFAULTS[GIT_COLOR]}}
    icon=${PROMPT_GIT_ICON:-${PROMPT_DEFAULTS[GIT_ICON]}}
    branch=$(git_prompt_info)
    state=$(git_prompt_status)
    state_color=${PROMPT_GIT_STATE_COLOR:-${PROMPT_DEFAULTS[GIT_STATE_COLOR]}}

    if [[ -n $branch ]]
    then
      if [[ -v PROMPT_GIT_SHA_ICON ]]
      then
        sha_color=${PROMPT_GIT_SHA_COLOR:-${PROMPT_DEFAULTS[GIT_SHA_COLOR]}}
        sha_icon=${PROMPT_GIT_SHA_ICON}
        sha_short=$(git_prompt_short_sha)
        commit="${sha_color}${sha_icon}${sha_short}${endf}"
      fi

      echo "${color}${icon}${branch}${commit}${state_color}${state}${endf} "
    fi
  fi
}

# show background jobs
function prompt_jobs {
  local color icon running
  color=${PROMPT_JOBS_COLOR:-${PROMPT_DEFAULTS[JOBS_COLOR]}}
  icon=${PROMPT_JOBS_ICON:-${PROMPT_DEFAULTS[JOBS_ICON]}}
  running=$(jobs -l | wc -l)

  if [[ $running -ne 0 ]]
  then
    echo "${color}${icon}${running}${endf} "
  fi
}

# show current history
function prompt_history {
  local color icon running
  color=${PROMPT_HISTORY_COLOR:-${PROMPT_DEFAULTS[HISTORY_COLOR]}}
  icon=${PROMPT_HISTORY_ICON:-${PROMPT_DEFAULTS[HISTORY_ICON]}}

  if [[ -v PROMPT_HISTORY_ICON ]]
  then
    echo "${color}${icon}%!${endf} "
  fi
}

# show timestamp
function prompt_timestamp {
  local color icon
  color=${PROMPT_TIME_COLOR:-${PROMPT_DEFAULTS[TIME_COLOR]}}
  icon=${PROMPT_TIME_ICON:-${PROMPT_DEFAULTS[TIME_ICON]}}
  
  echo "${color}${icon}%D{%H:%M:%S}${endf}"
}

# show python virtualenv
function prompt_virtualenv {
  if typeset -f virtualenv_prompt_info >/dev/null
  then
    local color icon venv
    color=${PROMPT_VENV_COLOR:-${PROMPT_DEFAULTS[VENV_COLOR]}}
    icon=${PROMPT_VENV_ICON:-${PROMPT_DEFAULTS[VENV_ICON]}}
    # strip brackets
    venv="$(virtualenv_prompt_info | sed 's/[][]//g')"

    if [[ -n $venv ]]
    then
      echo "${color}${icon}${venv}${endf} "
    fi
  fi
}

# show vi-mode
function prompt_vimode {
  if typeset -f vi_mode_prompt_info >/dev/null
  then
    typeset -g MODE_INDICATOR=${PROMPT_VIM_COLOR_ALT:-${PROMPT_DEFAULTS[VIM_COLOR_ALT]}}

    local color icon
    color=${PROMPT_VIM_COLOR:-${PROMPT_DEFAULTS[VIM_COLOR]}}
    icon=${PROMPT_VIM_ICON:-${PROMPT_DEFAULTS[VIM_ICON]}}

    echo "${color}$(vi_mode_prompt_info)${icon}${endf} "
  fi
}

# show prompt
function prompt_prompt {
  local color icon
  color=${PROMPT_PROMPT_COLOR:-${PROMPT_DEFAULTS[PROMPT_COLOR]}}
  icon=${PROMPT_PROMPT_ICON:-${PROMPT_DEFAULTS[PROMPT_ICON]}}

  echo "${color}${icon}${endf} "
}

# show exit status
function prompt_status {
  local color icon
  color=${PROMPT_STATUS_COLOR:-${PROMPT_DEFAULTS[STATUS_COLOR]}}
  icon=${PROMPT_STATUS_ICON:-${PROMPT_DEFAULTS[STATUS_ICON]}}

  echo "${color}%(?..%? ${icon})${endf}"
}

# show continue prompt (PS2)
function prompt_continue {
  local color icon
  color=${PROMPT_CONTINUE_COLOR:-${PROMPT_DEFAULTS[CONTINUE_COLOR]}}
  icon=${PROMPT_CONTINUE_ICON:-${PROMPT_DEFAULTS[CONTINUE_ICON]}}

  echo "${color}${icon}${endf} "
}

# show select prompt (PS3)
function prompt_select {
  local color icon
  color=${PROMPT_SELECT_COLOR:-${PROMPT_DEFAULTS[SELECT_COLOR]}}
  icon=${PROMPT_SELECT_ICON:-${PROMPT_DEFAULTS[SELECT_ICON]}}

  echo "${color}${icon}${endf} "
}

# show output marker
function prompt_marker {
  local color icon width
  local icon_len prefix_len
  local marker prefix
  color=${PROMPT_MARKER_COLOR:-${PROMPT_DEFAULTS[MARKER_COLOR]}}
  icon=${PROMPT_MARKER_ICON}
  width=$COLUMNS
  icon_len=$(echo -n "$icon" | wc -m)

  # if icon is more than one character
  # recalculate width and set prefix
  if [[ $icon_len -gt 1 ]]
  then
    prefix_len=$((icon_len - 1))
    width=$((width - prefix_len))
    prefix=${icon[1,$prefix_len]}
    marker=${icon/$prefix/}
  else
    marker=${icon}
  fi

  echo "${color}${prefix}$(repeat $width printf "$marker")${endf}"
}

function prompt_title {
  # set window title
  local zsh_ver=$(zsh --version | cut -f1-2 -d' ')
  local cur_dir="${PWD/#$HOME/~}"
  local window_title="\033]0;$zsh_ver: $cur_dir\007"
  echo -ne "$window_title"
}

function precmd {
  local prompt_left left_length
  local prompt_right right_length
  local spacer

  # set terminal title
  prompt_title

  # output marker
  if [[ -v PROMPT_MARKER_ICON ]]
  then
    print -Pr "$(prompt_marker)"
  fi

  # [ user@host, pwd, git info ], spacer, [ jobs, history, timestamp ]
  # first line left
  prompt_left="$(prompt_userhost)$(prompt_path)$(prompt_gitinfo)"

  # first line right
  prompt_right="$(prompt_jobs)$(prompt_history)$(prompt_timestamp)"

  left_length=${#${(S%%)prompt_left//(\%([KF1]|)\{*\}|\%[Bbkf])}}
  right_length=${#${(S%%)prompt_right//(\%([KF1]|)\{*\}|\%[Bbkf])}}
  spacer=$((COLUMNS - left_length - right_length))

  # display
  print -Pr "$prompt_left${(l:$spacer:)}$prompt_right"
}

# [ virtualenv, vi-mode, prompt ], input, [ exit status ]
# second line left
PS1='$(prompt_virtualenv)$(prompt_vimode)$(prompt_prompt)'

# second line right
RPS1='$(prompt_status)'

# continuation dots
PS2='$(prompt_continue)'

# select
PS3='$(prompt_select)'

# vim: set ft=zsh ts=2 sw=0 et:
