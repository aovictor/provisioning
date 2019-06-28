#!/bin/sh

if [[ $(whoami) == "root" ]]; then
  echo "do not run this as root."
  exit 1
fi

# Set up vim ########################################################################################
/bin/cp vimrc ~/.vimrc
/bin/cp -Rf vim ~/.vim
# /bin/cp -Rf bash_profile ~/.bash_profile
# Install color themes
git clone https://github.com/dracula/iterm.git ~/git/dracula

# Install homebrew ###################################################################################
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
/bin/cp brewfile ~/.brewfile
/usr/local/bin/brew bundle --file ~/.brewfile

# Install Oh-My-zsh ##################################################################################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# Install oh-my-zsh fonts
mkdir ~/git
git clone https://github.com/Karmenzind/monaco-nerd-fonts.git ~/git/monaco-nerd-fonts
/bin/cp ~/git/monaco-nerd-fonts/fonts/* /Library/Fonts
# Install oh-my-zsh configs
/bin/cp -f zshrc ~/.zshrc
/bin/cp zshenv ~/.zshenv

# Create apps #########################################################################################
# Install natifier
git clone https://github.com/jiahaog/nativefier.git ~/git/nativefier
brew install node
npm install nativefier -g
# Create gmail
/git/natifier/nativefier -n "gMail" --internal-urls '.*.google.com.*' 'http://mail.google.com'
/bin/mv $(find . -name "gMail.app") /Applications/
/bin/rm -Rf $(find . -name gMail*)
# Create gCal
/git/natifier/nativefier -n "gCal" --internal-urls '.*.google.com.*' 'http://calendar.google.com'
/bin/mv $(find . -name "gCal.app") /Applications/
/bin/rm -Rf $(find . -name gCal*)
