#!/bin/sh
# Bertrand B.

IS_GIT=`git status 2> /dev/null`;
IS_GIT_CODE="$?";

if [ $IS_GIT_CODE = 0 ];
then
    git stash;
    ALL_BRANCHES=`git for-each-ref --format='%(refname:strip=2)' refs/heads/`;
    CURRENT_BRANCH=$(git symbolic-ref HEAD | sed -e 's/refs.heads.//');

    for branch in $ALL_BRANCHES;
    do
      git checkout && git rebase master $branch;
    done

    git checkout $CURRENT_BRANCH;
    git stash pop;
else
    echo "This folder is not a git repository."
fi
