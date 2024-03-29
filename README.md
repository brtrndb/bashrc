# .bashrc

My `.bashrc` files. Simple & elegant.

## Installation

First, clone the repository.

```shell
$ git clone https://github.com/brtrndb/bashrc.git
```

## Usage

```shell
$ ./install.sh -h
Usage: ./install.sh  { -n | -c | -u | -h }
  -s, --symlink: Install as symbolic link.
  -c, --copy:    Install as copy.
  -u, --update:  Update files in /home/$USER/.bashrc.d.
  -r, --restore: Rollback to previous .bashrc.
  -h, --help:    Display usage.
```

A new fresh install will create a symlink or a copy of `.bashrc.d/` into your home folder and append the
line `. $HOME/.bashrc.d/init.sh` at the end of your current `.bashrc`. It will also create a backup just in case.

## Description

### Aliases

- Aliases to correct typos in most common commands. For example `sl` instead of `ls`.
- Aliases for lazy people, like `c` for `cd`, or `e` instead of `emacs`.
- Some aliases for git.

### Prompt

- Display classical information like time, user and host.
- Display the current directory shortened if it is too long in the terminal.
- Display the current git branch, changes, commits unpushed, and remote commits.

### Scripts

The `scripts/` folder contains some useful (or not) scripts. They are accessible from the `PATH` env variable.

- `coffee.sh`: Because you need coffee.
- `extract.sh`: Extract archived file with correct command depending on file extension.
- `history-clean.sh`: Empty your command line history and delete your `.bash_history`.
- `history-stats.sh`: Show you most used command from `.bash_history`.

### Shell environment

- Set `PAGER` and `VISUAL`.
- Set up how commands history is managed (ignored commands, size, format).

## Notes

## License

See [LICENSE.md](./LICENSE.md).
