#
# Application installer (via brew-cask)
#

set -e

# Apps
apps=(
  alfred
  arq
  dropbox
  flash
  key-codes
  nvalt
  screenflick
  seil
  shimo
  shiori
  skitch
  slack
  textwrangler
  tower
  transmission
  transmit
)
#  clamxav
#  evernote
#  hazel
#  mailbox
#  qlcolorcode
#  qlmarkdown
#  qlprettypatch
#  qlstephen
#  quicklook-json
#  wunderlist

# dev apps
dev=(
  cakebrew
  dash
  diffmerge
  filezilla
  github
  heroku-toolbelt
  imageoptim
  iterm2
  pgadmin3
  sourcetree
  vagrant
  virtualbox
  simpless
)
#  charles
#  easyfind
#  mamp

#  IDEs
ides=(
  atom
  sublime-text3
)
#  eclipse-ide
#  eclipse-php
#  emacs
#  intellij-idea
#  light-table
#  macvim
#  netbeans-php
#  netbeans-php-nightly
#  phpstorm
#  phpstorm-eap
#  phpstorm7
#  pycharm-pro
#  rstudio
#  rubymine
#  webstorm

# Google Slavery
google=(
  google-chrome
  google-drive
  google-hangouts
)
#  chromecast
#  google-earth
#  google-music-manager
#  googleappengine

# Nice to have
extras=(
  adium
  camtasia
  firefox
  handbrake
  skype
  vlc
  vox
  xtrafinder
)
#  1password
#  all2mp3
#  atext
#  bartender
#  chromium
#  cinch
#  delibar
#  flux
#  jdownloader
#  lastfm
#  launchpad-manager-yosemite
#  little-snitch
#  opera-next
#  quicksilver
#  send-to-kindle
#  sketch
#  soundflower
#  spotify
#  spotify-notifications
#  tilemill
#  tomahawk

# fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
  font-inconsolata
  font-symbola
)

# Atom packages
atom=(
  advanced-railscasts-syntax
  atom-beautify
  cmd-9
  color-picker
  css-comb
  docblockr
  easy-motion
  editor-stats
  emmet
  fancy-new-file
  file-icons
  git-history
  highlight-selected
  image-view
  inc-dec-value
  key-peek
  language-jade
  linter
  markdown-preview
  merge-conflicts
  neutron-ui
  npm-install
  react
  vim-mode
  zentabs
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew tap phinze/homebrew-cask
  brew install brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install dev apps
  echo "installing dev apps..."
  brew cask install --appdir=$appdir ${dev[@]}

  # install dev IDEs
  echo "installing dev IDEs..."
  brew cask install --appdir=$appdir ${ides[@]}

  # install google apps
  echo "installing Google apps..."
  brew cask install --appdir=$appdir ${google[@]}

  # install extras
  echo "installing 'nice to have' extras..."
  brew cask install --appdir=$appdir ${extras[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}

  # link with alfred
  alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
