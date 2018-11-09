# IPE

> Insanely Productive Environment

`ipe` is a simple bashscript wrapping a few productive tools to automate
daily workflows. It features:

- `cd` instantely in the right folder (thanks to [z][z])
- Drop you in a productive terminal with [tmux][tmux] and [tmuxp][tmuxp]
- Auto-(un)load commands, aliases, environment variables, per-project to
  cross-machines (thanks to [autoenv][autoenv])
- Dead-simple extension system

!! **WIP, more to come soon**
!! Only tested on Mac


### Getting started

```Bash
git clone https://github.com/xav-b/ipe && ./ipe/bootstrap.sh
# does it work ?
ipe version
```

```Bash
# use `z`, so fuzzy match `<proj>`
ipe hack <proj>
```



[z]: https://github.com/rupa/z
[tmux]: tmux
[autoenv]: autoenv
[tmuxp]: https://github.com/tony/tmuxp
