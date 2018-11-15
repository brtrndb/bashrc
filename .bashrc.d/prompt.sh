# Prompt.

setup_pwd() {
    local DIR="";
    if [[ $1 != 0 ]];
    then
	DIR=${PWD/$HOME/\~};
    else
	local GIT_ROOT=`git rev-parse --show-toplevel 2> /dev/null`;
	local GIT_ROOT_NAME=`basename $GIT_ROOT`;
	DIR="/${PWD/$GIT_ROOT/$GIT_ROOT_NAME}";
    fi

    if [[ $COLUMNS/4 -le ${#DIR} ]];
    then
	DIR="..."${DIR:${#DIR}-$COLUMNS/4:${#DIR}}
    fi

    echo -n "$DIR";
}

color_pwd() {
    DIR="";
    if [[ $1 != 0 ]]; then
	DIR="${YELLOW}$2"
    else
	DIR="${BLUE}git${MAGENTA}:${YELLOW}$2";
    fi

    echo -n $DIR;
}

setup_git_branch() {
    if [[ $1 != 0 ]];
    then
	echo -n "";
	return 0;
    fi

    local STATUS=`git status --porcelain 2> /dev/null | wc -l`
    local BRANCH=`git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/"`;
    local COMMIT_LOCAL=`git cherry -v origin/"$BRANCH" 2> /dev/null | wc -l`;
    local COMMIT_REMOTE=`git log --oneline HEAD..origin/"$BRANCH" 2> /dev/null | wc -l`;

    if [[ $STATUS != 0 ]];
    then
	STATUS_COLOR="${RED}"
    else
	STATUS_COLOR="${RESET}"
    fi

    local GIT_COMMIT="";
    if [[ $COMMIT_LOCAL != 0 ]];
    then
	GIT_COMMIT="$GREEN$COMMIT_LOCAL↑";
    fi
    if [[ $COMMIT_REMOTE != 0 ]];
    then
	GIT_COMMIT="$GIT_COMMIT${YELLOW}$COMMIT_REMOTE↓";
    fi

    local GIT_BRANCH="${MAGENTA}[${RESET}$STATUS_COLOR$BRANCH";
    if [ -n "$GIT_COMMIT" ]
    then
	GIT_BRANCH="$GIT_BRANCH${MAGENTA}|"
    fi

    local GIT="$GIT_BRANCH$GIT_COMMIT${MAGENTA}]${RESET}";

    echo -n " $GIT";
}

my_prompt() {
    local EXIT_CODE="$?"

    local COLOR=""
    if [ $EXIT_CODE = 0 ];
    then
	COLOR="${CYAN}";
    else
	COLOR="${RED}";
    fi

    local CHROOT="${debian_chroot:+($debian_chroot)|}";
    local TIME="\A${MAGENTA}|${RESET}";
    local USER="${COLOR}\u${MAGENTA}@${COLOR}\H${RESET}";
    IS_GIT=`git status 2> /dev/null`;
    local IS_GIT_CODE="$?";

    NEW_PWD=`setup_pwd $IS_GIT_CODE`;
    COLOR_PWD=`color_pwd $IS_GIT_CODE $NEW_PWD`;
    local TITLEBAR='\033]0;${NEW_PWD}\007';
    local DIR="${MAGENTA}:${COLOR_PWD}${RESET}";
    local GIT=`setup_git_branch $IS_GIT_CODE`;
    local SU="\$ > ";

    PS1="$TITLEBAR$CHROOT$TIME$USER$DIR$GIT$SU";
}

# Export prompt.
export PROMPT_COMMAND=my_prompt;
