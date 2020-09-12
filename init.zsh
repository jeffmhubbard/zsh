# init.zsh

#
# setup shell, load plugins and configs
#

# don't do anything if not interactive
[[ ! -o interactive ]] && return

# paths
ZALIASDIR="$ZDOTDIR/alias"
ZCACHEDIR="$ZDOTDIR/cache"
ZCONFDIR="$ZDOTDIR/conf"
ZPLUGDIR="$ZDOTDIR/plugins"
ZTHEMEDIR="$ZDOTDIR/themes"

[[ ! -d $ZCACHEDIR ]] && mkdir -p $ZCACHEDIR

# setup completion
autoload -U compaudit compinit
if [ -z "$ZSH_COMPDUMP" ]
then
  ZSH_COMPDUMP="${ZCACHEDIR}/completions.db"
fi
compinit -i -C -d "${ZSH_COMPDUMP}"

# load plugins
for plugin in $plugins
do
  plugdir=${ZPLUGDIR}/$plugin
  for script in $plugdir/$plugin.plugin.zsh $plugdir/$plugin.zsh $plugdir/$plugin.sh
  do
    [[ -f $script ]] && { source $script; break }
  done
done
unset plugin plugdir script

# load config files
for config in $(ls $ZCONFDIR/*.zsh-conf)
do
  source $config
done
unset config

# load alias files
for config in $(ls $ZALIASDIR/*.zsh-conf)
do
  source $config
done
unset config

# vim: set ft=zsh ts=2 sw=0 et:
