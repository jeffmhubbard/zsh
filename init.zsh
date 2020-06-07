# init.zsh

#
# setup shell, load plugins and configs
#

# don't do anything if not interactive
[[ ! -o interactive ]] && return

# paths
ZSH_CACHE_DIR="${ZSH}/cache"
ZSH_CONF_DIR="${ZSH}/conf"
ZSH_PLUGIN_DIR="${ZSH}/plugins"
ZSH_THEME_DIR="${ZSH}/themes"

[[ ! -d $ZSH_CACHE_DIR ]] && mkdir -p $ZSH_CACHE_DIR

# setup completion
autoload -U compaudit compinit
if [ -z "$ZSH_COMPDUMP" ]
then
  ZSH_COMPDUMP="${ZSH_CACHE_DIR}/completions.db"
fi
compinit -i -C -d "${ZSH_COMPDUMP}"


# load plugins
for plugin in $plugins
do
  plugdir=${ZSH_PLUGIN_DIR}/$plugin
  for script in $plugdir/$plugin.plugin.zsh $plugdir/$plugin.zsh $plugdir/$plugin.sh
  do
    if [[ -f $script ]]
    then
      source $script
      break
    fi
  done
done
unset plugin plugdir script


# load config files
for config in $(ls $ZSH_CONF_DIR/*.zsh-conf)
do
  source $config
done
unset config

# vim: set ft=zsh ts=2 sw=0 et:
