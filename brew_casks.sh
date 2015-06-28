#!/bin/bash

# Scary binaries
# many from https://github.com/paulirish/dotfiles/blob/master/brew-cask.sh

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install spectacle
brew cask install dropbox
# brew cask install onepassword
brew cask install rescuetime
brew cask install flux
brew cask install iterm2
brew cask install sublime-text

brew cask install gpgtools
brew cask install slack

# brew cask install horndis  # hatched?

brew cask install google-chrome-beta
brew cask install firefox
brew cask install chromium

brew cask install disk-inventory-x  # kinda like grand perspective

brew cask install vlc
brew cask install miro-video-converter
brew cask install licecap  # create screen capture gifs

brew cask install virtualbox

brew cask install transmission
# brew cask install menumeters  -- needed?

# TODO: new updater script for this?
brew cask install torbrowser
