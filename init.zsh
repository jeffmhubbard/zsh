# init.zsh

#
# setup shell, load plugins and configs
#

# don't do anything if not interactive
[[ ! -o interactive ]] && return

# paths
ZDOTALIAS="$ZDOTDIR/alias"
ZDOTCACHE="$ZDOTDIR/cache"
ZDOTCOMP="$ZDOTDIR/completions"
ZDOTCONF="$ZDOTDIR/conf"
ZDOTFUNC="$ZDOTDIR/functions"
ZDOTPLUG="$ZDOTDIR/plugins"
ZDOTTHEME="$ZDOTDIR/themes"

if ! test -d $ZDOTCACHE
then
  mkdir -p $ZDOTCACHE &> /dev/null
fi

# setup completion
autoload -U compaudit compinit
autoload -U +X bashcompinit && bashcompinit
if test -z "$ZSH_COMPDUMP"
then
  ZSH_COMPDUMP="$ZDOTCACHE/completions.db"
fi
compinit -i -C -d "$ZSH_COMPDUMP"

# load plugins
if test -d $ZDOTPLUG
then
  for plugin in $plugins
  do
    plugdir=$ZDOTPLUG/$plugin
    for script in $plugdir/$plugin.plugin.zsh $plugdir/$plugin.zsh $plugdir/$plugin.sh
    do
      if test -f $script
      then
        source $script; break
      fi
    done
  done
  unset plugin plugdir script
fi

# load config files
for config in $(ls $ZDOTCONF/*.zsh)
do
  source $config
done
unset config

# load alias files
for config in $(ls $ZDOTALIAS/*.zsh)
do
  source $config
done
unset config
