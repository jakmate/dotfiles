#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${HOME}"
PACKAGES="${DOTFILES}/packages.txt"

CONFIG_DIRS=(
  btop
  dunst
  fastfetch
  hypr
  kitty
  waybar
  wofi
)

log() {
  printf '==> %s\n' "$*"
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

install_packages() {
  if [[ "${SKIP_PACKAGES:-0}" == "1" ]]; then
    log "Skipping package install"
    return
  fi

  if [[ ! -f "$PACKAGES" ]]; then
    log "No packages.txt present"
    return
  fi

  if ! command -v yay >/dev/null 2>&1; then
    log "yay missing; install packages manually"
    return
  fi

  log "Installing packages with yay"
  mapfile -t pkgs < <(grep -Ev '^\s*(#|$)' "$PACKAGES")
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    yay -S --noconfirm --needed "${pkgs[@]}"
  else
    log "packages.txt empty"
  fi
}

link_tree() {
  local src="$1"
  local dest="$2"

  mkdir -p "$dest"

  while IFS= read -r -d '' path; do
    local rel="${path#$src/}"
    mkdir -p "${dest}/$(dirname "$rel")"
    ln -sfn "$(realpath --relative-to="$(dirname "${dest}/${rel}")" "$path")" "${dest}/${rel}"
  done < <(find "$src" -type f -print0)
}

link_config() {
  local app="$1"
  local src="${DOTFILES}/${app}"
  local dest="${HOME}/.config/${app}"

  log "Linking ${app} -> ${dest}"
  rm -rf "$dest"
  link_tree "$src" "$dest"
}

link_scripts() {
  local src="${DOTFILES}/scripts"
  local dest="${HOME}/.local/bin"

  mkdir -p "$dest"
  log "Linking scripts -> ${dest}"

  for script in "$src"/*; do
    [[ -f "$script" ]] || continue
    ln -sfn "$(realpath --relative-to="$dest" "$script")" "${dest}/$(basename "$script")"
  done
}

make_executable() {
  log "Making scripts executable"
  find "${DOTFILES}/scripts" -type f -exec chmod +x {} +
  find "${DOTFILES}/hypr/scripts" -type f -exec chmod +x {} + 2>/dev/null || true
  find "${DOTFILES}/waybar/scripts" -type f -exec chmod +x {} + 2>/dev/null || true
}

main() {
  install_packages
  require_cmd realpath
  log "Linking dotfiles"

  for dir in "${CONFIG_DIRS[@]}"; do
    link_config "$dir"
  done

  link_scripts
  make_executable
  log "Done"
}

main "$@"
