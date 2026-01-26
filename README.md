# Git Worktree manager `gwm`

`gwm` is a small helper for managing git worktrees by branch name.

Example:

``` shell
$ gwm new feature1
$ cd (gwm path feature1)
<code>
$ git rebase feature1
```

Or more frequently these days:

``` shell
$ gwm new feature1
$ gwm shell feature1 opencode
```

Usage:

``` shell
  gwm new <branch>
  gwm shell <branch> [command]
  gwm path <branch>
  gwm remove <branch>
  gwm list

Commands:
  new <branch>              Create a git worktree for the branch and print its path.
  shell <branch> [command]  Start a login shell inside the worktree directory. If command is supplied, its executed in the shell
  path <branch>             Print the worktree directory path for the branch.
  remove <branch>           Remove the worktree directory for the branch.
  list                      List gwm-managed worktree directories.

Environment:
  GWM_WORKTREE_LOCATION  Base directory for worktrees (default: ~/worktrees).

```

Installation:
  - Make `gwm` executable and place it on your PATH, for example:
    `chmod +x /path/to/worktree_manager/gwm`
  - Then add the directory to your PATH, for example in `~/.bashrc`:
    `export PATH="/path/to/worktree_manager:$PATH"`

Completions:

- Bash:
  - Source the completion file from your shell profile:
    `source /path/to/worktree_manager/completions/bash/gwm`
  - Or copy it into a system/user completion directory, for example:
    `/etc/bash_completion.d/gwm` or `~/.local/share/bash-completion/completions/gwm`

- Fish:
  - Copy `completions/fish/gwm.fish` into:
    `~/.config/fish/completions/gwm.fish`

Errors are printed to stderr and exit nonzero.
