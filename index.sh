#!/usr/bin/env bash

echo "Provisioning Setup..."

# paths
dirname=$(pwd)
lib="/usr/local/lib"
bin="/usr/local/bin"

# make in case they aren't already there
mkdir -p "/usr/local/lib"
mkdir -p "/usr/local/bin"

set -e

# modules
source "$lib/symlink/index.sh"

# Run each program
sh "defaults.sh"
sh "binaries.sh"
sh "apps.sh"

# Symlink the profile
if [[ ! -e "$HOME/.bash_profile" ]]; then
  echo "creating profile.sh from $HOME/.bash_profile"
  sudo cp -R "profile.sh" "$HOME/.bash_profile"
  source $HOME/.bash_profile
else
  echo "$HOME/.bash_profile already exists. remove and run again."
fi
