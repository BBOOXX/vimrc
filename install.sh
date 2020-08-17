#!/bin/sh

case "$OSTYPE" in
    darwin*)  brew install vim wget cmake;;
    linux*)   sudo apt install -y vim-nox wget jq cmake build-essential python3-dev libjansson-dev automake pkg-config
              git clone https://github.com/universal-ctags/ctags.git --depth=1
              cd ctags && ./autogen.sh && ./configure && make && sudo make install && cd ..
        ;;
    *)        echo "unknown: OS: $OSTYPE, U should install dependences by yourself" ;;
esac

git clone https://github.com/kristijanhusak/vim-packager ~/.vim/pack/packager/opt/vim-packager

mkdir -p ~/.config/yapf
cat>~/.config/yapf/style<<EOF
[style]
column_limit = 120
EOF

cp .vimrc ~
#pip install yapf isort pyflakes
