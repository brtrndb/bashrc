# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#
# Custom part.
#

# Colors.
RST="\[\033[0m\]"	# reset
BLK="\[\033[30m\]"	# black
RED='\[\033[31m\]'	# red
GRN="\[\033[32m\]"	# green
YEL="\[\033[33m\]"	# yellow
BLE="\[\033[34m\]"	# blue
MAG="\[\033[35m\]"	# magenta
CYN="\[\033[36m\]"	# cyan
WHT="\[\033[37m\]"	# white

# Aliases.
alias ls='ls -lhF --color=auto';
alias ld='ls -lhFX --group-directories-first --color=auto';
alias la='ls -a';

alias cdd='cd -';
alias ..='cd ..';

alias rm='rm -vrfi --preserve-root';
alias rr='find . -name "*~" | xargs rm -vrf' ;
alias mv='mv -vi';
alias cp='cp -vip';

alias mkdir='mkdir -vp';
alias chmod='chmod -v';
alias grep='grep -n --color=auto';
alias du='du -h';
alias diff='diff --suppress-common-lines';

alias make='clear && make';
alias m='make';

alias x='exit';

# Git.
alias gpull='git pull';
alias gadd='git add';
alias gpush='git push';
alias gstat='git status';
alias gdiff='git diff';

# Typos.
alias sl='ls';
alias l='ls';
alias s='ls';

alias dc='cd';
alias c='cd';
alias d='cd';
alias cd..='cd ..';

alias maek='make';
alias mkir='mkdir';
alias diif='diff';

# Variables.
export VISUAL="emacs -nw"
export PAGER="less"

# Prompt.
export PROMPT_COMMAND=my_prompt;

my_prompt(){
    local EXIT="$?"
    PS1="${debian_chroot:+($debian_chroot)|}\A$MAG|"

    if [ $EXIT = 0 ];
    then
	PS1+="${CYN}\u${BLE}@${CYN}\H${RST}"
    else
	PS1+="${RED}\u${BLE}@${RED}\H${RST}"
    fi

    local DIR=${PWD/$HOME/\~}

    if [[ $COLUMNS/3 -le ${#DIR} ]];
    then
	DIR="..."${DIR:${#DIR}-$COLUMNS/3:${#DIR}}
    fi

    PS1+="$MAG:$YEL$DIR";

    local BRANCH=`git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/"`
    local STATUS=`git status --porcelain 2> /dev/null | wc -l`
    local COMMIT=`git cherry -v origin/"$BRANCH" 2> /dev/null | wc -l`
    local GIT=""
    local COLO=""

    if [[ 0 != $STATUS ]];
    then
	COLO="$RED"
    fi

    if [ -z "$BRANCH" ];
    then
	GIT=""
    elif [[ 0 != $COMMIT ]];
    then
	GIT=" $MAG[$RST$COLO$BRANCH$MAG|$GRN$COMMIT$MAG]$RST"
    else
	GIT=" $MAG[$RST$COLO$BRANCH$MAG]$RST"
    fi

    PS1+="$GIT$RST\$ > ";
}
