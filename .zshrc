# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add local bin scripts to PATH
export PATH=$HOME/.local/bin:$PATH

# Add scripts installed by cargo
export PATH=$HOME/.cargo/bin:$PATH

# Editor
export EDITOR=nvim

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -la"
alias vi ="nvim"

#For autocomplete
fpath=(~/.config/zsh/zsh-completions/src $fpath)
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

source $HOME/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Syntax Highlighting
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Auto Suggestions
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# History Substring Search
source $HOME/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Press arrow up key to search 
bindkey '^[[A' history-substring-search-up
# For arrow down key
bindkey '^[[B' history-substring-search-down

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
