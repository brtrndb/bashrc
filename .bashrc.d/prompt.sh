# Prompt.

my_prompt(){
    local EXIT_CODE="$?"

    local COLOR=""
    if [ $EXIT_CODE = 0 ];
    then
	COLOR="$CYAN";
    else
	COLOR="$RED";
    fi

    local CHROOT="${debian_chroot:+($debian_chroot)|}";
    local TIME="\A$MAGENTA|$RESET";
    local USER="${COLOR}\u${BLUE}@${COLOR}\H${RESET}";

    local DIR=${PWD/$HOME/\~};
    if [[ $COLUMNS/4 -le ${#DIR} ]];
    then
	DIR="..."${DIR:${#DIR}-$COLUMNS/4:${#DIR}}
    fi
    DIR="$MAGENTA:$YELLOW$DIR$RESET";

    local STATUS=`git status --porcelain 2> /dev/null | wc -l`
    if [[ 0 != $STATUS ]];
    then
	COLOR="$RED"
    else
	COLOR="$RESET"
    fi

    local GIT=""
    local BRANCH=`git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/"`
    local COMMIT_LOCAL=`git cherry -v origin/"$BRANCH" 2> /dev/null | wc -l`
    local COMMIT_REMOTE=`git log --oneline HEAD..origin/"$BRANCH" 2> /dev/null | wc -l`
    if [ -z "$BRANCH" ]
    then
	GIT="";
    else
	GIT=" $MAGENTA[$RESET$COLOR$BRANCH$MAGENTA";
	local COMMIT="";
	if [[ 0 != $COMMIT_LOCAL ]];
	then
	    COMMIT="$GREEN$COMMIT_LOCAL↑";
	fi
	if [[ 0 != $COMMIT_REMOTE ]];
	then
	    COMMIT="$COMMIT$YELLOW$COMMIT_REMOTE↓";
	fi
	if [ -n "$COMMIT" ]
	then
	    GIT="$GIT|"
	fi
	GIT="$GIT$COMMIT$MAGENTA]$RESET";
    fi

    local SU="\$ > ";

    PS1="$CHROOT$TIME$USER$DIR$GIT$SU";
}

# Export prompt.
export PROMPT_COMMAND=my_prompt;
