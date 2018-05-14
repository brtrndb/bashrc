# Shell options.
shopt -s cdspell;
shopt -s checkwinsize;

# History
shopt -s histappend;
shopt -s histreedit;

HISTSIZE=5000;
HISTFILESIZE=10000
HISTIGNORE="&:ls:la:ll:l:s:sl:cd:c:d:fg:clear:exit:exiit:m:q:x:gl:gs";
HISTCONTROL="ignoreboth";
HISTTIMEFORMAT="%F %T "

# Variables.
export VISUAL="emacs -nw"
export PAGER="most"
if [ -d "$HOME/.bashrc.d/scripts" ]; then
    export PATH="$PATH:$HOME/.bashrc.d/scripts";
fi

# Colors.
RESET="\[\033[0m\]"		# Reset color
BLACK="\[\033[30m\]"		# Black
RED='\[\033[31m\]'		# Red
GREEN="\[\033[32m\]"		# Green
YELLOW="\[\033[33m\]"		# Yellow
BLUE="\[\033[34m\]"		# Blue
MAGENTA="\[\033[35m\]"		# Magenta
CYAN="\[\033[36m\]"		# Cyan
WHITE="\[\033[37m\]"		# White

# Font.
BOLD="\[\033[1m\]"		# Bold.
DEFAULT="\[\033[0m\]"		# Normal.
