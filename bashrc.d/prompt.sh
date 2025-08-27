# Prompt.

function get_git_status() {
  local NB_FILES=$(git status --porcelain 2> /dev/null);
  local NB_FILES_UNTRACKED=$(echo "${NB_FILES}" | grep -cE '^\?\?');
  local NB_FILES_MODIFIED=$(echo "${NB_FILES}" | grep -cE '^(\ |A)M');
  local NB_FILES_ADDED=$(echo "${NB_FILES}" | grep -cE '^(A|M)');
  local NB_FILES_DELETED=$(echo "${NB_FILES}" | grep -cE '^\ ?D');
  local NB_FILES_RENAMED=$(echo "${NB_FILES}" | grep -cE '^\ ?R');
  local NB_FILES_CONFLICT=$(echo "${NB_FILES}" | grep -cE '^\ ?U');
  local BRANCH_NAME=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/');
  local NB_COMMIT_LOCAL=$(git cherry -v "origin/$BRANCH_NAME" 2> /dev/null | wc -l);
  local NB_COMMIT_REMOTE=$(git log --oneline "HEAD..origin/$BRANCH_NAME" 2> /dev/null | wc -l);

  local ICON_OK="✓";
  local ICON_UNTRACKED="?";
  local ICON_MODIFIED="±";
  local ICON_ADDED="☑";
  local ICON_DELETED="☒";
  local ICON_RENAMED="⇋";
  local ICON_CONFLICT="⚠";
  local ICON_LOCAL="↿";
  local ICON_REMOTE="⇂";

  local GIT_STATUS;
  if [[ -z ${NB_FILES} ]]; then
    GIT_STATUS+="${GREEN}${ICON_OK}${RESET}";
  fi
  if [[ ${NB_FILES_UNTRACKED} != 0 ]]; then
    GIT_STATUS+="${RED}${ICON_UNTRACKED}${NB_FILES_UNTRACKED}${RESET}";
  fi
  if [[ ${NB_FILES_MODIFIED} != 0 ]]; then
    GIT_STATUS+="${RED}${ICON_MODIFIED}${NB_FILES_MODIFIED}${RESET}";
  fi
  if [[ ${NB_FILES_ADDED} != 0 ]]; then
    GIT_STATUS+="${GREEN}${ICON_ADDED}${NB_FILES_ADDED}${RESET}";
  fi
  if [[ ${NB_FILES_DELETED} != 0 ]]; then
    GIT_STATUS+="${RED}${ICON_DELETED}${NB_FILES_DELETED}${RESET}";
  fi
  if [[ ${NB_FILES_RENAMED} != 0 ]]; then
    GIT_STATUS+="${GREEN}${ICON_RENAMED}${NB_FILES_RENAMED}${RESET}";
  fi
  if [[ ${NB_FILES_CONFLICT} != 0 ]]; then
    GIT_STATUS+="${RED}${ICON_CONFLICT}${NB_FILES_CONFLICT}${RESET}";
  fi
  if [[ ${NB_COMMIT_LOCAL} != 0 ]]; then
    GIT_STATUS+="${GREEN}${ICON_LOCAL}${NB_COMMIT_LOCAL}${RESET}";
  fi
  if [[ ${NB_COMMIT_REMOTE} != 0 ]]; then
    GIT_STATUS+="${YELLOW}${ICON_REMOTE}${NB_COMMIT_REMOTE}${RESET}";
  fi

  local GIT_STATUS_COLORED="${MAGENTA}[${RESET}${BRANCH_NAME}${MAGENTA}|${GIT_STATUS}${MAGENTA}]${RESET}";

  echo "${GIT_STATUS_COLORED}";
}

function my_prompt() {
  # Terminal title.
  local PS_TITLE="\\033]0;${PWD/$HOME/\~}\\007";

  # Chroot.
  local PS_CHROOT="${debian_chroot:+($debian_chroot)|}";

  # Date & time.
  local PS_TIME="\\A${MAGENTA}|${RESET}";

  # Current user.
  local LAST_CMD_EXIT_CODE="$?";
  local USER_COLOR=$([[ ${LAST_CMD_EXIT_CODE} = 0 ]] && echo "${CYAN}" || echo "${RED}");
  local PS_USER="${USER_COLOR}\\u${MAGENTA}@${USER_COLOR}\\H${MAGENTA}:${RESET}";

  # Current directory & Git information.
  local CURRENT_DIR;
  local PS_CURRENT_LOCATION;
  local IS_GIT_REPO=$(git rev-parse --is-inside-work-tree &>/dev/null && echo 0 || echo 1);
  if [[ ${IS_GIT_REPO} = 0 ]]; then
    local GIT_REPO_NAME;
    local GIT_SUPER_PATH=$(git rev-parse --show-superproject-working-tree 2> /dev/null);
    local IS_GIT_SUBMODULE=$([[ "${GIT_SUPER_PATH}" = "" ]] && echo "0" || echo "1");
    if [[ "${IS_GIT_SUBMODULE}" = "0" ]]; then
      local GIT_ROOT_PATH=$(git rev-parse --show-toplevel 2> /dev/null);
      local GIT_ROOT_NAME=$(basename "${GIT_ROOT_PATH}");

      CURRENT_DIR=${PWD/${GIT_ROOT_PATH}/};

      GIT_REPO_NAME="${GIT_ROOT_NAME}"
    else
      local GIT_SUPER_NAME=$(basename "${GIT_SUPER_PATH}");

      local GIT_SUBMODULE_PATH=$(git rev-parse --show-toplevel 2> /dev/null);
      local GIT_SUBMODULE_NAME=$(basename "${GIT_SUBMODULE_PATH}");

      CURRENT_DIR=${PWD/${GIT_SUBMODULE_PATH}/};

      GIT_REPO_NAME="${GIT_SUPER_NAME}/${GIT_SUBMODULE_NAME}"
    fi;

    CURRENT_DIR=$([[ "${CURRENT_DIR}" = "" ]] && echo "/" || echo "${CURRENT_DIR}");

    local GIT_STATUS=$(get_git_status);

    PS_TITLE="\\033]0;${GIT_REPO_NAME}${CURRENT_DIR}\\007";
    PS_CURRENT_LOCATION="${BLUE}${GIT_REPO_NAME}${MAGENTA}:${YELLOW}${CURRENT_DIR}${RESET} ${GIT_STATUS}${RESET}";
  else
    local CURRENT_DIR=${PWD/$HOME/\~};

    PS_TITLE="\\033]0;${CURRENT_DIR}\\007";
    PS_CURRENT_LOCATION="${YELLOW}${CURRENT_DIR}${RESET}";
  fi

  # Current privileges.
  local PS_SU="\$ > ";

  # Prompt.
  PS1="${PS_TITLE}${PS_CHROOT}${PS_TIME}${PS_USER}${PS_CURRENT_LOCATION}${PS_SU}";
}

# Export prompt.
export PROMPT_COMMAND=my_prompt;
