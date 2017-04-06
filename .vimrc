" Automatic reloading of .vimrc
"https://github.com/majutsushi/tagbar.git 自动加载.vimrc文件
autocmd! bufwritepost .vimrc source %

" Rebind <Leader> key
let mapleader = ","

" Better copy & paste
" 更友好的粘贴
set pastetoggle=<F2>

" 修复 macOS Sierra 中 vim 剪板题
" 需要 brew install reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste
set clipboard=unnamed

" Map jj to <Esc>
" jj 替换 Esc
inoremap jj <Esc>

" Go to home and end using capitalized directions
" H 和 L 跳转行首行尾
noremap H ^
noremap L $

" Map ; to : and save a million keystrokes
" 分号映射为冒号
nnoremap ; :

" Bind nohl
" Removes highlight of your last search
" 取消搜索高亮
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Quick save command
" 快速保存
noremap <C-z> :update<CR>
vnoremap <C-z> <C-C>:update<CR>
inoremap <C-z> <C-O>:update<CR>

" Quick quit command
" 快速退出
noremap <Leader>q :quit!<CR>
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" 切换窗口
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between tabs
" 切换标签
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" easier moving of code blocks
" v模式中 使用'>'和'<'进行缩进
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" map sort function to a key
" v模式中 排序
vnoremap <Leader>s :sort<CR>

" easier formatting of paragraphs
" 排版文本
" vmap Q gq
" nmap Q gqap

" 开关行号函数
""绝对行号
function! HideNumber()
  set number!
  set number?
endfunc
""相对行号
function! HideRelativeNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc

" 设置<F3>开启/关闭行号，方便复制
"nnoremap <F3> :call HideRelativeNumber()<CR>
nnoremap <F3> :call HideNumber()<CR>

" Python 文件中的快捷键
" <Leader>b 快速设置 ipdb 调试断点
"autocmd FileType python map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
autocmd FileType python map <Leader>b Oimport pudb; pu.db  # BREAKPOINT<C-c>
" <F4> 输入参数后运行文件
autocmd FileType python map <F4> :!python %<space>
" <F5> 运行文件
autocmd FileType python map <F5> :!python %<cr>


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Color scheme
" 设置主题
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
" wget -O ~/.vim/colors/monokai.vim https://raw.githubusercontent.com/BBOOXX/vim-monokai/master/colors/monokai.vim
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
set t_Co=256
color monokai

" 显示输入命令
set showcmd

" set encoding=utf-8

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" 显示无用的空格
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Enable syntax highlighting
" 开启语法高亮
filetype off
filetype plugin indent on
syntax on

" Mouse and backspace
" on OSX press ALT and click
set mouse=a
" make backspace behave like normal again
set bs=2

" Showing line numbers and length
" 显示行号和卡尺
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" 高亮显示当前行和列
set cursorline
set cursorcolumn

" 光标的上方或下方至少会保留显示的行数
set scrolloff=7

" Useful settings
set history=700
set undolevels=700

" 使用4个空格而不是Tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
" 搜索不区分大小写
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files
" 禁用备份和交换文件
set nobackup
set nowritebackup
set noswapfile

" 禁用自动折叠
set nofoldenable


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Setup Pathogen to manage your plugins
" 使用 Pathogen 管理插件
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
call pathogen#infect()


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" delimitMate
" 自动补完符号
" git clone https://github.com/Raimondi/delimitMate.git
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-airline
" 状态栏增强
" cd ~/.vim/bundle
" git clone git://github.com/vim-airline/vim-airline
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
set laststatus=2
let g:airline_theme='powerlineish'
let g:airline_left_sep = ''
let g:airline_right_sep = ''


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Rupertab
" Tab增强
" git clone https://github.com/ervandew/supertab
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" nerdcommenter
" 快速注释
" git clone https://github.com/scrooloose/nerdcommenter
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" <Leader>cc      最基本注释
" <Leader>cu      撤销注释
" <Leader>cm      多行注释
" <Leader>cs      性感的注释方式


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-table-mode
" 快速画Markdown表格
" git clone git://github.com/dhruvasagar/vim-table-mode
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" <Leader>tm      开启
" 输入|| 创建顶端或底端


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" DrawIt
" 快速画ASCII图
" git clone git://github.com/vim-scripts/DrawIt
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" <Leader>di       开始
" <Leader>ds       结束
" h j k l          移动
" 上下左右         画线
" ^ v > <          小箭头
" <Leader> 加 ^v>< 大箭头
" <space>          切换橡皮/画笔

" 斜线和键盘方向一致
" Home    Up   Pgup
"     \   |   /
"      \  |  /
"       \ | /
"        \|/
" Left----------Right
"        /|\
"       / | \
"      /  |  \
"     /   |   \
"  End   Down  Pgdn

" V-Block 模式(C-V):
" <Leader>a       画对角线
" <Leader>l       不带箭头
" <Leader>b       矩形
" <Leader>e       椭圆
" <Leader>f       填充
" <Leader>s       整行填充空格
" <Leader>c       画布填充空格
" <C-LeftMouse>   移动

" 设置笔刷:
" V-Block 模式(C-V)选中文本后
" `"[a-z]y` 或 `:'<,'>SetBrush [a-z]`
" 设置选定文本为笔刷,[a-z]为寄存器
" 使用笔刷:
" <shift-leftmouse> 拖动鼠标
" `:SetBrush [a-z]` 设置当前笔刷
" <Leader>r[a-z]    使用笔刷(笔刷空白不透明)
" <Leader>p[a-z]    使用笔刷(笔刷空白透明)

" 命令模式:
" `:DInrml`         标准模式
" `:DIsngl`         单线模式
" `:DIdbl`          双线模式

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Emmet-vim
" git clone https://github.com/mattn/emmet-vim
" http://www.zfanw.com/blog/zencoding-vim-tutorial-chinese.html
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:user_emmet_expandabbr_key = '<leader><leader><Tab>'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" let g:user_emmet_leader_key='<C-Y>'
let g:user_emmet_mode='i'    "only enable insert mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
" let g:user_emmet_mode='a'    "enable all function in all mode.


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" markdown-preview.vim
" 可以通过浏览器实时预览 markdown 文件
" git clone https://github.com/iamcco/markdown-preview.vim.git
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:mkdp_path_to_chrome = "google-chrome"
" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）

let g:mkdp_auto_start = 0
" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，
" 只在打开 markdown 文件的时候打开一次

let g:mkdp_auto_open = 0
" 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，
" 否则自动打开预览窗口

let g:mkdp_auto_close = 1
" 在切换 buffer 的时候自动关闭预览窗口，
" 设置为 0 则在切换 buffer 的时候不自动关闭预览窗口

let g:mkdp_refresh_slow = 0
" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，
" 默认为 0，实时更新预览


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" rainbow_parentheses.vim
" 高亮括号
" git clone https://github.com/kien/rainbow_parentheses.vim
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" 去掉了看不清的蓝色和黑色
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" ultisnips
" 代码片段
" git clone git://github.com/SirVer/ultisnips
" git clone git://github.com/honza/vim-snippets
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:UltiSnipsExpandTrigger="<leader><tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-easymotion
" 快速跳转
" git clone git://github.com/easymotion/vim-easymotion
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>f <Plug>(easymotion-s)
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-signature
" 显示mark标记
" git clone git://github.com/kshenoy/vim-signature
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"
" mx           Toggle mark 'x' and display it in the leftmost column
" dmx          Remove mark 'x' where x is a-zA-Z
"
" m,           Place the next available mark
" m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
" m-           Delete all marks from the current line
" m<Space>     Delete all marks from the current buffer
" ]`           Jump to next mark
" [`           Jump to prev mark
" ]'           Jump to start of next line containing a mark
" ['           Jump to start of prev line containing a mark
" `]           Jump by alphabetical order to next mark
" `[           Jump by alphabetical order to prev mark
" ']           Jump by alphabetical order to start of next line having a mark
" '[           Jump by alphabetical order to start of prev line having a mark
" m/           Open location list and display marks from current buffer
"
" m[0-9]       Toggle the corresponding marker !@#$%^&*()
" m<S-[0-9]>   Remove all markers of the same type
" ]-           Jump to next line having a marker of the same type
" [-           Jump to prev line having a marker of the same type
" ]=           Jump to next line having a marker of any type
" [=           Jump to prev line having a marker of any type
" m?           Open location list and display markers from current buffer
" m<BS>        Remove all markers


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" ctrlp
" 快速打开文件
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" NERDTree
" 树形目录
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdtree.git
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
map <F10> :NERDTreeToggle<CR>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" tagbar
" 大纲式导航
" cd ~/.vim/bundle
" git clone https://github.com/majutsushi/tagbar
" sudo apt-get install ctags
" brew install ctags
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
nmap <F9> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" syntastic
" 静态代码检查
" git clone https://github.com/scrooloose/syntastic
" sudo pip install pep8 pyflakes
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" :lnext     跳转到下一个错误
" :lprevious 跳转到上一个错误
" :lclose    关闭错误窗口
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_python_checkers = ['pyflakes', 'pep8']
""pep8 闹眼睛关掉了 以后随手F8格式化一下
let g:syntastic_python_checkers = ['pyflakes']
"let g:syntastic_mode_map = {
"    \ 'mode': 'passive',
"    \ 'active_filetypes': [],
"    \ 'passive_filetypes': ['python'] }
""关掉被动模式


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-autopep8
" 按照PEP8标准格式化Python代码
" git clone https://github.com/tell-k/vim-autopep8
" sudo pip install autopep8
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" autocmd FileType python map <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_max_line_length=150
let g:autopep8_disable_show_diff=1


" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
" sudo pip install jedi
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" 配合Rupertab插件实现<Tab>补全

" shows all the usages of a name
let g:jedi#usages_command = "<leader>z"
" typical goto function
let g:jedi#goto_assignments_command = "<leader>g"
" follow identifier as far as possible,
" includes imports and statements
let g:jedi#goto_command = "<leader>d"
" Show Documentation/Pydoc
let g:jedi#documentation_command = "K"
let g:jedi#rename_command = "<leader>r"
let g:jedi#completions_command = "<c-x><c-o>"

let g:jedi#use_splits_not_buffers = 'right'
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
" let g:jedi#goto_definitions_command = ""

" 使用:Pyimport命令 打开模块
"`:Pyimport module_name` Open module.

