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
//bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/bin/cp brewfile ~/.brewfile
/bin/cp -f zshrc ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle

# Install Oh-My-zsh ##################################################################################
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# install theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
# install font
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf

# Install oh-my-zsh configs
/bin/cp -f zshrc ~/.zshrc
/bin/cp -f p10k.zsh ~/.p10k.zsh
mkdir -p ~/.config/ghostty
/bin/cp ghostty_config ~/.config/ghostty/config
echo "oh-my-zsh installed"

# Install asdf plugins
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc
asdf plugin add golang
asdf plugin add ruby
asdf plugin add python
asdf plugin add terraform
