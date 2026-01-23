# gwm

`gwm` is a small helper for managing git worktrees by branch name.

Usage:
  gwm new <branch>
  gwm shell <branch>
  gwm path <branch>
  gwm remove <branch>

Commands:
  new <branch>    Create a git worktree for the branch and print its path.
  shell <branch>  Start a login shell inside the worktree directory.
  path <branch>   Print the worktree directory path for the branch.
  remove <branch> Remove the worktree directory for the branch.

Environment:
  GWM_WORKTREE_LOCATION  Base directory for worktrees (default: ~/worktrees).

Examples:
  gwm new feature/login
  gwm shell feature/login
  gwm path feature/login
  gwm remove feature/login

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
