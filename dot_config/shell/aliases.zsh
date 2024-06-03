P=''
if [[ $(uname) == "Darwin" ]]; then
  P=g
fi

alias vim="nvim"
alias vi="nvim"

alias ls="${P}ls -F --color"
alias ll="${P}ls -lF --color"
alias la="${P}ls -alF --color"
alias laa="${P}ls -ld .?* --color"

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep -E'
alias -g S='| sort'
alias -g L='| less'
alias -g M='| more'
alias -g ..2='../..'
alias -g ..3='../../..'
alias -g ..4='../../../..'
alias -g ..5='../../../../..'
alias -g ..6='../../../../../..'
alias -g ..7='../../../../../../..'
alias -g ..8='../../../../../../../..'
alias -g ..9='../../../../../../../../..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias cl="clear"

# npm
alias n="npm"
alias ni="npm install"
alias nid="npm install -D"
alias nr="npm run"
alias ns="npm start"

# bun
alias b="bun"
alias bi="bun install"
alias bid="bun install -D"
alias br="bun run"

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# date/time
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"

# disk usage
alias dux="${P}du -x --max-depth=1 | sort -n"
alias dud="${P}du -d 1 -h"
alias duf="${P}du -sh *"

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# history
# list the ten most used commands
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias history="fc -li"

# git
alias glo="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"

# IF CHEZMOI IS INSTALLED
[ -n "$(command -v chezmoi)" ]               \
    && alias cm="chezmoi"                    \
    && alias cma="chezmoi add"               \
    && alias cmi="chezmoi init"              \
    && alias cmd="chezmoi diff"              \
    && alias cme="chezmoi edit"              \
    && alias cmcd="chezmoi cd"               \
    && alias cmat="chezmoi add --template"   \
    && alias cmap="chezmoi apply"            \
    && alias cmet="chezmoi execute-template"
