# Aliases.

alias ls='ls -lhF --group-directories-first --color=auto';
alias lld='ls -X';
alias la='ls -a';
alias ll='ls';

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

alias m='make';

alias emacs='emacs -nw';
alias e='emacs';

alias htop='echo -e "\033]0;htop\007" && htop'
alias h='htop'

alias less='most';

alias du="du -h";
alias df="df -h";

alias x='exit';
alias q='exit';

alias aa="source ~/.bashrc";

alias env="env | sort"

# Apt.
alias apt-get="apt";
alias apt-up="sudo apt update && sudo apt upgrade";

# Typos.
alias sl='ls';
alias l='ls';
alias s='ls';

alias dc='cd';
alias c='cd';
alias d='cd';
alias cd..='cd ..';

alias maek='make';
alias male='make';
alias mkir='mkdir';
alias diif='diff';
alias exiit='exit';

# Git aliases.
alias g="git";
alias gd='git diff --ignore-space-at-eol';
alias gl='git log --graph --abbrev-commit --oneline';
alias gs='git status -sb';
