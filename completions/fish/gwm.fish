# SPDX-License-Identifier: BSD-3-Clause

function __gwm_repo_root
  command git rev-parse --show-toplevel 2>/dev/null
end

function __gwm_branches
  set -l repo_root (__gwm_repo_root)
  test -n "$repo_root"; or return
  command git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null
end

function __gwm_worktrees
  set -l repo_root (__gwm_repo_root)
  test -n "$repo_root"; or return
  set -l path
  command git worktree list --porcelain 2>/dev/null | while read -l key value
    switch $key
      case worktree
        set path $value
      case branch
        set -l branch (string replace -r '^refs/heads/' '' -- $value)
        if test -n "$branch"
          printf '%s\t%s\n' "$branch" "$path"
        end
    end
  end
end

function __gwm_branches_with_paths
  set -l seen
  for entry in (__gwm_worktrees)
    set -l branch (string split -m1 "\t" -- $entry)[1]
    if test -n "$branch"
      set -a seen $branch
    end
    printf '%s\n' "$entry"
  end
  for branch in (__gwm_branches)
    if not contains -- $branch $seen
      printf '%s\n' "$branch"
    end
  end
end

complete -c gwm -f

complete -c gwm -n '__fish_use_subcommand' -a new -d 'Create a worktree for a branch'
complete -c gwm -n '__fish_use_subcommand' -a shell -d 'Start a shell in the worktree'
complete -c gwm -n '__fish_use_subcommand' -a path -d 'Print the worktree path'
complete -c gwm -n '__fish_use_subcommand' -a repo -d 'Print the main repo path'
complete -c gwm -n '__fish_use_subcommand' -a remove -d 'Remove a worktree'
complete -c gwm -n '__fish_use_subcommand' -a list -d 'List worktrees'
complete -c gwm -n '__fish_use_subcommand' -a clean -d 'Remove clean worktrees'
complete -c gwm -n '__fish_use_subcommand' -a rebase_all -d 'Rebase all worktrees'
complete -c gwm -n '__fish_use_subcommand' -a help -d 'Show help'

complete -c gwm -s h -l help -d 'Show help'

complete -c gwm -n '__fish_seen_subcommand_from remove' -s f -l force -d 'Remove even with local changes'

complete -c gwm -n '__fish_seen_subcommand_from new' -a '(__gwm_branches)' -d 'Branch'
complete -c gwm -n '__fish_seen_subcommand_from path' -a '(__gwm_branches_with_paths)'
complete -c gwm -n '__fish_seen_subcommand_from shell remove' -a '(__gwm_worktrees)'
