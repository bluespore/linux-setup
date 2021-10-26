export EDITOR='nvim'
export ENABLE_CORRECTION='true'
export BAT_THEME='Dracula'

# Installation directory for `n` node verions
export N_PREFIX=$HOME/.n

# Dracula theme for FZF
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

DISABLE_AUTO_UPDATE="true"
ZSH=/usr/share/oh-my-zsh/
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

export PATH=$HOME/.config/rofi/bin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

alias sesh='tmuxinator'
alias hs='toggle-headset-profile'
