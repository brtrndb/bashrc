# Prompt.

my_prompt() {
  local LAST_CMD_EXIT_CODE="$?";
  local USER_COLOR=$([ "$LAST_CMD_EXIT_CODE" = "0" ] && echo "$CYAN" || echo "$RED");

  git rev-parse --git-dir > /dev/null 2>&1;
  local IS_GIT_REPO="$?";

  local GIT_INFOS;
  local CURRENT_DIR;
  if [ "$IS_GIT_REPO" != "0" ]; then
    CURRENT_DIR=${PWD/$HOME/\~};
  else
    local GIT_ROOT=$(git rev-parse --show-toplevel 2> /dev/null);
    local IS_GIT_SUBMODULE=$([ -z $(git rev-parse --show-superproject-working-tree  2> /dev/null) ] && echo "0" || echo "1");

    CURRENT_DIR="/${PWD/$GIT_ROOT/$(basename "$GIT_ROOT")}";

    local GIT_NB_FILES=$(git status --porcelain 2> /dev/null | wc -l);
    local GIT_BRANCH_NAME=$(git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/");
    local GIT_NB_COMMIT_LOCAL=$(git cherry -v "origin/$GIT_BRANCH_NAME" 2> /dev/null | wc -l);
    local GIT_NB_COMMIT_REMOTE=$(git log --oneline "HEAD..origin/$GIT_BRANCH_NAME" 2> /dev/null | wc -l);

    local GIT_STATUS;
    local SHOW_STATUS="0";
    if [ "$GIT_NB_FILES" != "0" ]; then
      SHOW_STATUS="1";
      GIT_STATUS="$RED±$GIT_NB_FILES$RESET";
    fi
    if [ "$GIT_NB_COMMIT_LOCAL" != "0" ]; then
      SHOW_STATUS="1";
      GIT_STATUS="$GIT_STATUS$GREEN↑$GIT_NB_COMMIT_LOCAL$RESET";
    fi
    if [ "$GIT_NB_COMMIT_REMOTE" != "0" ]; then
      SHOW_STATUS="1";
      GIT_STATUS="$GIT_STATUS$YELLOW↓$GIT_NB_COMMIT_REMOTE$RESET";
    fi

    GIT_INFOS="${MAGENTA}[$RESET$GIT_BRANCH_NAME$([ "$SHOW_STATUS" = "1" ] && echo "$MAGENTA|$GIT_STATUS")$MAGENTA]$RESET";
  fi

  if [[ $COLUMNS/4 -le ${#CURRENT_DIR} ]]; then
    CURRENT_DIR="..."${CURRENT_DIR:${#CURRENT_DIR}-$COLUMNS/4:${#CURRENT_DIR}}
  fi

  local PS_TITLEBAR="\\033]0;$CURRENT_DIR\\007";
  local PS_CHROOT="${debian_chroot:+($debian_chroot)|}";
  local PS_TIME="\\A$MAGENTA|$RESET";
  local PS_USER="$USER_COLOR\\u$MAGENTA@$USER_COLOR\\H$MAGENTA:$RESET";
  local PS_GIT="$BLUE$([ "$IS_GIT_SUBMODULE" = "1" ] && echo "sub")git$MAGENTA:$RESET";
  local PS_CURRENT_DIR="$YELLOW$CURRENT_DIR$RESET";
  local PS_GIT_BRANCH=$([ "$IS_GIT_REPO" = "0" ] && echo " $GIT_INFOS");
  local PS_SU="\$ > ";

  PS1="$PS_TITLEBAR$PS_CHROOT$PS_TIME$PS_USER$PS_GIT$PS_CURRENT_DIR$PS_GIT_BRANCH$PS_SU";
}

# Export prompt.
export PROMPT_COMMAND=my_prompt;
