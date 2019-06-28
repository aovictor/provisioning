Provisioning
===============

./install.sh from this directory


Setup
================

Pyenv
- brew install pyenv
	- brew link
	- echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
	- echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
	- echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
	- ~/.zshenv
	- sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
	- pyenv install <version #>
	- pyenv global <version #>

Applications
- brew cask install atom
- brew cask install iterm2
- zsh
	- sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

- Theme

To install this theme for use in Oh-My-Zsh, clone this repository into your OMZ custom/themes directory.

$ git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
You then need to select this theme in your ~/.zshrc:

ZSH_THEME="powerlevel9k/powerlevel9k"

git clone https://github.com/Karmenzind/monaco-nerd-fonts.git
cp monaco-nerd-fonts/* /Library/fonts

select "12 Monaco Nerd Font Complete"

Apply settings
cp .zshrc ~/.zshrc
