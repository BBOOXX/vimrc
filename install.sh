#!/bin/sh
case "$OSTYPE" in
    darwin*)  brew install vim wget ctags reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste;;
    linux*)   sudo apt-get install vim-nox-py2 git python-pip wget ctags;;
    *)        echo "unknown: OS: $OSTYPE, U should install dependences by yourself" ;;
esac
echo "创建文件夹"
mkdir -p ~/.vim/colors ~/.vim/autoload ~/.vim/bundle
echo "下载主题"
wget -O ~/.vim/colors/monokai.vim https://raw.githubusercontent.com/BBOOXX/vim-monokai/master/colors/monokai.vim
echo "下载插件"
wget -O ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cd ~/.vim/bundle
git clone git://github.com/Raimondi/delimitMate
git clone git://github.com/SirVer/ultisnips
git clone git://github.com/davidhalter/jedi-vim
git clone git://github.com/dhruvasagar/vim-table-mode
git clone git://github.com/easymotion/vim-easymotion
git clone git://github.com/ervandew/supertab
git clone git://github.com/fisadev/vim-isort
git clone git://github.com/honza/vim-snippets
git clone git://github.com/iamcco/markdown-preview.vim
git clone git://github.com/junegunn/vim-easy-align
git clone git://github.com/kana/vim-textobj-indent
git clone git://github.com/kana/vim-textobj-user
git clone git://github.com/kien/ctrlp.vim
git clone git://github.com/kien/rainbow_parentheses.vim
git clone git://github.com/kshenoy/vim-signature
git clone git://github.com/majutsushi/tagbar
git clone git://github.com/mattn/emmet-vim
git clone git://github.com/scrooloose/nerdcommenter
git clone git://github.com/scrooloose/nerdtree
git clone git://github.com/scrooloose/syntastic
git clone git://github.com/tell-k/vim-autopep8
git clone git://github.com/vim-airline/vim-airline
git clone git://github.com/vim-airline/vim-airline-themes
git clone git://github.com/vim-scripts/DrawIt
cd ~
echo "通过pip安装依赖"
sudo pip install jedi autopep8 isort
echo "移动.vimrc文件到用户目录"
mv ~/vimrc/.vimrc ~
echo "删除自身"
rm -rf ~/vimrc/
echo "Done."
