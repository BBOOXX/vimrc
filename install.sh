#!/usr/bin/env bash
cd $(dirname $0)
export BASE=$(pwd)
export VIMRC_INIT=true

case "$PREFIX" in
    *com.termux*) termux=true ;;
    *) termux=false ;;
esac

case "$OSTYPE" in
    darwin*)  brew install vim wget cmake;;
    linux*)   if [ "$termux" != true ]; then
                sudo apt install -y git vim-nox wget jq cmake build-essential python3-dev libjansson-dev automake pkg-config
                git clone https://github.com/universal-ctags/ctags.git --depth=1
                cd ctags && ./autogen.sh && ./configure && make && sudo make install && cd -
              fi ;;
    *)        echo "unknown: OS: $OSTYPE, U should install dependences by yourself" ;;
esac

if [ ! -d $HOME/.vim/pack/packager/opt/vim-packager ]; then
    git clone https://github.com/kristijanhusak/vim-packager ~/.vim/pack/packager/opt/vim-packager
fi

if [ ! -d $HOME/.config/yapf ]; then
    mkdir -p ~/.config/yapf
fi

if [ ! -f $HOME/.config/yapf/style ]; then
    echo "[style]\ncolumn_limit = 120">>~/.config/yapf/style
fi

cp $BASE/.vimrc $HOME
#pip install yapf isort pyflakes
vim +PackagerInstall
unset VIMRC_INIT
