#!/bin/bash

# =============== UPDATE ===============
sudo apt-get update
sudo apt-get upgrade -y
sudo xargs apt-get install -y < ./dependencies.txt

# =============== INSTALL RUST ===============
# Add Cargo bin path if it's not already in PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Check if rustc is available in PATH
if command -v rustc >/dev/null 2>&1; then
    echo "Rust is already installed: $(rustc --version)"
else
    echo "Rust not found, installing..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Source the environment to make rustc/cargo available in this shell
    source "$HOME/.cargo/env"
    export PATH="$HOME/.cargo/bin:$PATH"
    echo "Rust installed: $(rustc --version)"
fi


# =============== INSTALL ALACRITTY ===============
alacritty/install_and_setup.sh


# =============== INSTALL WM ===============
wm_utils/configure_wm.sh


# =============== INSTALL WM ===============
git/config.sh


# =============== INSTALL WM ===============
nvim/install_and_setup.sh
