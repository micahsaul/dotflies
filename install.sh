# Install xcode commandline tools, if necessary
if [ ! $(xcode-select -p)='/Library/Developer/CommandLineTools' ]; then
    echo 'Please install XCode and commandline tools before continuing'
    exit 1
fi
# Install and update Homebrew
if ! which brew>/dev/null; then
    echo 'Installing homebrew'
else
    echo 'Existing install of brew found'
fi
echo 'Running brew doctor'
brew doctor
echo 'Running brew update'
brew update
# Add taps
brew tap caskroom/fonts
brew tap caskroom/cask/brew-cask

# Install from brew
brew install git
brew install python
brew install python3
brew install node
brew install zsh
brew install zsh-completions
brew install coreutils
brew install vim
brew install rbenv
brew install ruby-build
brew install neo4j
