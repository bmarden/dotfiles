# Example setup https://zdharma-continuum.github.io/zinit/wiki/Example-Minimal-Setup/

# Must Load OMZ Git library
zinit snippet OMZL::git.zsh
# Load Git plugin from OMZ
zinit snippet OMZP::git
zinit cdclear -q # <- forget completions provided up to this moment
# Load oh my zsh plugins

zinit wait lucid for \
  OMZL::clipboard.zsh \
  OMZP::cp \
  OMZP::encode64 \
  OMZP::extract \
  OMZP::jsontools \
  OMZP::brew 

# Load other plugins
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
      OMZP::colored-man-pages \
  as"completion" \
        OMZP::docker/_docker \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

zinit wait lucid light-mode for \
  zsh-users/zsh-history-substring-search \
  unixorn/1password-op.plugin.zsh \
  djui/alias-tips \
  ntnyq/omz-plugin-pnpm \
  thirteen37/fzf-brew

zinit light "jeffreytse/zsh-vi-mode"

# This is the fzf plugin and it must be loaded after zsh-vi-mode
zinit ice lucid wait
zinit snippet OMZP::fzf

# Load powerlevel10k theme
zinit ice depth"1" 
zinit light romkatv/powerlevel10k

# Load fzf 
# zinit pack for fzf
