#
# Binary installer
#

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update && brew upgrade brew-cask

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

brew tap homebrew/science
brew tap phinze/cask

# Install other useful binaries
binaries=(
  graphicsmagick
  boot2docker
  webkit2png
  phantomjs
  rename
  zopfli
  ffmpeg
  python
  mongo
  sshfs
  trash
  node
  tree
  hub
  ack
  git
  hub
  fig
  wget
  postgresql
  ant
  eigen
  opencv
)

# Install the binaries
brew install ${binaries[@]}

# TODO: install jdk 7, 8, and switch command to change between 6,7,8
#brew cask install --appdir="~/Applications" java

# Add osx specific command line tools
if test ! $(which subl); then
  ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
fi

# Install spot
if test ! $(which spot); then
  curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
fi

# Remove outdated versions from the cellar
brew cleanup

# npm installs
npm install -g gitjk
sudo npm install -g cordova
npm install phonegap -g

exit 0
