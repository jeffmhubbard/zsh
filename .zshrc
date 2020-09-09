# .zshrc

# set theme
#ZSH_THEME="hideous"

# enabled plugins
plugins=(
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
  ssh-agent
)


# load init script
source $ZDOTDIR/init.zsh


# basics
export PAGER=less
export EDITOR=vim
export DIFFPROG=vimdiff
export LESS='-RFW'


# configure external tools
# fzf 
if (( ${+commands[fzf]} ))
then
  export FZF_BASE=/usr/bin/fzf
  (( ${+commands[fd]} )) && \
    export FZF_DEFAULT_COMMAND="fd --type file --color=always"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="
    --ansi
    --height 40%
    --color=16
    --color=fg:-1,bg:-1,hl:11
    --color=fg+:15,bg+:-1,hl+:14
    --color=info:13,prompt:15,spinner:10
    --color=pointer:14,marker:9,header:8
    --color=border:8
    --border sharp
  "
  # load completion and bindings
  if [[ -d /data/data/com.termux/files/usr/share/fzf ]]
  then
    source /data/data/com.termux/files/usr/share/fzf/completion.zsh
    source /data/data/com.termux/files/usr/share/fzf/key-bindings.zsh
  else
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
  fi
fi

# configure plugins
# z
export _Z_DATA=${ZCACHEDIR}/z.db

# forgit
export FORGIT_FZF_DEFAULT_OPTS="
  --ansi
  --height 100%
  --color=dark
  --color=fg:-1,bg:-1,hl:11
  --color=fg+:15,bg+:-1,hl+:14
  --color=info:13,prompt:15,spinner:10
  --color=pointer:14,marker:9,header:8
  --preview-window noborder
  --reverse
  --cycle
  --exact
"

# zsh-autosuggestions
bindkey '^[ ' autosuggest-accept    # Alt+Space

# zsh-history-substring-search
#export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=yellow,bold,underline"
#export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold,underline"

bindkey -M viins '^[[1;2A' history-substring-search-up      # Shift+Up
bindkey -M viins '^[[1;2B' history-substring-search-down    # Shift+Down
bindkey -M vicmd 'K' history-substring-search-up            # Shift+k
bindkey -M vicmd 'J' history-substring-search-down          # Shift+j

# auto-notify
export AUTO_NOTIFY_THRESHOLD=60
export AUTO_NOTIFY_WHITELIST=("pacman" "aur" "makepkg" "pip" "wget" "curl" "tar" "unzip" "dd")

# you-should-use
export YSU_MESSAGE_FORMAT="$(tput bold)$(tput setaf 7) $(tput sgr0)\
Found $(tput bold)$(tput setaf 3)%alias_type$(tput sgr0) for \
$(tput bold)$(tput setaf 6)%command$(tput sgr0), \
use: $(tput smul)$(tput setaf 2)%alias$(tput sgr0)"

# autoswitch_virtualenv
export AUTOSWITCH_MESSAGE_FORMAT="$(tput bold)$(tput setaf 7) $(tput sgr0)\
Activating $(tput bold)$(tput setaf 3)%venv_type$(tput sgr0): \
$(tput bold)$(tput setaf 6)%venv_name$(tput sgr0) \
$(tput bold)$(tput setaf 2) %py_version$(tput sgr0)"

