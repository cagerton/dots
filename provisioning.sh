#!/bin/bash

# Fix scroll direction + save to disk + show all files
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# close printer app by default
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true


# Disable resume stuff (preview?)
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Screenshots
defaults write com.apple.screencapture type -string "png"


# Finder - use column view by default
defaults write com.apple.finder AppleShowAllFiles -bool true  # TRUE
defaults write com.apple.finder FXPreferredViewStyle Clmv
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show the ~/Library folder
chflags nohidden ~/Library



# Don't add trash to network stores
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Dock options.
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# Safari stuff
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
defaults write com.apple.Safari ProxiesInBookmarksBar "()"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write com.apple.Safari HomePage -string "about:blank"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Show webview debug
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Default UTF8 for terminal
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

# Don't ask about using every empty disk for backups
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# kill local time machine backups:
sudo tmutil disablelocal

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null



# Transmission
mkdir -p ~/Downloads/Incomplete
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"
# defaults write org.m0k.transmission DownloadAsk -bool false
# defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false



###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true



########## SECURITY https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/404339/osx-provisioning-script.sh.txt
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
softwareupdate --schedule on
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
defaults write com.apple.loginwindow RetriesUntilHint -int 0

# 5min timeout + screensaver lock
systemsetup -setdisplaysleep 5
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Cleanup on sleep.
pmset destroyfvkeyonstandby 1 hibernatemode 25

# Basic firewall
/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

echo "[I] Launching firmware password utility (this may take a moment)"
diskutil mount Recovery\ HD
RECOVERY=$(hdiutil attach /Volumes/Recovery\ HD/com.apple.recovery.boot/BaseSystem.dmg | grep -i Base | cut -f 3)
open "$RECOVERY/Applications/Utilities/Firmware Password Utility.app"
echo "[!] Follow the prompts on the utility to set a strong unique firmware password"
echo "[!] Press enter when done"
read DONE




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

brew install wget
brew install tree
brew install zsh git
brew install xz libjpeg sqlite readline
brew install python3

brew install freetype graphicsmagick jpegoptim lcms libjpeg libpng \
     libtiff openjpeg optipng pngcrush webp
brew install imagemagick




#### Basics
brew install coreutils
brew install moreutils
brew install findutils
brew install gnu-sed --default-names
brew install bash
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

brew install android-platform-tools
brew install zsh

#### Scary binaries  - https://github.com/paulirish/dotfiles/blob/master/brew-cask.sh

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install spectacle
brew cask install dropbox
brew cask install onepassword
brew cask install rescuetime
brew cask install flux
brew cask install iterm2
brew cask install sublime-text
brew cask install google-chrome-beta
brew cask install miro-video-converter
# brew cask install horndis
brew cask install firefox
brew cask install chromium
brew cask install disk-inventory-x
brew cask install vlc
brew cask install licecap
brew cask install transmission
# brew cask install menumeters  -- needed?

# TODO: new updater for this?
brew cask install torbrowser




