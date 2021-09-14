#!/bin/sh

if [[ $(whoami) == "root" ]]; then
  echo "do not run this as root."
  exit 1
fi

xcode-select --install

# Set up vim ########################################################################################
/bin/cp vimrc ~/.vimrc
/bin/cp -Rf vim ~/.vim

# Install color themes
/usr/bin/git clone https://github.com/dracula/iterm.git ~/git/dracula

if [[ -d /usr/local/lib/pkgconfig ]]; then
    sudo chown -R $(whoami) /usr/local/lib/pkgconfig && echo "/usr/local/lib/pkgconfig permissions set"
fi

# Install homebrew ###################################################################################
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
/bin/cp brewfile ~/.brewfile
/usr/local/bin/brew bundle

# install atom monokai theme
/usr/local/bin/apm install atom-monokai

# Install Oh-My-zsh ##################################################################################
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
/usr/bin/git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# Install oh-my-zsh fonts
mkdir ~/git
/usr/bin/git clone https://github.com/Karmenzind/monaco-nerd-fonts.git ~/git/monaco-nerd-fonts
/bin/cp ~/git/monaco-nerd-fonts/fonts/* /Library/Fonts
# Install oh-my-zsh configs
/bin/cp -f zshrc ~/.zshrc
echo "oh-my-zsh installed, safe to open with iterm."

# Install asdf plugins
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc
asdf plugin-add golang
asdf plugin-add ruby
asdf plugin-add python
asdf plugin-add terraform

# Create apps #########################################################################################
# Install natifier
/usr/bin/git clone https://github.com/jiahaog/nativefier.git ~/git/nativefier
brew install node
cd ~/git/nativefier
npm install nativefier -g && echo "nativefier installed"
# Create gmail
/usr/local/bin/nativefier -n "gMail" --internal-urls '.*.google.com.*' 'http://mail.google.com'
/bin/mv -fv $(find . -name "gMail.app") /Applications/ && echo "gMail.app installed."
/bin/rm -Rf $(find . -name gMail*)
