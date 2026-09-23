# dotfiles

macOS development environment. Layout is [GNU Stow][stow]-compatible:
each top-level directory is a package, and its contents mirror `$HOME`.

```
zsh/.zshrc              ->  ~/.zshrc
nvim/.config/nvim/      ->  ~/.config/nvim/
```

## Install

```sh
git clone https://github.com/nramdial/dotfiles.git ~/dotfiles
cd ~/dotfiles
DRY_RUN=1 ./install.sh     # preview
./install.sh               # link everything
./install.sh nvim tmux     # or just some packages
```

`install.sh` needs no dependencies and is safe to re-run. Anything real it
replaces is moved to `~/.dotfiles-backup-<timestamp>/` first.

With stow installed, `stow -t ~ nvim tmux zsh` does the same thing.

## Packages

| package     | what it covers                          |
|-------------|-----------------------------------------|
| `zsh`       | `.zshrc`, `.zshenv`, `.p10k.zsh`        |
| `bash`      | `.bashrc`, `.bash_profile`              |
| `git`       | `.gitconfig`, global gitignore          |
| `nvim`      | Neovim (lazy.nvim, 34 plugins)          |
| `tmux`      | `tmux.conf` (plugins via tpm)           |
| `alacritty` | terminal config                         |
| `htop`      | htop config                             |
| `sops`      | SOPS age recipient (public key)         |
| `zed`       | Zed editor settings                     |
| `gh`        | GitHub CLI config (no credentials)      |
| `neofetch`  | neofetch config                         |
| `wm`        | yabai + skhd                            |

## Packages (Homebrew)

```sh
brew bundle --file=~/dotfiles/Brewfile
```

Regenerate with `brew bundle dump --force --file=~/dotfiles/Brewfile`.

## Not in this repo

This repo is **public**, so some things are deliberately excluded and must be
restored by hand on a new machine:

- `~/.ssh/config` and all SSH keys
- `~/.config/gh/hosts.yml` (GitHub token; lives in the macOS keychain)
- `~/.databrickscfg`, kubeconfigs, talosconfig
- `~/.config/bws/` (Bitwarden Secrets Manager state)

See `.gitignore` for the full deny list.

[stow]: https://www.gnu.org/software/stow/
