"按键配置-------{{{

" Rebind <Leader> key
let mapleader = ","

"-按键替换-----{{{

" Map jj to <Esc>
" I模式下 jj 替换 Esc
inoremap jj <Esc>

" Go to home and end using capitalized directions
" N模式下 H 和 L 跳转行首行尾
noremap H ^
noremap L $

" Map ; to : and save a million keystrokes
" N模式下分号映射为冒号
nnoremap ; :

" Map Ctrl-r to U
" 撤销/重做 改为 u/U
nnoremap U <C-r>

" zt(置顶) 比 zz(置中) 更常用
nnoremap zz zt

" 阻止F1调出系统帮助
noremap <F1> <Esc>
inoremap <F1> <Esc>

"-按键替换-----}}}

"-快捷键-------{{{

" 命令模式增强
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" easier moving of code blocks
" v模式中 使用'<Tab>'和'<S-Tab>'进行缩进
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Quick save command
" <C-g> 快速保存
noremap <C-g> :update<CR>
vnoremap <C-g> <C-C>:update<CR>
inoremap <C-g> <C-O>:update<CR>

" Quick quit command
" 快速退出
noremap <Leader>q :quit!<CR> " 强制退出
noremap <Leader>e :quit<CR>  " 退出
noremap <Leader>E :qa!<CR>   " 退出所有窗口

" Removes highlight of your last search
" <C-n> 取消搜索高亮
noremap <C-n> :nohl<CR>

" gd 搜索当前单词 使用"a寄存器
noremap gd "ayiw/<C-r>a<CR>N

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" 切换窗口
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Map Ctrl-w T to <Leader>!
" 当前窗口转换为新标签
nnoremap <Leader>! <C-w>T

" 新建标签  Ctrl+t
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <esc>:tabnew<CR>

" easier moving between tabs
" 切换标签
noremap <Leader>n <esc>:tabprevious<CR>
noremap <Leader>m <esc>:tabnext<CR>

" 选中并高亮最后一次插入的内容
nnoremap <Leader>v `[v`]

" map sort function to a key
" v模式中 排序
vnoremap <Leader>s :sort<CR>

" easier formatting of paragraphs
" 排版文本
" vmap Q gq
" nmap Q gqap

" F12 可打印字符开关
nnoremap <F12> :set list! list?<CR>

" 空格折叠代码
nnoremap <space> za

" Better copy & paste
" 更友好的粘贴
set pastetoggle=<F2>
" 退出I模式时自动关闭友好粘贴
autocmd InsertLeave * set nopaste

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
" <Leader>b 快速设置调试断点
autocmd FileType python noremap <Leader>b Obreakpoint()  # BREAKPOINT<C-c>
" <F5> 运行文件
autocmd FileType python noremap <F5> :!python %<CR>
" <F6> 输入参数后运行文件
autocmd FileType python noremap <F6> :!python %<space>


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
"-快捷键-------}}}
"按键配置-------}}}

"界面配置-------{{{
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

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" 显示无用的空格
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Showing line numbers and length
" 显示行号和卡尺
set number  " show line numbers
set tw=79   " width of document (used by gd)
set colorcolumn=80
highlight ColorColumn ctermbg=233

" 取消自动换行
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing

" 高亮显示当前行和列
set cursorline
set cursorcolumn

" 光标的上方或下方至少会保留显示的行数
set scrolloff=7

"界面配置-------}}}

"通用配置-------{{{

"see: https://github.com/vim/vim/issues/3117#issuecomment-402622616
"if has('python3') && !has('patch-8.1.201')
  "silent! python3 1
"endif

" 修复 macOS Sierra 中 vim 剪板题
" 需要 brew install reattach-to-user-namespace
set clipboard=unnamed

" 打开文件自动定位到上次编辑位置
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Mouse and backspace
" on OSX press ALT and click
set mouse=a
" make backspace behave like normal again
set bs=2

" 使用utf-8编码
set encoding=utf-8

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

" Enable syntax highlighting
" 开启语法高亮
filetype off
filetype plugin indent on
syntax on

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

" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
"set foldmethod=indent
set foldmethod=marker
set foldlevel=99

" 禁用自动折叠
set nofoldenable

" 自动切换到正在编辑的文件的目录
set autochdir
"通用配置-------}}}

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Setup Pathogen to manage your plugins
" 使用 Pathogen 管理插件
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
call pathogen#infect()

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-toml
" git clone git://github.com/cespare/vim-toml.git
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-textobj-user
" 自定义 textobj 基类
" git clone git://github.com/kana/vim-textobj-user
" git clone git://github.com/bps/vim-textobj-python
" <动作><范围><textobj>
" eg. vaf 选择模式 a 函数
"     vac 选择模式 a 类
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
imap <C-f> <Plug>delimitMateS-Tab
""for python docstring
autocmd FileType python let b:delimitMate_nesting_quotes = ['"']

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" SimpylFold
" Python代码折叠
" git clone git://github.com/tmhedberg/SimpylFold
" zi 打开关闭折叠功能
" za 折叠或展开
" zc 折叠当前
" zo 展开当前
" zC 对所在范围内所有嵌套的折叠点进行折叠
" zO 对所在范围内所有嵌套的折叠点展开
" [z 到当前打开的折叠的开始处
" ]z 到当前打开的折叠的末尾处
" zj 向下移动 到下一个折叠的开始处
" zk 向上移动 到前一折叠的结束处
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:SimpylFold_docstring_preview = 1
"let g:SimpylFold_fold_docstring=0


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
let g:user_emmet_expandabbr_key = '<Leader><Leader><Tab>'
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

autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" ultisnips
" 代码片段
" git clone git://github.com/SirVer/ultisnips
" git clone git://github.com/BBOOXX/MyVimSnippets
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:UltiSnipsExpandTrigger="<Leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<Leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<Leader><s-tab>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-easymotion
" 快速跳转
" git clone git://github.com/easymotion/vim-easymotion
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><Leader>f <Plug>(easymotion-s)
map <Leader><Leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>l <Plug>(easymotion-lineforward)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" NERDTree
" 树形目录
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdtree.git
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
nnoremap <F10> :NERDTreeToggle<CR>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let NERDTreeNaturalSort=1

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" tagbar
" 大纲式导航
" cd ~/.vim/bundle
" git clone https://github.com/majutsushi/tagbar
" sudo apt-get install ctags
" brew install ctags
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
nnoremap <F9> :TagbarToggle<CR>
" 启动时自动获得焦点
let g:tagbar_autofocus = 1

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" NERDTree Git 插件
" 在 NERDTree 里显示 Git 状态
" cd ~/.vim/bundle
" git clone https://github.com/Xuyuanp/nerdtree-git-plugin
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Signify
" 显示 Git Gutter 插件
" cd ~/.vim/bundle
" git clone https://github.com/mhinz/vim-signify
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:signify_vcs_list = ['git']
highlight DiffAdd    cterm=bold ctermbg=30 ctermfg=255
highlight DiffDelete cterm=bold ctermbg=124 ctermfg=255
highlight DiffChange cterm=bold ctermbg=55  ctermfg=255

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" ale
" 异步的代码检查
" git clone https://github.com/w0rp/ale
" brew install fq
" pip install flake8
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:ale_open_list = 1

" 关闭实时检测 因为和代码片段有冲突
"let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_text_changed = 'never'
" 离开I模式时检测
let g:ale_lint_on_insert_leave = 0
" 打开文件时的检测 开启1关闭0
let g:ale_lint_on_enter = 1
"let g:ale_set_quickfix = 1
let g:ale_list_window_size = 5
let g:ale_python_pyflakes_auto_pipenv = 1
let g:ale_linters = {
    \ 'python' : ['pyflakes'],
    \}

autocmd FileType python,json nnoremap <buffer> <F8> :ALEFix<CR>
" Auto-close the error list
autocmd QuitPre * if empty(&bt) | lclose | endif

let g:ale_fixers = {
    \'python' : ['yapf', 'isort'],
    \'json' : ['jq'],
    \}

" if filereadable("./Pipfile")
"    let g:ale_python_pyflakes_executable = "pipenv"
" endif

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
" 注释和字符串中的文字会被收集用来补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_server_python_interpreter = 'python'
let g:ycm_python_binary_path = 'python'
"退出I模式时自动关闭preview窗口
let g:ycm_autoclose_preview_window_after_insertion = 1

" 在注释输入中补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中补全
let g:ycm_complete_in_strings = 1
" 跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
" 直接触发补全
let g:ycm_key_invoke_completion = '<Leader><tab>'
" 回车作为选中
let g:ycm_key_list_stop_completion = ['<CR>']
" 触发补全字数
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_register_as_syntastic_checker = 0
" 开启语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 提示UltiSnips
let g:ycm_use_ultisnips_completer = 1
nnoremap <Leader>d :topleft vertical YcmCompleter GoTo<CR>
nnoremap K :YcmCompleter GetDoc<CR>

"let g:ycm_semantic_triggers =  {
    "\ "c,cpp,python,java,go,erlang,perl": ['re!\w{2}'],
    "\ 'cs,lua,javascript': ['re!\w{2}'],
    "\ }

" 黑名单,不启用
let g:ycm_filetype_blacklist = {
    \ 'tagbar' : 1,
    \ 'gitcommit' : 1,
    \}

" 白名单,启用
"let g:ycm_filetype_whitelist = {
"    \ 'python' : 1,
"    \ 'zsh' : 1,
"    \ 'vim' : 1,
"    \ 'sshconfig' : 1,
"    \}

"弃用--------------{{{
"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"  " vim-table-mode
"  " 快速画Markdown表格
"  " git clone git://github.com/dhruvasagar/vim-table-mode
"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"  " <Leader>tm      开启
"  " 输入|| 创建顶端或底端

"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"  " DrawIt
"  " 快速画ASCII图
"  " git clone git://github.com/vim-scripts/DrawIt
"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"  " <Leader>di       开始
"  " <Leader>ds       结束
"  " h j k l          移动
"  " 上下左右         画线
"  " ^ v > <          小箭头
"  " <Leader> 加 ^v>< 大箭头
"  " <space>          切换橡皮/画笔

"  " 斜线和键盘方向一致
"  " Home    Up   Pgup
"  "     \   |   /
"  "      \  |  /
"  "       \ | /
"  "        \|/
"  " Left----------Right
"  "        /|\
"  "       / | \
"  "      /  |  \
"  "     /   |   \
"  "  End   Down  Pgdn

"  " V-Block 模式(C-V):
"  " <Leader>a       画对角线
"  " <Leader>l       不带箭头
"  " <Leader>b       矩形
"  " <Leader>e       椭圆
"  " <Leader>f       填充
"  " <Leader>s       整行填充空格
"  " <Leader>c       画布填充空格
"  " <C-LeftMouse>   移动

"  " 设置笔刷:
"  " V-Block 模式(C-V)选中文本后
"  " `"[a-z]y` 或 `:'<,'>SetBrush [a-z]`
"  " 设置选定文本为笔刷,[a-z]为寄存器
"  " 使用笔刷:
"  " <shift-leftmouse> 拖动鼠标
"  " `:SetBrush [a-z]` 设置当前笔刷
"  " <Leader>r[a-z]    使用笔刷(笔刷空白不透明)
"  " <Leader>p[a-z]    使用笔刷(笔刷空白透明)

"  " 命令模式:
"  " `:DInrml`         标准模式
"  " `:DIsngl`         单线模式
"  " `:DIdbl`          双线模式

"  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"  " markdown-preview.vim
"  " 可以通过浏览器实时预览 markdown 文件
"  " git clone https://github.com/iamcco/markdown-preview.vim.git
"  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"  let g:mkdp_path_to_chrome = "google-chrome"
"  " 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）

"  let g:mkdp_auto_start = 0
"  " 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，
"  " 只在打开 markdown 文件的时候打开一次

"  let g:mkdp_auto_open = 0
"  " 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，
"  " 否则自动打开预览窗口

"  let g:mkdp_auto_close = 1
"  " 在切换 buffer 的时候自动关闭预览窗口，
"  " 设置为 0 则在切换 buffer 的时候不自动关闭预览窗口
"
"  let g:mkdp_refresh_slow = 0
"  " 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，
"  " 默认为 0，实时更新预览

" " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" " vim-xxdcursor
" " xxd 模式光标
" " git clone git://github.com/mattn/vim-xxdcursor
" " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" " :set ft=xxd

" " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" " ctrlp
" " 快速打开文件
" " cd ~/.vim/bundle
" " git clone https://github.com/kien/ctrlp.vim.git
" " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" let g:ctrlp_max_height = 30
" set wildignore+=*.pyc
" set wildignore+=*_build/*
" set wildignore+=*/coverage/*
" set wildignore+=*/env/*
" set wildignore+=*/.git/*

"弃用--------------}}}
