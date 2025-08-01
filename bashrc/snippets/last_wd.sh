echo $(pwd) >$HOME/.config/sxhkd/last_wd
cd() {
  builtin cd "$@"
  echo $(pwd) >$HOME/.config/sxhkd/last_wd
}
pushd() {
  builtin pushd "$@"
  echo $(pwd) >$HOME/.config/sxhkd/last_wd
}
pdopd() {
  builtin popd "$@"
  echo $(pwd) >$HOME/.config/sxhkd/last_wd
}
