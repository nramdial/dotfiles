#!/usr/bin/env bash
# macOS system defaults.
#
# These were previously declared in nix-darwin (system.defaults). That config
# was removed, and most of the values had already reverted, so they are
# recorded here instead. Run deliberately; nothing here runs automatically.
#
# Only settings that were LOST (currently unset) are applied. Anything this
# machine now sets differently from nix-darwin is left commented out, on the
# assumption it was a deliberate later change rather than drift.
#
#   ./macos/defaults.sh              # apply
#   DRY_RUN=1 ./macos/defaults.sh    # show what would change

set -euo pipefail
DRY_RUN="${DRY_RUN:-}"

changed=0 same=0

set_default() {
  local domain="$1" key="$2" type="$3" want="$4"
  local cur
  cur="$(defaults read "$domain" "$key" 2>/dev/null || echo "<unset>")"
  if [[ "$cur" == "$want" ]]; then
    printf '  %-28s %s (unchanged)\n' "$key" "$cur"; same=$((same+1)); return
  fi
  printf '  %-28s %s -> %s\n' "$key" "$cur" "$want"
  changed=$((changed+1))
  [[ -n "$DRY_RUN" ]] || defaults write "$domain" "$key" "-$type" "$want"
}

echo "Keyboard"
# Fast key repeat. KeyRepeat: 120,90,60,30,12,6,2 (lower = faster)
set_default NSGlobalDomain KeyRepeat int 2
# InitialKeyRepeat: 120,94,68,35,25,15 (lower = shorter delay)
set_default NSGlobalDomain InitialKeyRepeat int 15
# Key repeat instead of the accent picker when holding a key
set_default NSGlobalDomain ApplePressAndHoldEnabled bool 0

echo "Finder"
set_default NSGlobalDomain AppleShowAllExtensions bool 1
set_default com.apple.finder _FXShowPosixPathInTitle bool 0

echo "Trackpad"
# Currently 0 on this machine (tap-to-click off). nix-darwin set 1.
# set_default com.apple.AppleMultitouchTrackpad Clicking bool 1
# set_default NSGlobalDomain com.apple.mouse.tapBehavior int 1
# Currently 0. nix-darwin set 1.
# set_default com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag bool 1

echo "Sound"
set_default NSGlobalDomain com.apple.sound.beep.feedback int 0

echo "Dock"
set_default com.apple.dock show-recents bool 0
# Dock is currently on the right and autohiding - both look deliberate, so
# they are not forced back to the nix-darwin values (bottom, no autohide).
# set_default com.apple.dock orientation string bottom
# set_default com.apple.dock autohide bool 0
# nix-darwin set tilesize 48; this machine is currently 69, which looks like a
# later deliberate resize, so it is left alone. Uncomment to pin it.
# set_default com.apple.dock tilesize int 48

echo
echo "$changed to change, $same already correct"
if [[ -n "$DRY_RUN" ]]; then
  echo "(dry run - nothing applied)"
elif [[ $changed -gt 0 ]]; then
  echo "Restarting Dock and Finder..."
  killall Dock 2>/dev/null || true
  killall Finder 2>/dev/null || true
  echo "Some keyboard settings need a logout to take effect."
fi
