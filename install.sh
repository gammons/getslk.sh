#!/usr/bin/env bash
#
# slk installer
#
#   curl -fsSL https://getslk.sh/install.sh | sh
#
# Honors the following env vars:
#   INSTALL_DIR   destination directory (default: /usr/local/bin)
#   SLK_VERSION   pin a specific version (default: latest release)
#

set -euo pipefail

REPO="gammons/slk"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"

c_reset=$'\033[0m'
c_dim=$'\033[2m'
c_cyan=$'\033[36m'
c_magenta=$'\033[35m'
c_red=$'\033[31m'

info()  { printf "%s==>%s %s\n"  "$c_cyan"    "$c_reset" "$*"; }
warn()  { printf "%s==>%s %s\n"  "$c_magenta" "$c_reset" "$*" >&2; }
fail()  { printf "%s==>%s %s\n"  "$c_red"     "$c_reset" "$*" >&2; exit 1; }

# ----------------------------------------------------------------------
# Platform detection
# ----------------------------------------------------------------------

case "$(uname -s)" in
  Linux*)  os="linux"  ;;
  Darwin*) os="darwin" ;;
  *)       fail "Unsupported OS: $(uname -s). slk only supports Linux and macOS via this installer. Windows users: see https://getslk.sh/install/" ;;
esac

case "$(uname -m)" in
  x86_64|amd64)  arch="x86_64" ;;
  arm64|aarch64) arch="arm64"  ;;
  *)             fail "Unsupported architecture: $(uname -m). Supported: x86_64, arm64." ;;
esac

# ----------------------------------------------------------------------
# Resolve version
# ----------------------------------------------------------------------

if [ -n "${SLK_VERSION:-}" ]; then
  version="${SLK_VERSION#v}"
else
  info "Resolving latest release..."
  version="$(
    curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
      | grep -oE '"tag_name": *"v[^"]+"' \
      | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' \
      | sed 's/^v//' \
      | head -n1
  )"
fi

[ -n "$version" ] || fail "Could not determine the latest version. Try setting SLK_VERSION manually."

# ----------------------------------------------------------------------
# Download
# ----------------------------------------------------------------------

asset="slk_${version}_${os}_${arch}.tar.gz"
url="https://github.com/${REPO}/releases/download/v${version}/${asset}"

info "Downloading slk v${version} (${os}/${arch})..."

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

if ! curl -fsSL "$url" | tar -xz -C "$tmp"; then
  fail "Download or extraction failed: $url"
fi

if [ ! -x "$tmp/slk" ]; then
  fail "Archive did not contain a 'slk' binary."
fi

# ----------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------

dest="${INSTALL_DIR%/}/slk"

if [ -w "$INSTALL_DIR" ] || { [ ! -e "$INSTALL_DIR" ] && [ -w "$(dirname "$INSTALL_DIR")" ]; }; then
  mkdir -p "$INSTALL_DIR"
  mv "$tmp/slk" "$dest"
elif command -v sudo >/dev/null 2>&1; then
  warn "sudo required to write to ${INSTALL_DIR}"
  sudo mkdir -p "$INSTALL_DIR"
  sudo mv "$tmp/slk" "$dest"
else
  fail "${INSTALL_DIR} is not writable and sudo is not available. Re-run with INSTALL_DIR=\$HOME/.local/bin or similar."
fi

chmod +x "$dest" 2>/dev/null || sudo chmod +x "$dest"

# ----------------------------------------------------------------------
# Done
# ----------------------------------------------------------------------

info "Installed slk to ${dest}"
printf "\n"
printf "  Run %s'slk --add-workspace'%s to connect your first Slack workspace.\n" "$c_cyan" "$c_reset"
printf "  Setup walkthrough: %shttps://getslk.sh/install/%s\n" "$c_dim" "$c_reset"
printf "\n"
