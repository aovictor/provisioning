#!/usr/bin/env bash

# Ask for target git repo directory (with default)
default_target_git_dir="$HOME/git"
read -r -p "Enter target git repo directory [${default_target_git_dir}]: " target_git_dir
target_git_dir=${target_git_dir:-$default_target_git_dir}
echo "Using target git repo directory: ${target_git_dir}"

if [[ "$(whoami)" == "root" ]]; then
  echo "do not run this as root."
  exit 1
fi

if ! command -v xcode-select &> /dev/null; then
  xcode-select --install
fi

# Set up vim ########################################################################################
/bin/cp vimrc ~/.vimrc
/bin/cp -Rf vim ~/.vim

# Install color themes
/usr/bin/git clone https://github.com/dracula/iterm.git ${target_git_dir}/dracula

if [[ -d /usr/local/lib/pkgconfig ]]; then
    sudo chown -R "$(whoami) "/usr/local/lib/pkgconfig && echo "/usr/local/lib/pkgconfig permissions set"
fi

# Install homebrew ###################################################################################
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
fi

/bin/cp brewfile ~/.brewfile
/bin/cp -f zshrc ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle


# Install Oh-My-zsh ##################################################################################
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# install theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$target_git_dir/.oh-my-zsh/custom}/themes/powerlevel10k"
# install font
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf

# Install oh-my-zsh configs
/bin/cp -f zshrc ~/.zshrc
/bin/cp -f p10k.zsh ~/.p10k.zsh
echo "oh-my-zsh installed"

# install ghostty
ghostty_dir="${target_git_dir}/ghostty"
git clone https://github.com/catppuccin/ghostty.git "${target_git_dir}/ghostty"
mkdir -p ~/.config/ghostty/themes
cp -Rf "${ghostty_dir}/themes" ~/.config/ghostty/
/bin/cp ghostty_config ~/.config/ghostty/config

# Install asdf plugins
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc
asdf plugin add golang
asdf plugin add ruby
asdf plugin add python
asdf plugin add terraform
