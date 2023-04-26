alias vim="nvim"
alias vi="nvim"

alias ls="gls -F --color"
alias ll="gls -lF --color"
alias la="gls -alF --color"
alias laa="gls -ld .?* --color"

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

# npm
alias n="npm"
alias ni="npm install"
alias nr="npm run"


# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# date/time
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"

# disk usage
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# history
# list the ten most used commands
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias history="fc -li"

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
