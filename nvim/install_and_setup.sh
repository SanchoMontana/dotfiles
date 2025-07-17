if ! command -v nvim >/dev/null 2>&1; then
  echo "Neovim not found, cloning..."
  mkdir -p ./tmp
  pushd ./tmp/ >/dev/null
  git clone https://github.com/neovim/neovim.git .
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  sudo ln -sf $(which nvim) /usr/local/bin/vim
else
  echo "Neovim is already installed."
fi

git clone https://github.com/LazyVim/starter ~/.config/nvim
