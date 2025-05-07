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

case "$(uname -m)" in
"arm64")
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew_bin="/opt/homebrew/bin/brew"
  ;;
"x86_64")
  echo "intel"
  brew_bin="/usr/local/bin/brew"
  ;;
*)
  echo "error"
  ;;
esac

/bin/cp brewfile ~/.brewfile
"${brew_bin}" bundle install --file=~/.brewfile

# install atom monokai theme
/usr/local/bin/apm install atom-monokai

# # Install Oh-My-zsh ##################################################################################
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install oh-my-zsh fonts
curl -o ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Install oh-my-zsh configs
/bin/cp -f zshrc ~/.zshrc
echo "oh-my-zsh installed, safe to open with iterm."

# Install ghostty themes ###############################################################################
git clone https://github.com/catppuccin/ghostty.git ~/git/ghostty
mkdir -p ~/.config/ghostty/themes
/bin/cp -Rf ghostty/themes/* ~/.config/ghostty/themes
/bin/cp ghostty/ghostty_config ~/.config/ghostty/config


# Install asdf plugins
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc
asdf plugin-add golang
asdf plugin-add ruby
asdf plugin-add python
asdf plugin-add terraform

# # Create apps #########################################################################################
# # Install natifier
# /usr/bin/git clone https://github.com/jiahaog/nativefier.git ~/git/nativefier
# brew install node
# cd ~/git/nativefier
# npm install nativefier -g && echo "nativefier installed"
# # Create gmail
# /usr/local/bin/nativefier -n "gMail" --internal-urls '.*.google.com.*' 'http://mail.google.com'
# /bin/mv -fv $(find . -name "gMail.app") /Applications/ && echo "gMail.app installed."
# /bin/rm -Rf $(find . -name gMail*)
