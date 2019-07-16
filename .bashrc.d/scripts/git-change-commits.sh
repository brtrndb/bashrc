#!/bin/sh
# Bertrand B.

usage() {
  echo "Usage: ./$(basename "$0") <new_name> <old_email> <new_email>"
  echo "-h, --help:   Display usage."
}

configure() {
  if [ "$#" -ne "3" ];
  then
    echo "Illegal number of parameters.";
    usage;
    exit 0;
  fi

  while [ "$#" -gt "0" ]; do
    case "$1" in
      -h | --help)
        usage;
        exit 0;
        ;;
      -* | --*)
        echo "Unknown option: $1. Ignored."
        shift 1;
        ;;
      *)
        shift 1;
        ;;
    esac
  done
}

change_commits() {
  echo -n "Replace email '$2' with '$3' for '$1' ? (Y/N) ";
  read OK;

  if [ "$OK" = "Y" ] ;
  then
    git filter-branch -f --env-filter '
	    OLD_EMAIL="'"$2"'"
	    CORRECT_NAME="'"$1"'"
	    CORRECT_EMAIL="'"$3"'"
	    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
	    then
		export GIT_COMMITTER_NAME="$CORRECT_NAME"
		export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
	    fi
	    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
	    then
		export GIT_AUTHOR_NAME="$CORRECT_NAME"
		export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
	    fi
    ' --tag-name-filter cat -- --branches --tags;
  else
    echo "Canceled.";
  fi;
}

run() {
  configure "$@";
  change_commits "$@";
}

run "$@";
