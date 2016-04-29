#!/bin/sh
case "$OSTYPE" in
    # darwin*)  brew install vim-nox git pip wget;;
    linux*)   sudo apt-get install vim-nox git python-pip wget;;
    *)        echo "unknown: OS: $OSTYPE, U should install dependences by yourself" ;;
esac
echo "创建文件夹"
mkdir -p ~/.vim/colors ~/.vim/autoload ~/.vim/bundle
echo "下载主题"
wget -O ~/.vim/colors/monokai.vim https://raw.githubusercontent.com/BBOOXX/vim-monokai/master/colors/monokai.vim
echo "下载插件"
wget -O ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cd ~/.vim/bundle
git clone git://github.com/Lokaltog/vim-powerline
git clone git://github.com/kien/ctrlp.vim
git clone git://github.com/davidhalter/jedi-vim
git clone git://github.com/ervandew/supertab
git clone git://github.com/mattn/emmet-vim
git clone git://github.com/kien/rainbow_parentheses.vim
git clone git://github.com/Raimondi/delimitMate
git clone git://github.com/scrooloose/nerdcommenter
git clone git://github.com/scrooloose/syntastic
git clone git://github.com/tell-k/vim-autopep8
git clone git://github.com/SirVer/ultisnips
git clone git://github.com/honza/vim-snippets
git clone git://github.com/iamcco/markdown-preview.vim
git clone git://github.com/vim-scripts/DrawIt
cd ~
echo "通过pip安装依赖"
sudo pip install jedi ipython ipdb pep8 pylint autopep8
echo "移动.vimrc文件到用户目录"
mv ~/vimrc/.vimrc ~
echo "删除自身"
rm -rf ~/vimrc/
echo "Done."
