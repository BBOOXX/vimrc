#!/bin/sh
case "$OSTYPE" in
    darwin*)  brew install vim wget ctags cmake reattach-to-user-namespace;;
    linux*)   sudo apt-get install vim-nox-py2 git python-pip wget ctags cmake;;
    *)        echo "unknown: OS: $OSTYPE, U should install dependences by yourself" ;;
esac
echo "创建文件夹"
mkdir -p ~/.vim/colors ~/.vim/autoload ~/.vim/bundle
echo "下载主题"
wget -O ~/.vim/colors/monokai.vim https://raw.githubusercontent.com/BBOOXX/vim-monokai/master/colors/monokai.vim
echo "下载插件"
wget -O ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cd ~/.vim/bundle
git clone https://github.com/Raimondi/delimitMate
git clone https://github.com/SirVer/ultisnips
git clone https://github.com/Valloric/YouCompleteMe
git clone https://github.com/Vimjas/vim-python-pep8-indent
git clone https://github.com/cespare/vim-toml
git clone https://github.com/davidhalter/jedi-vim
git clone https://github.com/easymotion/vim-easymotion
git clone https://github.com/fisadev/vim-isort
git clone https://github.com/honza/vim-snippets
git clone https://github.com/junegunn/vim-easy-align
git clone https://github.com/kana/vim-textobj-indent
git clone https://github.com/kana/vim-textobj-user
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/kien/rainbow_parentheses.vim
git clone https://github.com/kshenoy/vim-signature
git clone https://github.com/majutsushi/tagbar
git clone https://github.com/mattn/emmet-vim
git clone https://github.com/scrooloose/nerdcommenter
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/scrooloose/syntastic
git clone https://github.com/tell-k/vim-autopep8
git clone https://github.com/tmhedberg/SimpylFold
git clone https://github.com/vim-airline/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes
#git clone git://github.com/mattn/vim-xxdcursor
#git clone git://github.com/dhruvasagar/vim-table-mode
#git clone git://github.com/ervandew/supertab
#git clone git://github.com/iamcco/markdown-preview.vim
#git clone git://github.com/vim-scripts/DrawIt
cd ./YouCompleteMe
git submodule update --init --recursive
python ~/.vim/bundle/YouCompleteMe/install.py --racer-completer
cd ~
echo "通过pip安装依赖"
sudo pip install jedi autopep8 isort
echo "移动.vimrc文件到用户目录"
mv ~/vimrc/.vimrc ~
echo "删除自身"
rm -rf ~/vimrc/
echo "Done."
