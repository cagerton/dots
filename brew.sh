#!/bin/bash

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    curl -o install_brew.rb https://raw.githubusercontent.com/Homebrew/install/master/install && \
    ruby ./install_brew.rb
fi

export PATH=/usr/local/bin:$PATH

brew install git
brew install bash
brew install zsh
brew install wget
brew install tree

brew install xz libjpeg sqlite readline
brew install freetype graphicsmagick jpegoptim lcms libjpeg libpng \
     libtiff openjpeg optipng pngcrush webp

brew install imagemagick
brew install python3

#brew install moreutils (neat command line utils)

brew install coreutils
brew install findutils  # GNU find
brew install gnu-sed --default-names
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

# brew install android-platform-tools
brew install nmap
