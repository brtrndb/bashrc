if ! shopt -oq posix; then
  if [ -f ./yarn-completion/yarn-completion.bash ]; then
    . ./yarn-completion/yarn-completion.bash
  fi
fi
