export ZSH="$HOME/.oh-my-zsh"
source ~/.bash_profile

ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z)

# ruby
export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin"

# IBus-bamboo
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

eval "$(rbenv init - zsh)"

# alias
alias ls="eza -GF --icons"
alias ll="eza --long --icons --classify"
alias la="eza --all --long --icons --classify"

source $ZSH/oh-my-zsh.sh
