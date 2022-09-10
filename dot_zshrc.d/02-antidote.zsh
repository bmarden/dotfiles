#
# 02-antidote - Use the antidote plugin manager.
#

# use antidote for plugin management
# should not be necessary since chezmoi is loading the repo
if ! [[ -e ${ZDOTDIR:-~}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load
