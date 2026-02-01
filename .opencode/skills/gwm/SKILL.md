---
name: gwm
description: Use the gwm CLI to create, locate, list, clean, remove, and rebase git worktrees.
compatibility: opencode
license: BSD-3-Clause
---

## What I do
- Manage per-branch git worktrees using the `gwm` CLI (assumed to be in `PATH`).
- Prefer `gwm` for worktree paths and lifecycle; use `git -C <path>` for repo actions inside a worktree.

## When to use me
Use this skill when you need to:
- Create an isolated worktree for a branch (feature work, reviews, parallel tasks).
- Find the filesystem path of a branch worktree.
- List, clean up, or remove gwm-managed worktrees.
- Rebase all gwm-managed worktrees onto a base branch.

## Preconditions
- `gwm` must be installed and available in `PATH`.
- Run inside a git repository (otherwise `gwm` errors with `not a git repository`).

## Base directory and paths
- Worktrees live under `GWM_WORKTREE_LOCATION` (default: `~/worktrees`).
- Layout: `<base>/<repo-name>/<branch>`.
- `gwm new <branch>` prints the created path; capture and reuse it.

## Command reference

### Create a worktree
```bash
worktree_path=$(gwm new my-branch)
```

If the branch exists locally, `gwm` checks it out; otherwise it creates it.

### Get paths
```bash
gwm repo           # main repo root
gwm path my-branch # expected path for the branch worktree
```

### Run commands in a worktree
Prefer non-interactive commands like:
```bash
git -C "$(gwm path my-branch)" status
```

If you need a login shell environment (or to run a single command in that environment):
```bash
gwm shell my-branch
gwm shell my-branch "npm test"
```

### List worktrees
```bash
gwm list
```

Shows gwm-managed directories under `<base>/<repo-name>` with:
- `Changes`: number of `git status --porcelain` entries
- `Ahead/Behind`: `ahead/behind` vs the base branch (`main` if present, else `master`)

### Clean up
```bash
gwm clean
```

Removes only *clean* worktrees (no uncommitted/unstaged changes).

### Remove a worktree
```bash
gwm remove my-branch
gwm remove --force my-branch
```

Use `--force` only if you accept losing local/uncommitted work in that worktree.

### Rebase all worktrees
```bash
gwm rebase_all          # onto main/master auto-detected
gwm rebase_all develop  # onto a specific base
```

Notes:
- Skips the base branch worktree itself.
- Failures leave the worktree "in rebase" for manual resolution.

## Agent usage guidelines
- Prefer `gwm new <branch>` at the start of any multi-step change to isolate work.
- Use `gwm path <branch>` to avoid guessing paths.
- Before removing/forcing, check for changes (e.g. `git -C "$(gwm path <branch>)" status --porcelain`).
