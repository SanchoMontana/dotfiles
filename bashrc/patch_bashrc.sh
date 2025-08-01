#!/usr/bin/env bash

# Define patch
PATCH_DIR="./snippets"

apply_patch() {
  local patch_file="$1"
  local checksum
  checksum=$(sha256sum "$patch_file" | awk '{print $1}')

  # Check if ~/.bashrc already includes the exact snippet
  if grep -Fq "$checksum" ~/.bashrc; then
    echo "Patch already applied (checksum match)"
  else
    echo "# PATCH_SHA256: $checksum" >>~/.bashrc
    cat "$patch_file" >>~/.bashrc
    echo "# END PATCH" >>~/.bashrc
    echo "" >>~/.bashrc
    echo "Patch applied"
  fi
}

for file in ${PATCH_DIR}/*; do
  [ -f "$file" ] || continue
  apply_patch $file
done

source ~/.bashrc
