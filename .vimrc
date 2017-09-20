" Automatic reloading of .vimrc
" 自动加载.vimrc文件
autocmd! bufwritepost .vimrc source %

" Rebind <Leader> key
let mapleader = ","

" Map jj to <Esc>
" jj 替换 Esc
inoremap jj <Esc>

" Go to home and end using capitalized directions
" H 和 L 跳转行首行尾
noremap H ^
noremap L $

" Map ; to : and save a million keystrokes
" N模式下分号映射为冒号
nnoremap ; :

" Map Ctrl-r to U
" 撤销/重做 改为 u/U
nnoremap U <C-r>

" Removes highlight of your last search
" 取消搜索高亮
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Quick save command
" 快速保存
" noremap <Leader>w :update<CR>
" 和<Leader>q (强制退出) 太近了, 容易悲剧
noremap <C-z> :update<CR>
vnoremap <C-z> <C-C>:update<CR>
inoremap <C-z> <C-O>:update<CR>

" Quick quit command
" 快速退出
noremap <Leader>q :quit!<CR> " 强制退出
noremap <Leader>e :quit<CR>  " 退出
noremap <Leader>E :qa!<CR>   " 退出所有窗口

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" 切换窗口
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" 新建标签  Ctrl+t
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <esc>:tabnew<CR>

" easier moving between tabs
" 切换标签
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" easier moving of code blocks
" v模式中 使用'<Tab>'和'<S-Tab>'进行缩进
vnoremap <S-Tab> <gv    " better indentation
vnoremap <Tab> >gv  " better indentation

" Map Ctrl-w T to <Leader>!
" 当前窗口转换为新标签
nnoremap <Leader>! <C-w>T

" 选中并高亮最后一次插入的内容
nnoremap <Leader>v `[v`]

" map sort function to a key
" v模式中 排序
vnoremap <Leader>s :sort<CR>

" easier formatting of paragraphs
" 排版文本
" vmap Q gq
" nmap Q gqap

" 阻止F1调出系统帮助
noremap <F1> <Esc>
" F12 可打印字符开关
nnoremap <F12> :set list! list?<CR>

" Better copy & paste
" 更友好的粘贴
set pastetoggle=<F2>

" 开关行号函数
" 绝对行号
function! HideNumber()
  set number!
  set number?
endfunc

" 相对行号
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
" <Leader>b 快速设置 pdb 调试断点
"autocmd FileType python map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
autocmd FileType python map <Leader>b Oimport pudb; pu.db  # BREAKPOINT<C-c>

" <F4> 输入参数后运行文件
autocmd FileType python map <F4> :!python %<space>

" <F5> 运行文件
autocmd FileType python map <F5> :!python %<cr>

" JSON 文件中的快捷键
" <F5> 格式化json
autocmd FileType json map <F5> :%!python -m json.tool <cr>

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

" 修复 macOS Sierra 中 vim 剪板题
" 需要 brew install reattach-to-user-namespace
set clipboard=unnamed

" 打开文件自动定位到上次编辑位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Mouse and backspace
" on OSX press ALT and click
set mouse=a
" make backspace behave like normal again
set bs=2

" 显示输入命令
set showcmd

" 使用utf-8编码
set encoding=utf-8

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" 显示无用的空格
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

" Enable syntax highlighting
" 开启语法高亮
filetype off
filetype plugin indent on
syntax on

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
" vim-textobj-user
" 自定义 textobj 基类
" vim-textobj-indent
" 定义缩进 textobj
" git clone git://github.com/kana/vim-textobj-user
" git clone git://github.com/kana/vim-textobj-indent
" <动作><范围><textobj>
" eg. vip 选择模式 i 段落
"     vii 选择模式 i 缩进
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-xxdcursor
" xxd 模式光标
" git clone git://github.com/mattn/vim-xxdcursor
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"
" :set ft=xxd

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
" vim-python-pep8-indent
" 符合PEP8风格的缩进
" git clone git://github.com/Vimjas/vim-python-pep8-indent
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" delimitMate
" 自动补完符号
" git clone https://github.com/Raimondi/delimitMate.git
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" 自动闭合
" let delimitMate_autoclose = 0
imap <c-f> <Plug>delimitMateS-Tab
""for python docstring
au FileType python let b:delimitMate_nesting_quotes = ['"']

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-isort
" 排序python import
" pip install isort
" git clone git://github.com/fisadev/vim-isort
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:vim_isort_map = '<F6>'

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-airline
" 状态栏增强
" cd ~/.vim/bundle
" git clone git://github.com/vim-airline/vim-airline
" git clone git://github.com/vim-airline/vim-airline-themes
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
set laststatus=2
let g:airline_theme='powerlineish'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Emmet-vim
" git clone https://github.com/mattn/emmet-vim
" http://www.zfanw.com/blog/zencoding-vim-tutorial-chinese.html
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
autocmd FileType html,css EmmetInstall
let g:user_emmet_expandabbr_key = '<leader><leader><Tab>'
let g:user_emmet_install_global = 0
let g:user_emmet_mode='i'    "only enable insert mode functions.
" let g:user_emmet_leader_key='<C-Y>'
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
" let g:user_emmet_mode='a'    "enable all function in all mode.

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
set wildignore+=*/env/*

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
" 启动时自动获得焦点
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
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_python_checkers = ['pyflakes', 'pep8']
" pep8 闹眼睛关掉了 以后随手F8格式化一下
let g:syntastic_python_checkers = ['pyflakes']
" 被动模式
"let g:syntastic_mode_map = {
"    \ 'mode': 'passive',
"    \ 'active_filetypes': [],
"    \ 'passive_filetypes': ['python'] }

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-autopep8
" 按照PEP8标准格式化Python代码
" git clone https://github.com/tell-k/vim-autopep8
" sudo pip install autopep8
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
autocmd FileType python map <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_max_line_length=150
let g:autopep8_disable_show_diff=1

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-easy-align
" 快速对齐
" git clone git://github.com/junegunn/vim-easy-align
" 选中后 ga 进入对齐插件
"   <符号>       第一次出现位置对齐
" 2 <符号>       第二次出现位置对齐
" - <符号>       最后一次出现位置对齐
" * <符号>       所有符号位置对齐
" ** <符号>      所有符号位置左右交替对齐
" <Enter>       在 左/右/中心 对齐模式之间切换
" <C-x>         正则模式
" <C-p>         实时模式
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
xmap ga <Plug>(EasyAlign)

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" YouCompleteMe
" git clone git://github.com/Valloric/YouCompleteMe
" cd ~/.vim/bundle/YouCompleteMe
" git submodule update --init --recursive
" python ~/.vim/bundle/YouCompleteMe/install.py --racer-completer
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_goto_buffer_command = 'horizontal-split'          " 跳转到定义处, 分屏打开
let g:ycm_key_invoke_completion = '<Leader><tab>'           " 直接触发自动补全 insert模式下
let g:ycm_key_list_stop_completion = ['<CR>']               " 回车作为选中
let g:ycm_min_num_of_chars_for_completion = 2               " 触发补全字数
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_seed_identifiers_with_syntax=1                    " 开启语法关键字补全
let g:ycm_use_ultisnips_completer = 1                       " 提示UltiSnips
nnoremap <leader>d :YcmCompleter GoTo<CR>
nnoremap K :YcmCompleter GetDoc<CR>

" 黑名单,不启用
let g:ycm_filetype_blacklist = {
    \ 'tagbar' : 1,
    \ 'gitcommit' : 1,
    \}


"弃用"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"弃用"  " Rupertab
"弃用"  " Tab增强
"弃用"  " git clone https://github.com/ervandew/supertab
"弃用"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"弃用"  " let g:SuperTabDefaultCompletionType = "context"
"弃用"  ""let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"弃用"  
"弃用"  
"弃用"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"弃用"  " vim-table-mode
"弃用"  " 快速画Markdown表格
"弃用"  " git clone git://github.com/dhruvasagar/vim-table-mode
"弃用"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"弃用"  " <Leader>tm      开启
"弃用"  " 输入|| 创建顶端或底端
"弃用"  
"弃用"  
"弃用"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"弃用"  " DrawIt
"弃用"  " 快速画ASCII图
"弃用"  " git clone git://github.com/vim-scripts/DrawIt
"弃用"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"弃用"  " <Leader>di       开始
"弃用"  " <Leader>ds       结束
"弃用"  " h j k l          移动
"弃用"  " 上下左右         画线
"弃用"  " ^ v > <          小箭头
"弃用"  " <Leader> 加 ^v>< 大箭头
"弃用"  " <space>          切换橡皮/画笔
"弃用"  
"弃用"  " 斜线和键盘方向一致
"弃用"  " Home    Up   Pgup
"弃用"  "     \   |   /
"弃用"  "      \  |  /
"弃用"  "       \ | /
"弃用"  "        \|/
"弃用"  " Left----------Right
"弃用"  "        /|\
"弃用"  "       / | \
"弃用"  "      /  |  \
"弃用"  "     /   |   \
"弃用"  "  End   Down  Pgdn
"弃用"  
"弃用"  " V-Block 模式(C-V):
"弃用"  " <Leader>a       画对角线
"弃用"  " <Leader>l       不带箭头
"弃用"  " <Leader>b       矩形
"弃用"  " <Leader>e       椭圆
"弃用"  " <Leader>f       填充
"弃用"  " <Leader>s       整行填充空格
"弃用"  " <Leader>c       画布填充空格
"弃用"  " <C-LeftMouse>   移动
"弃用"  
"弃用"  " 设置笔刷:
"弃用"  " V-Block 模式(C-V)选中文本后
"弃用"  " `"[a-z]y` 或 `:'<,'>SetBrush [a-z]`
"弃用"  " 设置选定文本为笔刷,[a-z]为寄存器
"弃用"  " 使用笔刷:
"弃用"  " <shift-leftmouse> 拖动鼠标
"弃用"  " `:SetBrush [a-z]` 设置当前笔刷
"弃用"  " <Leader>r[a-z]    使用笔刷(笔刷空白不透明)
"弃用"  " <Leader>p[a-z]    使用笔刷(笔刷空白透明)
"弃用"  
"弃用"  " 命令模式:
"弃用"  " `:DInrml`         标准模式
"弃用"  " `:DIsngl`         单线模式
"弃用"  " `:DIdbl`          双线模式
"弃用"  
"弃用"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"弃用"  " markdown-preview.vim
"弃用"  " 可以通过浏览器实时预览 markdown 文件
"弃用"  " git clone https://github.com/iamcco/markdown-preview.vim.git
"弃用"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"弃用"  let g:mkdp_path_to_chrome = "google-chrome"
"弃用"  " 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
"弃用"  
"弃用"  let g:mkdp_auto_start = 0
"弃用"  " 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，
"弃用"  " 只在打开 markdown 文件的时候打开一次
"弃用"  
"弃用"  let g:mkdp_auto_open = 0
"弃用"  " 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，
"弃用"  " 否则自动打开预览窗口
"弃用"  
"弃用"  let g:mkdp_auto_close = 1
"弃用"  " 在切换 buffer 的时候自动关闭预览窗口，
"弃用"  " 设置为 0 则在切换 buffer 的时候不自动关闭预览窗口
"弃用"  
"弃用"  let g:mkdp_refresh_slow = 0
"弃用"  " 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，
"弃用"  " 默认为 0，实时更新预览
"弃用"  
"弃用"  
"弃用"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"弃用"  " jedi-vim
"弃用"  " cd ~/.vim/bundle
"弃用"  " git clone git://github.com/davidhalter/jedi-vim.git
"弃用"  " sudo pip install jedi
"弃用"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"弃用"  " 配合Rupertab插件实现<Tab>补全
"弃用"  
"弃用"  " shows all the usages of a name
"弃用"  let g:jedi#usages_command = "<leader>z"
"弃用"  " typical goto function
"弃用"  let g:jedi#goto_assignments_command = "<leader>g"
"弃用"  " follow identifier as far as possible,
"弃用"  " includes imports and statements
"弃用"  let g:jedi#goto_command = "<leader>d"
"弃用"  " Show Documentation/Pydoc
"弃用"  let g:jedi#documentation_command = "K"
"弃用"  let g:jedi#rename_command = "<leader>r"
"弃用"  let g:jedi#completions_command = "<c-x><c-o>"
"弃用"  
"弃用"  let g:jedi#use_splits_not_buffers = 'right'
"弃用"  let g:jedi#popup_select_first = 0
"弃用"  let g:jedi#popup_on_dot = 0
"弃用"  " let g:jedi#goto_definitions_command = ""
"弃用"  
"弃用"  " 使用:Pyimport命令 打开模块
"弃用"  "`:Pyimport module_name` Open module.

