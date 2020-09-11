#!/usr/bin/env zsh

# install zsh.d

# zsh config
src_url="https://code.linuxit.us/zsh.d"

# install to
dest_dir="$HOME/.zsh.d"

# install plugins from github
# key: name of plugin, used in .zshrc
# value: github user/repo
typeset -A plugins
plugins=(
  [zsh-autosuggestions]="zsh-users/zsh-autosuggestions"
  [zsh-history-substring-search]="zsh-users/zsh-history-substring-search"
  [zsh-completions]="zsh-users/zsh-completions"
  [fast-syntax-highlighting]="zdharma/fast-syntax-highlighting"
  [autoswitch_virtualenv]="MichaelAquilina/zsh-autoswitch-virtualenv"
  [auto-notify]="MichaelAquilina/zsh-auto-notify"
  [you-should-use]="MichaelAquilina/zsh-you-should-use"
  [autopair]="hlissner/zsh-autopair"
  [z]="rupa/z"
  [fz]="changyuheng/fz"
  [forgit]="wfxr/forgit"
)

# check for git
if ! command -v git &>/dev/null
then
  echo "Could not locate 'git' command!"
  exit 1
fi

echo "Installing Zshell configuration..."
echo "Source: $src_url"
echo "Target: $dest_dir"

read -s -k "?Press any key continue" && echo

# clone repo
if test -d $dest_dir
then
  echo "Target '$dest_dir' already exists!"
else
  if git clone $src_url $dest_dir
  then
    echo "Cloned repo to $dest_dir"
  else
    echo "Failed to clone repo!"
    exit 1
  fi
fi

# link .zshenv to $HOME
if test -f $HOME/.zshenv
then
  echo "Target '$HOME/.zshenv' already exists!"
else
  echo "Linking to '$dest_dir/.zshenv'..."
  ln -sf $dest_dir/.zshenv $HOME/.zshenv
fi

# get plugins
mkdir -p $dest_dir/plugins &>/dev/null

echo "Fetching plugins..."
for dest url in ${(kv)plugins}
do
  url="https://github.com/$url"
  dest="$dest_dir/plugins/$dest"
  if ! test -d $dest
  then
    git clone $url $dest
  fi
done
unset dest url

echo "Done!"
exit 0

# vim: ft=zsh ts=2 sw=0 et:
