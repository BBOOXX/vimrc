#!/bin/sh

case "$OSTYPE" in
    darwin*)  brew install vim wget cmake;;
    linux*)   sudo apt install vim-nox wget cmake build-essential python3-dev;;
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
