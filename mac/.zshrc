# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

path+=($HOME/development/flutter/bin $HOME/Library/Android/sdk/platform-tools $HOME/bin /usr/local/bin)
path+=($HOME/developmentflutter/.pub-cache/bin $HOME/Library/Python/3.8/bin /usr/local/go/bin $HOME/.dotnet/tools)
export PATH

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
setopt interactive_comments hist_ignore_dups  octal_zeroes   no_prompt_cr  notify
setopt no_hist_no_functions no_always_to_end  append_history list_packed
setopt inc_append_history   complete_in_word  no_auto_menu   auto_pushd
setopt pushd_ignore_dups    no_glob_complete  no_glob_dots   c_bases
setopt numeric_glob_sort    share_history  promptsubst    auto_cd
setopt rc_quotes
autoload -Uz allopt zed zmv zcalc colors
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*:*:*:default' menu yes select

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \

zinit light zsh-users/zsh-completions
zinit light pawel-slowik/zsh-term-title

zinit light zsh-users/zsh-completions
# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)

zinit pack for ls_colors
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Get git plugin from oh-my-zsh
# Load OMZ Git library
zinit snippet OMZL::git.zsh

# Load Git plugin from OMZ
zinit snippet OMZP::git
zinit cdclear -q # <- forget completions provided up to this moment
setopt promptsubst

# Load theme from OMZ
# zinit snippet OMZT::gnzh

# Load normal GitHub plugin with theme depending on OMZ Git library
# zinit light NicoSantangelo/Alpharized

# Alias section
alias vim="nvim"
alias ivim="vim ~/.config/nvim/init.vim"
alias startgp="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias stopgp="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias ls="gls -F --color"
alias ll="gls -lF --color"
alias la="gls -alF --color"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/bmarden/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Activate vi / vim mode:
set -o vi
# Set reverse search
bindkey '^R' history-incremental-search-backward

# Set colored manpages
export MANPAGER='nvim +Man!'
# Remove delay when entering normal mode (vi)
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Start with beam shape cursor on zsh startup and after every command.
zle-line-init() { zle-keymap-select 'beam'}
