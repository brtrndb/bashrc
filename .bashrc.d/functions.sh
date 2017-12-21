# Functions.

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1;;
            *.tar.gz)   tar xzf $1;;
            *.bz2)      bunzip2 $1;;
            *.rar)      rar x $1;;
            *.gz)       gunzip $1;;
            *.tar)      tar xf $1;;
            *.tbz2)     tar xjf $1;;
            *.tgz)      tar xzf $1;;
            *.zip)      unzip $1;;
            *.Z)        uncompress $1;;
            *)          echo "'$1' cannot be extracted via extract()";;
        esac
    else
        echo "'$1' is not a valid file";
    fi
}

need_coffee () {
    cat /dev/urandom | hexdump -C | grep --color=auto "ca fe";
}

hs () {
    H=$HOME/.bash_history;
    if [ -f "$H" ]; then
	cut -f1 -d" " $H | sort | uniq -c | sort -nr | head -n 30;
    else
	history | sed -e "s/^[[:space:]]*[0-9]*[[:space:]]*//" | cut -f1 -d" " | sort | uniq -c | sort -nr | head -n 30;
    fi
}

hc () {
    \rm -f $HOME/.bash_history && clear && history -c;
}

gpcp () {
    git pull && git commit -m "$1" && git push;
}
