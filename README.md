# wt-activate

A small shell utility for switching between git worktrees by updating a stable symlink.

Instead of pointing your editor or build scripts at a specific worktree path, you point them at a single `active` symlink. When you want to work in a different branch, run `wt-activate` from that worktree — the symlink updates, and your environment follows.

The switch is **intentionally manual**. Your terminal can be in one worktree while the environment stays pointed at another, which is useful when reviewing code without disrupting a running dev session.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/benmacpherson/wt-activate/main/install.sh | bash
```

This installs `wt-activate` and `wt-activate-init` to `/usr/local/bin`. To install elsewhere:

```sh
curl -fsSL https://raw.githubusercontent.com/benmacpherson/wt-activate/main/install.sh | bash -s -- ~/.local/bin
```

**Manual install:** copy `bin/wt-activate` and `bin/wt-activate-init` anywhere on your `$PATH` and make them executable.

## Setup (per repo)

Run once from inside the repo (or any of its worktrees):

```sh
wt-activate-init
```

This creates a config file at `$(git rev-parse --git-common-dir)/wt-activate` and asks where the `active` symlink should live. A sensible default is suggested based on your repo layout.

## Usage

```sh
cd ~/code/my-project/feature-branch
wt-activate
#   now: /Users/you/code/my-project/feature-branch
#   via: /Users/you/code/my-project/active
# wt-activate: active worktree updated
```

That's it. The symlink at `~/code/my-project/active` now points to `feature-branch`.

## Config file

The config lives at `$(git rev-parse --git-common-dir)/wt-activate` — inside the shared git directory, so it's automatically available in all worktrees of the same repo.

```
# wt-activate config
ACTIVE_LINK=/Users/you/code/my-project/active
```

`ACTIVE_LINK` is the path of the symlink to create or update. Supports `~` expansion.

## Using the symlink in editors and scripts

Configure your editor to open the `active` path as the project root rather than a specific worktree path. For example, open `~/code/my-project/active` as your VS Code workspace.

Build scripts, Docker mounts, or any other tooling that references your project source can do the same — reference the `active` symlink and it will always point to whichever worktree you last activated.

## Repo layout compatibility

Works with both:

- **Bare repos + linked worktrees** (recommended for heavy worktree use — see [docs/bare-repo-setup.md](docs/bare-repo-setup.md))
- **Standard repos** with additional worktrees added via `git worktree add`

## Requirements

- bash 3.2+ (ships with macOS)
- git 2.5+ (worktree support)
- No other dependencies
