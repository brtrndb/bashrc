# Aliases.
alias ls='ls -lhF --color=auto';
alias lld='ls -lhFX --group-directories-first --color=auto';
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

alias make='clear && make';
alias m='make';

alias emacs='emacs -nw';
alias e='emacs';

alias h='htop'

alias less='most';

alias du="du -h";
alias df="df -h";

alias x='exit';
alias q='exit';

alias aa="source ~/.bashrc";

# Apt.
alias apt-up="sudo apt-get update && apt-get upgrade";

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
alias exiit='exit';

# Git aliases.
alias g="git";
alias gpull='git pull';
alias gadd='git add';
alias gpush='git push';
alias gstat='git status -sb';
alias gdiff='git diff --ignore-space-at-eol';
alias glog='git log --graph --abbrev-commit';

alias clone="git clone";
alias add="git add";
alias commit="git commit -m";
alias push="git push";
alias pull="git pull";

alias gl='git log --graph --abbrev-commit --oneline';
