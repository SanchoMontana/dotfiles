#!/bin/bash

SCRIPT_DIR="$(dirname $0)"

if command -v alacritty >/dev/null 2>&1; then
    echo "Alacritty is already installed."
else
    echo "Cloning Alacritty..."
    mkdir -p $HOME/cloned/tools/alacritty
    git clone https://github.com/alacritty/alacritty.git $HOME/cloned/tools/alacritty
fi

pushd $HOME/cloned/tools/alacritty > /dev/null
rustup override set stable
rustup update stable
cargo build --release
# Add a Desktop Entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
# Add bash completions
LINE="source $(pwd)/extra/completions/alacritty.bash"
FILE="$HOME/.bashrc"
if ! grep -Fxq "$LINE" "$FILE"; then
    echo "$LINE" >> "$FILE"
    echo "Added to .bashrc: $LINE"
else
    echo "Line already exists in .bashrc"
fi
popd > /dev/null

# Install themes
mkdir -p ~/.config/alacritty/
pushd ~/.config/alacritty/ > /dev/null
# Check if the current directory is empty
if [ -z "$(ls -A .)" ]; then
    echo "Directory is empty. Cloning..."
    git clone https://github.com/alacritty/alacritty-theme .
else
    echo "~/.config/alacritty/ directory is not empty, skipping clone..."
fi
rm -rf images README.md LICENSE print_colors.sh
popd > /dev/null

# Add a toml config
cp $SCRIPT_DIR/alacritty.toml ~/.config/alacritty/

# Add Source Code Pro font
FONT_NAME="SauceCodePro"
if fc-list | grep -q "$FONT_NAME"; then
    echo "$FONT_NAME is already installed."
else
    echo "$FONT_NAME not found. Downloading and installing..."

    mkdir -p ./tmp/
    wget -P ./tmp/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip ./tmp/
    unzip ./tmp/SourceCodePro.zip -d ./tmp/SourceCodeProNF
    mkdir -p ~/.local/share/fonts
    cp ./tmp/SourceCodeProNF/*.ttf ~/.local/share/fonts/
    fc-cache -fv
    rm -rf ./tmp
fi
