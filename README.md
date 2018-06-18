# .bashrc

My `.bashrc` files. Simple & elegant.

## Installation

First, clone the repository.

```
$ git clone https://github.com/brtrndb/bashrc.git
```

## Usage

```
$ ./install.sh -h
Usage:
-n, --new:    New install.
-c, --clean:  Rollback to previous install.
-u, --update: Update files in /home/bertrand/.bashrc.d.
-h, --help:   Display usage.
```

A new fresh install will copy the `.bashrc.d` folder into your home and add the line `. $HOME/.bashrc.d/init.sh` at the end of your current `.bashrc` file.

## Description

### Aliases

* Aliases to correct typos in commands. For example `sl` instead of `ls`.
* Aliases for lazy people, like `c` for `cd`, or `e` instead of `emacs`.
* Some aliases for git.

### Prompt

* Display classical informations like time, user and host.
* Display the current directory shortened if it is too long in the terminal.
* Display the current git branch, changes, commits unpushed, and remote commits.

### Functions.

* Some functions to manage commands history.

### Scripts

The `scripts` folder constains some useful (or not) scripts. They are accessible from the `PATH` variable.

### Shell environment

* Colors.
* History control.

## Notes

## License
