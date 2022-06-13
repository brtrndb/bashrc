# Prompt.

function get_current_git_folder() {
  local GIT_ROOT=$(git rev-parse --show-toplevel 2> /dev/null);
  local DIR_PATH=${PWD/${GIT_ROOT}/$(basename ${GIT_ROOT})};

  echo ${DIR_PATH};
}

function get_git_infos() {
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

  local GIT_INFOS="${MAGENTA}[${RESET}${BRANCH_NAME}${MAGENTA}|${GIT_STATUS}${MAGENTA}]${RESET}";

  echo ${GIT_INFOS};
}

function get_current_dir() {
  local DIR_PATH=${PWD/$HOME/\~};
  echo ${DIR_PATH};
}

function my_prompt() {
  local LAST_CMD_EXIT_CODE="$?";
  local USER_COLOR=$([[ ${LAST_CMD_EXIT_CODE} = 0 ]] && echo ${CYAN} || echo ${RED});

  local IS_GIT_REPO=$(git rev-parse --is-inside-work-tree &>/dev/null && echo 0 || echo 1);
  local IS_GIT_SUBMODULE=$(git rev-parse --show-superproject-working-tree &> /dev/null && echo 0 || echo 1);

  local CURRENT_DIR;
  local GIT_INFOS;

  if [[ ${IS_GIT_REPO} = 0 ]]; then
    CURRENT_DIR=$(get_current_git_folder)
    GIT_INFOS=$(get_git_infos);
  else
    CURRENT_DIR=$(get_current_dir);
  fi

  local PS_TITLE="\\033]0;${CURRENT_DIR}\\007";
  local PS_CHROOT="${debian_chroot:+($debian_chroot)|}";
  local PS_TIME="\\A${MAGENTA}|${RESET}";
  local PS_USER="${USER_COLOR}\\u${MAGENTA}@${USER_COLOR}\\H${MAGENTA}:${RESET}";
  local PS_GIT=$([[ ${IS_GIT_REPO} = 0 ]] && echo "${BLUE}$([[ ${IS_GIT_SUBMODULE} = 1 ]] && echo "sub")git${MAGENTA}:${RESET}");
  local PS_CURRENT_DIR="${YELLOW}${CURRENT_DIR}${RESET}";
  local PS_GIT_BRANCH=$([[ ${IS_GIT_REPO} = 0 ]] && echo " ${GIT_INFOS}");
  local PS_SU="\$ > ";

  PS1="${PS_TITLE}${PS_CHROOT}${PS_TIME}${PS_USER}${PS_GIT}${PS_CURRENT_DIR}${PS_GIT_BRANCH}${PS_SU}";
}

# Export prompt.
export PROMPT_COMMAND=my_prompt;
