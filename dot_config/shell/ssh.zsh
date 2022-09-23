# Check if a command exists
function can_haz() {
  which "$@" > /dev/null 2>&1
}

load-our-ssh-keys() {
  # If keychain is installed let it take care of ssh-agent, else do it manually
  if can_haz keychain; then
    eval `keychain -q --eval`
  else
    if [ -z "$SSH_AUTH_SOCK" ]; then
      # If user has keychain installed, let it take care of ssh-agent, else do it manually
      # Check for a currently running instance of the agent
      RUNNING_AGENT="$(ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]')"
      if [ "$RUNNING_AGENT" = "0" ]; then
        if [ ! -d ~/.ssh ] ; then
          mkdir -p ~/.ssh
        fi
        # Launch a new instance of the agent
        ssh-agent -s &> ~/.ssh/ssh-agent
      fi
      eval $(cat ~/.ssh/ssh-agent)
    fi
  fi

  local key_manager=ssh-add

  if can_haz keychain; then
    key_manager=keychain
  fi

  # Fun with SSH
  if [ $($key_manager -l | grep -c "The agent has no identities." ) -eq 1 ]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
      # macOS allows us to store ssh key pass phrases in the keychain, so try
      # to load ssh keys using pass phrases stored in the macOS keychain.
      #
      # You can use ssh-add -K /path/to/key to store pass phrases into
      # the macOS keychain

      # macOS Monterey deprecates the -K and -A flags. They have been replaced
      # by the --apple-use-keychain and --apple-load-keychain flags.

      # check if Monterey or higher
      # https://scriptingosx.com/2020/09/macos-version-big-sur-update/
      if [[ $(sw_vers -buildVersion) > "21" ]]; then
        # Load all ssh keys that have pass phrases stored in macOS keychain using new flags
        ssh-add --apple-load-keychain
      else ssh-add -qA
      fi
    fi

    for key in $(find ~/.ssh -type f -a \( -name '*id_rsa' -o -name '*id_dsa' -o -name '*id_ecdsa' -o -name '*id_ed25519' \))
    do
      if [ -f ${key} -a $(ssh-add -l | grep -F -c "$(ssh-keygen -l -f $key | awk '{print $2}')" ) -eq 0 ]; then
        $key_manager -q ${key}
      fi
    done
  fi
}

if [[ -z "$SSH_CLIENT" ]] || can_haz keychain; then
  # We're not on a remote machine, so load keys
  load-our-ssh-keys
fi

