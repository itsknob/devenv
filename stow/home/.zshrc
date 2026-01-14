# Variables
user=$USER
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/$user/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(z git aws shrink-path)

# fzf plugin, must be exported before oh-my-zsh is sourced
# export FZF_BASE=/opt/homebrew/bin/fzf
export FZF_BASE="/Users/$user/personal/fzf/bin/fzf"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
source <($FZF_BASE --zsh)

source $ZSH/oh-my-zsh.sh
# source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Variables

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
#
# eval "dircolors ~/.dircolors/dircolors"
alias ls="eza"
alias la="ls -laF"
alias lt="ls -la --tree --level=2"
alias cat="bat"
alias vim="nvim"

# NPM
alias nt='npm t'

# Git
alias gl='git log --graph --oneline'
alias 'git log'="git log --graph --oneline"
alias gs='gst'
unalias gd
gd() {
  exclude=""
  while getopts ':e:' ex; do
    case $ex in
      e)
        exclude=":(exclude)$OPTARG"
        ;;
    esac
  done
  git diff ${@:3} $exclude
}

# Dotnet
alias dotnet="dotnetx64"

function get_card() {
    # two cards, always consider ace 11 (highest)
    number=$(shuf -i 2-11 -n 1)
    suit=$(shuf -i 1-4 -n 1)
    echo $number $suit
}

function get_card_symbol {
    spade=♤
    club=♧
    heart=♥
    diamond=♦

    number=$1
    suit=$2
    # number=$(shuf -i 1-13 -n 1)
    # suit=$(shuf -i 1-4 -n 1)
    number_symbol=""
    suit_symbol=""

    card=""
    case "$number" in
        "11")
            number_symbol="A"
            ;;
        "10")
            eleven=$(shuf -i 1-4 -n 1)
            case "$eleven" in 
                "1")
                    number_symbol="10"
                    ;;
                "2")
                    number_symbol="J"
                    ;;
                "3")
                    number_symbol="Q"
                    ;;
                "4")
                    number_symbol="K"
                    ;;
            esac
            ;;
        "12")
            number_symbol="Q"
            ;;
        "13")
            number_symbol="K"
            ;;
        *)
            number_symbol="$number"
            ;;
    esac

    case "$suit" in
        "1")
            suit_symbol=$spade
            ;;
        "2")
            suit_symbol=$heart
            ;;
        "3")
            suit_symbol=$club
            ;;
        "4")
            suit_symbol=$diamond
            ;;
    esac

    card="$number_symbol$suit_symbol"

    echo $card
}

# Check Processes
psp() { ps -ef | head -1 && ps -ef | grep "$@" | grep -v grep }
pspi() { ps -ef | head -1 && ps -ef | grep -i "$@" | grep -v grep }
killeq() { kill $(psp eqMac | tail -n 1 | awk '{print $2}') }

# Display scripts from package.json in local directory
scripts() {
  if [[ -f "package.json" ]]; then 
    cat package.json | pcre2grep -Mo '"scripts": (?s){.*?}(?:,\n)'
  else
    echo "No package.json here"
  fi
}

# Get Version from package.json
version() {
  if [[ -f "package.json" ]]; then
    cat package.json | grep version
  else
    echo "No package.json here"
  fi
}

# Edit zshrc easily
zshrc() {
  vim ~/.zshrc
}

# Get Current Public IP Address
ip() {
  curl ifconfig.me
}

# Java Setup
setjava() {
  if [[ -z $1 ]] then
    echo "Available Versions 1.8, 17, 21"
  fi
  V=$1
  if [[ "$V" -eq 8 ]]; then
    V="1.8.0_312"
  fi
  export JAVA_HOME=`/usr/libexec/java_home -v ${V}`
  echo $JAVA_HOME
  echo 
  # if [[ $1 -eq 8 ]] then
  #   export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home"
  # elif [[ $1 -eq 11 ]] then
  #   export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home"
  # elif [[ $1 -eq 17 ]] then
  #   export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"
  # elif [[ $1 -eq 21 ]] then
  #   export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"
  # else 
  #   export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home"
  # fi 
}
export PATH="/opt/apache-maven-3.8.4/bin:$PATH"
export M2_HOME=/opt/apache-maven-3.8.4
export M2=$M2_HOME/bin
export MAVEN_OPTS="-Xms256m -Xmx512m"
export PATH="$M2:$PATH"

export PATH=$PATH:$HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet

export PATH="/Library/Frameworks/Mono.framework/Versions/Current/bin:/usr/local/opt/node@14/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [  -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# # Prompts
prompt_dir() {
  # prompt_segment blue $CURRENT_FG ' %15<...<%~%<< '
  setopt prompt_subst
  source ~/.oh-my-zsh/plugins/shrink-path/shrink-path.plugin.zsh
  prompt_segment blue $CURRENT_FG "[$(date +%H:%M:%S)] $(shrink_path -f)"
}

prompt_context() {
  local name=$(echo knob)
  # read card1_value card1_suit < <(get_card)
  # read card2_value card2_suit < <(get_card)
  # local card1=$(get_card_symbol $((card1_value)) $((card1_suit)))
  # local card2=$(get_card_symbol $((card2_value)) $((card2_suit)))

  prompt_segment yellow $CURRENT_FG '%K{yellow}knob '
  # prompt_segment red $CURRENT_FG $card1
  # prompt_segment red $CURRENT_FG $card2
  # if [[ 21 -eq $((card1_value + card2_value)) ]] then
  #   prompt_segment green $CURRENT_FG "🎉 Black Jack! 🎉"
  # fi
}

#
# zle-line-init() {
#   emulate -L zsh
#
#   [[ $CONTEXT == start ]] || return 0
#
#   while true; do
#     zle .recursive-edit
#     local -i ret=$?
#     [[ $ret == 0 && $KEYS == $'\4' ]] || break
#     [[ -o ignore_eof ]] || exit 0
#   done
#
#   local saved_prompt=$PROMPT
#   local saved_rprompt=$RPROMPT
#   PROMPT=" »"
#   RPROMPT=''
#   zle .reset-prompt
#   PROMPT=$saved_prompt
#   RPROMPT=$saved_rprompt
#
#   if (( ret )); then
#     zle .send-break
#   else
#     zle .accept-line
#   fi
#   return ret
# }
#
# zle -N zle-line-init

# alias awscreds="stskeygen -a b2bcore"
awscreds() {
   cmd="stskeygen "

   while getopts "a: r: p: A" flag
   do
       case $flag in
           a) cmd+="-a $OPTARG ";;
           r) cmd+="-r $OPTARG ";;
           p) cmd+="-p $OPTARG "; export AWS_PROFILE=$OPTARG;;
           A) cmd+="--admin ";;
           ?) echo "invalid arg $flag";;
       esac
   done

   cmd+="--duration 43200 " # 12h
   echo $cmd
   eval " $cmd"
}

alias b2b="awscreds -a b2bcore"
alias om="awscreds -a commerce-order-management -r aws-commerce-order-management -A"
alias setaws="cp ~/.aws/credentials ~/.aws/credentials.toml; awk '{print toupper($1) $2 $3}' ~/.aws/credentials.toml | grep \[DEFAULT\] -A 6 | grep AWS_ | sed -e 's/\(AWS.*\)=\(.*\)/export \1=\2/' > aws.env | source aws.env | rm aws.env"

export NODE_PATH=/Users/stephen.reilly/.nvm/versions/node/v14.18.1/bin/node

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/stephen.reilly/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/stephen.reilly/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/stephen.reilly/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/stephen.reilly/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Fix Error in VSCode with jest plugin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/stephen.reilly/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# FZF
# export FZF_BASE=/opt/homebrew/bin/fzf
# source <(fzf --zsh)

# Created by `pipx` on 2024-12-10 15:33:38
export PATH="$PATH:/Users/stephen.reilly/.local/bin"

# Set NVIM to default editor for zsh
export EDITOR=nvim
export VISUAL="$EDITOR"

## Completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOROOT=/Users/knob/.go
export GOPATH=/Users/knob/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)" # z for cd

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/knob/.lmstudio/bin"
# End of LM Studio CLI section

# Ensure SSH Keys are loading in keychain
ssh-add --apple-load-keychain -q


