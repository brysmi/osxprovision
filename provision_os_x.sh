#!/bin/sh
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
source "lib/symlink/index.sh"

# ------------------------------------------------------
# Set defaults
#
echo "Making your Mac dev machine awesome ... "

sh "defaults.sh"

echo "Install all AppStore Apps at first!"
# no solution to automate AppStore installs
read -p "Press any key to continue... " -n1 -s
echo  '\n'

# install wallpaper cli
sudo gem install desktop

# ------------------------------------------------------
# Binaries
#
echo "Install Homebrew, Postgres, wget and cask, node"

sh "binaries.sh"

# ------------------------------------------------------
# Core Functionality
#
echo "Install Core Apps"

sh "apps.sh"

# TODO: install jdk 7, 8, and switch command to change between 6,7,8
#brew cask install --appdir="~/Applications" java

# Link Cask Apps to Alfred
brew cask alfred link

# ------------------------------------------------------
# cleanup
#
echo "Clean up from installing"
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

# ------------------------------------------------------
# Profile / .bash_profile
#

echo "Add .bash_profile if it doesn't already exist"
# Symlink the profile
if [[ ! -e "$HOME/.bash_profile" ]]; then
  echo "creating profile.sh from $HOME/.bash_profile"
  sudo cp -R "profile.sh" "$HOME/.bash_profile"
  source $HOME/.bash_profile
else
  echo "$HOME/.bash_profile already exists. remove and run again."
fi
