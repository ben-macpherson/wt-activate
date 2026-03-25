# Bare Repo Worktree Setup

The most effective way to use `wt-activate` is with a **bare repo + linked worktrees** layout. This keeps your working trees clean and your repo metadata out of the way.

## What it looks like

```
~/code/my-project/          ← bare repo (no working files)
~/code/my-project/main/     ← worktree for main branch
~/code/my-project/feature/  ← worktree for a feature branch
~/code/my-project/active    ← symlink managed by wt-activate
```

Your editor always opens `~/code/my-project/active`. When you want to switch which branch your environment is working against, you run `wt-activate` from the target worktree.

## Setting it up

Clone a bare repo:

```sh
git clone --bare https://github.com/you/my-project.git ~/code/my-project
cd ~/code/my-project
```

Add worktrees for the branches you work with:

```sh
git worktree add main main
git worktree add feature-x origin/feature-x
```

Initialize `wt-activate` for this repo (run from the bare repo or any worktree):

```sh
cd ~/code/my-project
wt-activate-init
# Suggested default: ~/code/my-project/active — press enter to accept
```

Activate a worktree:

```sh
cd ~/code/my-project/main
wt-activate
#   now: /Users/you/code/my-project/main
#   via: /Users/you/code/my-project/active
# wt-activate: active worktree updated
```

## Configuring your editor

Point your editor's project root at the `active` symlink path rather than a specific worktree. For example in VS Code, open `~/code/my-project/active` as the workspace root. It will always reflect whichever worktree you last activated.

## Standard repo layout

`wt-activate` also works with standard (non-bare) repos when you've added extra worktrees via `git worktree add`. The symlink default will be placed as a sibling of the repo directory:

```
~/code/
  my-project/        ← standard repo (has .git/)
  my-project-fix/    ← added worktree
  active             ← symlink managed by wt-activate
```
