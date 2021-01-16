#!/usr/bin/env zsh

# install zsh.d

# zsh config
#src_url="https://gitlab.com/jeffmhubbard/zsh.d"
#src_url="https://github.com/jeffmhubbard/zsh.d"
src_url="https://git.linuxit.us/spider/zsh.d"

# install to
dest_dir="$HOME/.zsh.d"

# plugins
plugin_lst="$dest_dir/plugins.txt"

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
if test -f $plugin_lst
then
  mkdir -p $dest_dir/plugins &>/dev/null

  echo "Reading plugin list..."
  typeset -A plugins
  while read name url
  do
    plugins[$name]="$url"
  done < $plugin_lst
  unset name url

  echo "Fetching plugins..."
  for dest url in ${(kv)plugins}
  do
    dest="$dest_dir/plugins/$dest"
    if ! test -d $dest
    then
      git clone $url $dest
    fi
  done
  unset dest url
fi

echo "Done!"
exit 0

# vim: ft=zsh ts=2 sw=0 et:
