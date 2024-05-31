export BAT_THEME="ansi"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Load zsh-vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Load big three via Turbo
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Additional plugins
# Postpone `fzf` loading 
zinit ice lucid wait
zinit snippet OMZP::fzf
zinit snippet OMZP::git
zinit light Aloxaf/fzf-tab

# Load Completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Forge --> run the following commands to generate completions
# forge completions zsh > /Users/$USER/.local/share/zinit/completions/_forge
# cast completions zsh > /Users/$USER/.local/share/zinit/completions/_cast
# anvil completions zsh > /Users/$USER/.local/share/zinit/completions/_anvil

# Completion Styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
unsetopt BEEP

# Aliases
alias cat=bat
alias v='/opt/homebrew/bin/nvim'
# alias vf='nvim $(fzf --height 40% --reverse)'

# List
alias l='eza -l --icons --git'
alias ld='eza -lD --header --hyperlink --git --git-repos'
alias lf='eza -lf --header --hyperlink --git --git-repos'
alias ls='eza -alB --header --hyperlink --git --git-repos --icons --group-directories-first --sort=extension'
alias lt='eza -alBT --level=2 --header --hyperlink --git --git-repos --icons --group-directories-first --sort=extension'
alias ltt='eza -alBT --level=3 --header --hyperlink --git --git-repos --icons --group-directories-first --sort=extension'

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Navigation
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# History
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Export paths
export EDITOR=/opt/homebrew/bin/nvim

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                        # load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"      # load nvm bash_completion

# Shell integrations
eval "$(zoxide init --cmd cd zsh)"
