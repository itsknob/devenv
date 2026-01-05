#!/bin/bash

missing() {
    # Check for CLI Tool
    if hash $1 &>2; then
        echo "Already have $1"
        return 1 #false - not missing
    elif $(\ls /Applications | grep -i "$1" &>2 ); then
        # Check Applications
        echo "Already have $1 in Applications"
        return 1 #false - not missing
    elif $(brew list | grep -i $tool); then
        echo "Already have $1 via Brew"
        return 1 #false - not missing
    else
        echo "Did not find $1"
        return 0 #true - missing 
    fi
}

# Install Brew
missing brew && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
# Install zsh
missing zsh && echo "Installing zsh" && brew install zsh && echo "Installing oh-my-zsh" && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Dev Tools via Brew
brew_tools="""
tmux
stow
mise
zoxide
eza
"""
# nvim
# fzf
# bat
for tool in $brew_tools; do
    if missing $tool; then
        echo "Installing $tool"
        brew install $tool
    fi
done

## Languages
langs=""
tools=""
# Go
missing go && langs+="go "
missing rustup && langs+="rustup "
missing java && langs+="java@17 "
missing node && langs+="node "
if [[ -n $langs ]]; then
    echo "Installing $langs"
    mise use -g "$langs"
else
    echo "Already have Languages"
fi

# Reset variable
tools=""
## Tools via mise
missing jq && tools+="jq "
missing fzf && tools+="fzf "
missing bat && tools+="bat "
if [[ -n $tools ]]; then
    echo "Installing $tools"
    mise use -g "$tools"
else
    echo "Already have Tools"
fi

# Install Window Manager
if missing aerospace; then
    echo "Installing Aerospace"
    brew install --cask nikitabobko/tap/aerospace
fi

# Install iterm2
if missing iterm2; then
    echo "Installing iTerm2"
    brew install --cask iterm2
fi
# Install Intellij
if missing intellij-idea; then
    echo "Installing Intellij Idea"
    brew install --cask intellij-idea
fi
# Install Raycast Spotlight Replacement
if missing raycast; then
    echo "Installing Raycast"
    brew install --cask raycast
fi
# Install Ollama
if missing ollama; then
    echo "Installing Ollama"
    brew install --cask ollama
fi

## Clone Personal Files
mkdir ~/code &>2
mkdir ~/personal &>2

# nvim config
if missing nvim; then
    echo "Installing NeoVim"
    brew install neovim
    echo "Installing nvim config"
    git clone https://github.com/itsknob/nvim.git ~/.config/nvim 
else
    echo "Already have NeoVim"
    if [[ -e ~/.config/nvim/init.lua ]]; then
        echo "Already have nvim config"
    else
        echo "Installing nvim config"
        git clone https://github.com/itsknob/nvim.git ~/.config/nvim
    fi
fi

## tmux and zsh dotfiles
echo "Assuming we're in DEV_ENV"
pushd env &>2
echo "Unstowing ./env to ~/"
stow -t ~/ zsh tmux
popd &>2

## Work Tools
sb=""
missing slack && sb+="slack "
missing spotify && sb+="spotify "
missing "rancher desktop" && sb+="rancher "
missing obsidian && sb+="obsidian "
if [[ -n $sb ]]; then
    #Normalize
    echo "Installing: $sb"
    brew install --cask $sb
else 
    echo "Already have Work Tools"
fi

echo "---------- Done ----------"
echo "Java Home: $JAVA_HOME"
echo "Java Version: $(java --version)"
echo "Node Path: $NODE_PATH"
echo "Node Version: $(node --version)"
echo "Go Root: $GOROOT"
echo "Go Version: $(go version)"
echo "Rust which: $(which rustc)"
echo "Rust Version: $(rustc --version)"
