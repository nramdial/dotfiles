#!/usr/bin/env bash
# Symlink dotfiles into $HOME. Equivalent to `stow -t "$HOME" <pkg>...`,
# but with no dependencies. Safe to re-run.
#
#   ./install.sh              # link every package
#   ./install.sh nvim tmux    # link only these
#   DRY_RUN=1 ./install.sh    # show what would happen, change nothing

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${TARGET:-$HOME}"
BACKUP="$TARGET/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
DRY_RUN="${DRY_RUN:-}"

run() {
  if [[ -n "$DRY_RUN" ]]; then echo "  would: $*"; else "$@"; fi
}

packages=("$@")
if [[ ${#packages[@]} -eq 0 ]]; then
  while IFS= read -r d; do packages+=("$(basename "$d")"); done \
    < <(find "$DOTFILES" -maxdepth 1 -mindepth 1 -type d -not -name '.git')
fi

linked=0 skipped=0 backed_up=0

for pkg in "${packages[@]}"; do
  pkgdir="$DOTFILES/$pkg"
  [[ -d "$pkgdir" ]] || { echo "!! no such package: $pkg" >&2; continue; }
  echo "== $pkg"

  while IFS= read -r src; do
    rel="${src#"$pkgdir"/}"
    dst="$TARGET/$rel"

    # already correct?
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
      skipped=$((skipped+1)); continue
    fi

    # move a real file (or wrong link) out of the way first
    if [[ -e "$dst" || -L "$dst" ]]; then
      echo "  backup: $rel"
      run mkdir -p "$BACKUP/$(dirname "$rel")"
      run mv "$dst" "$BACKUP/$rel"
      backed_up=$((backed_up+1))
    fi

    run mkdir -p "$(dirname "$dst")"
    run ln -s "$src" "$dst"
    echo "  link:   $rel"
    linked=$((linked+1))
  done < <(find "$pkgdir" -type f)
done

echo
echo "linked $linked, already correct $skipped, backed up $backed_up"
[[ $backed_up -gt 0 ]] && echo "replaced files saved in: $BACKUP"
[[ -n "$DRY_RUN" ]] && echo "(dry run - nothing changed)"
exit 0
