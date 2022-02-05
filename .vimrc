" vim: set ts=2 sts=2 sw=2 foldmethod=marker foldlevel=0 nomodeline:
" =========================================================
"    通用配置  {{{
" =========================================================
if &compatible
  set nocompatible
endif

let s:darwin = has('mac')

" 仅为特定的文件类型加载插件
" 注意，对于使用 ftplugin 文件处理加载的插件不应该这样做。
"More info in :help pack-add
augroup packager_filetype
  autocmd!
  if isdirectory(".git") && !exists('$VIMRC_INIT')
    packadd vim-signify
  endif
  autocmd FileType Python packadd vim-textobj-user
  autocmd FileType Python packadd vim-textobj-python
  autocmd FileType Python packadd FastFold
  "autocmd FileType Python packadd SimpylFold
  autocmd FileType HTML,CSS packadd emmet-vim
  autocmd FileType CSS packadd vim-css-color
augroup END

" Mouse and backspace
set mouse=a
set backspace=indent,eol,start

" Mac 上的剪贴板
if s:darwin && !exists('$SSH_CONNECTION')
    set clipboard=unnamed
else
  if !exists('$VIMRC_INIT')
    packadd vim-osc52
  endif
endif

" 使用utf-8编码
set encoding=utf-8

" 显示不可显示字符的十六进制值
set display=uhex

" 如遇Unicode值大于255的文本，不必等到空格再折行
" See :help fo-table
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
" 光标可以移到另一行
set whichwrap=b,s
" 允许虚拟编辑
" (意味着光标可以定位在没有实际字符的地方)
set virtualedit=block

" Enable syntax highlighting
" 开启语法高亮
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

" C-A C-X 不修改八进制
set nrformats-=octal

" Make search case insensitive
" 搜索设置
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files
" 禁用备份和交换文件
set nobackup
set nowritebackup
set noswapfile

" 自动切换到正在编辑的文件的目录
set autochdir

" 禁用自动折叠
set nofoldenable
" 折叠方式
set foldmethod=manual
set foldlevel=99
" 等待映射键序列完成时间 毫秒计
set timeoutlen=300

" 不恢复文件尾缺失的<EOF>
" 保持文件原本的样子
if exists('&fixeol')
  set nofixeol
endif

"}}}
" =========================================================
"    自动化和自定义命令  {{{
" =========================================================

" 打开文件自动定位到上次编辑位置
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ | exe "normal! g'\""
  \ | endif

" 自动命名 tmux 的窗口和窗格
if exists('$TMUX') && !exists('$NORENAME')
  autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
  autocmd BufEnter * if empty(&buftype) | call system('tmux select-pane -T '.expand('%:t:S')) | endif
  autocmd VimLeave * call system('tmux select-pane -T $(hostname)')
  autocmd VimLeave * call system('tmux rename-window $SHELL')
  "autocmd VimLeave * call system('tmux set-window automatic-rename on')
endif

" 保存文件时 刷新Chrome
" :ConnectChrome  开启
" :ConnectChrome! 关闭
if s:darwin
  function! s:connect_chrome(bang)
    augroup connect-chrome
      autocmd!
      if !a:bang
        autocmd BufWritePost <buffer> call system(join(["osascript -e ".
        \ "'tell application \"Google Chrome\"".
        \ "to tell the active tab of its first window",
        \ "  reload",
        \ "end tell'"], "\n"))
      endif
    augroup END
  endfunction
  command! -bang ConnectChrome call s:connect_chrome(<bang>0)
endif

" Todo
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'rg --vimgrep --max-depth 5 --max-columns 120 -i -e TODO -e FIXME -e XXX 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

"}}}
" =========================================================
"    按键映射  {{{
" =========================================================
" Rebind <Leader> key
let mapleader = ","
let maplocalleader = ","

" I模式下 jj 替换 Esc
inoremap jj <Esc>
inoremap <C-c> <Esc>

" N模式下 H 和 L 跳转行首行尾
noremap H ^
noremap L $

" N模式下分号映射为冒号
" and save a million keystrokes
nnoremap ; :

" 撤销/重做 改为 u/U
nnoremap U <C-r>

" zt(置顶) 比 zz(置中) 更常用
nnoremap zz zt

" 阻止F1调出系统帮助
inoremap <F1> <Esc>

" qq to record,
" Q to replay
nnoremap Q @q

" 命令模式增强
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" 命令模式<C-l> 重绘屏幕
cnoremap <C-l> :redraw!<CR>

" v模式中 使用'<Tab>'和'<S-Tab>'进行缩进
xnoremap <S-Tab> <gv
xnoremap <Tab> >gv

" <C-g> 快速保存
nnoremap <C-g> :update<CR>
vnoremap <C-g> <C-C>:update<CR>
inoremap <C-g> <C-O>:update<CR>

" 强制退出
nnoremap <Leader>q :quit!<CR>
" 退出
nnoremap <Leader>e :quit<CR>
" 退出所有窗口
nnoremap <Leader>E :qa!<CR>

" <C-n> 取消搜索高亮
nnoremap <silent><C-n> :nohl<CR>

" gd 搜索当前单词 使用"a寄存器
nnoremap <silent>gd "1yiw/<C-r>1<CR>N

" 切换窗口
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" fix Alt Key
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
" 移动行
nnoremap <silent> <M-k> :move-2<cr>
nnoremap <silent> <M-j> :move+<cr>
xnoremap <silent> <M-k> :move-2<cr>gv
xnoremap <silent> <M-j> :move'>+<cr>gv

" 新建标签  Ctrl+t
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" 切换标签
nnoremap <Leader>n <Esc>:tabprevious<CR>
nnoremap <Leader>m <Esc>:tabnext<CR>

" 选中并高亮最后一次插入的内容
nnoremap <Leader>v `[v`]

" v模式中 排序
xnoremap <Leader>s :sort<CR>

" easier formatting of paragraphs
" 排版文本
" vmap Q gq
" nmap Q gqap

" F12 可打印字符开关
nnoremap <silent><F12> :set list! list?<CR>

" 空格折叠代码
nnoremap <space> za

" 更友好的粘贴
set pastetoggle=<F2>
" 退出I模式时自动关闭友好粘贴
autocmd InsertLeave * set nopaste

" 开关行号函数
" 绝对行号
function! s:HideNumber()
  set number!
  set number?
endfunc

" 相对行号
function! s:HideRelativeNumber()
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
nnoremap <F3> :call <sid>HideNumber()<CR>

" Better navigating through omnicomplete option list
" See https://is.gd/ObrWIM
set completeopt=longest,menuone
function! s:OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=<sid>OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=<sid>OmniPopup('k')<CR>

" 当前窗口转换为新标签
nnoremap <Leader>! <C-w>T

" 窗口临时最大化
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
" 窗口临时最大化
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" 根据文件类型来启用快捷键
augroup shortcut_key_filetype
    autocmd!
    " Python 文件中的快捷键
    " <Leader>b 快速设置调试断点
    autocmd FileType python nnoremap <Leader>b Obreakpoint()  # BREAKPOINT<C-c>
    " <F5> 运行文件
    autocmd FileType python nnoremap <F5> :!python %<CR>
    " <F6> 输入参数后运行文件
    autocmd FileType python nnoremap <F6> :!python %<space>
augroup END

"}}}
" =========================================================
"    界面配置  {{{
" =========================================================

" 显示无用的空格
" 必须在colorscheme命令之前插入
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" 设置主题
set t_Co=256
if !exists('$VIMRC_INIT')
  packadd onedark.vim
  color onedark
endif

" 修复 Vim 真彩色的 Bug
if $COLORTERM == "truecolor" && has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" 显示行号和卡尺
set number
set tw=79
set colorcolumn=80
highlight ColorColumn ctermbg=233

" 显示输入命令
set showcmd

" 不可见符号
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·

" 取消自动换行
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing

" 高亮显示当前行和列
set cursorline
set cursorcolumn

" 光标的上方或下方至少会保留显示的行数
set scrolloff=7

"执行宏过程中屏幕不会重画
set lazyredraw

"命令行补全增强
set wildmenu

"}}}
" =========================================================
"    插件管理  {{{
" =========================================================
function! s:PackagerInit() abort

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  初始化 vim-packager 插件
    packadd vim-packager
    call packager#init({'depth':1,'window_cmd': 'vertical botright new'})
    call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  主题
    call packager#add('joshdick/onedark.vim', {'type': 'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  性能分析
    call packager#add('tweekmonster/startuptime.vim', {'type': 'opt'})
    call packager#add('dstein64/vim-startuptime', {'type': 'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  中文文档
    call packager#add('yianwillis/vimcdoc', {'type': 'opt'})
    " <F1> 加载
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  语法和缩进支撑
    call packager#add('sheerun/vim-polyglot')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  状态栏
    call packager#add('vim-airline/vim-airline')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  代码片段
    " 基础
    call packager#add('SirVer/ultisnips')
    " 片段
    call packager#add('BBOOXX/MyVimSnippets')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  自动闭合符号
    call packager#add('Raimondi/delimitMate')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  包裹符号
    call packager#add('tpope/vim-surround')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  快速跳转
    call packager#add('easymotion/vim-easymotion', {'type':'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  对齐插件
    call packager#add('junegunn/vim-easy-align', {'type': 'opt'})
    " 选中后 ga 进入对齐插件
    "   <符号>       第一次出现位置对齐
    " 2 <符号>       第二次出现位置对齐
    " - <符号>       最后一次出现位置对齐
    " -2 <符号>      倒数第二次出现位置对齐
    " * <符号>       所有符号位置对齐
    " ** <符号>      所有符号位置左右交替对齐
    " <Enter>        在 左/右/中心 对齐模式之间切换
    " <C-x>          正则模式
    " <C-p>          实时模式
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  彩虹括号
    call packager#add('kien/rainbow_parentheses.vim')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  CSS颜色高亮
    call packager#add('ap/vim-css-color', {'type': 'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  高亮操作对象
    call packager#add('machakann/vim-highlightedyank')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  显示 Mark 标记
    call packager#add('kshenoy/vim-signature')
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
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  大纲插件
    let tagbar_do = ''
    if s:darwin && system('which ctags | tr -d \\n') != "/usr/local/bin/ctags"
      let tagbar_do = 'brew tap universal-ctags/universal-ctags '.
        \'&& brew install --with-jansson --HEAD universal-ctags'
    endif
    call packager#add('majutsushi/tagbar', { 'type': 'opt', 'do': tagbar_do})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  HTML Emmet 插件
    call packager#add('mattn/emmet-vim', {'type': 'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  Git 标记
    call packager#add('mhinz/vim-signify', {'type':'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  注释插件
    call packager#add('scrooloose/nerdcommenter', {'type':'opt'})
    " <Leader>cc      最基本注释
    " <Leader>cu      撤销注释
    " <Leader>cm      多行注释
    " <Leader>cs      性感的注释方式
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  树形目录
    call packager#add('scrooloose/nerdtree', {'type':'opt'})
    " 树形目录上的 Git 标记 (不支持惰性加载)
    call packager#add('Xuyuanp/nerdtree-git-plugin')
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  文本对象
    " 基础插件
    call packager#add('kana/vim-textobj-user', {'type':'opt'})
    " Python 文本对象
    call packager#add('bps/vim-textobj-python', {'type':'opt'})
    "  <动作><范围><textobj>
    "  eg. vaf 选择模式 a 函数
    "      vac 选择模式 a 类
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{ 快速折叠
    call packager#add('Konfekt/FastFold', {'type':'opt'})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  Python 代码折叠
    call packager#add('tmhedberg/SimpylFold', {'type':'opt'})
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
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  代码检查
    let ale_do = ''
    if !executable('jq') && s:darwin
      let ale_do = "brew install jq"
    endif
    call packager#add('w0rp/ale', {'do': ale_do})
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" {{{  代码补全
  if v:version >= 801
    call packager#add('Valloric/YouCompleteMe', {'do': 'python3 install.py'})
  endif
" }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"   {{{  OSC52 支持
    call packager#add('BBOOXX/vim-osc52',{'type': 'opt'})
"   }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    if s:darwin
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"   {{{  自动切换输入法
        call packager#add('CodeFalling/fcitx-vim-osx')
"   }}}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    endif
endfunction

command! PackagerInstall call s:PackagerInit() | call packager#install()
command! -bang PackagerUpdate call s:PackagerInit() | call packager#update({'force_hooks': '<bang>'})
command! PackagerClean call s:PackagerInit() | call packager#clean()
command! PackagerStatus call s:PackagerInit() | call packager#status()
"}}}
" =========================================================
" 插件配置 {{{
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" delimitmate
" 自动补完符号
" more info in :help delimitmateautoclose
let delimitMate_autoclose = 1
let delimitMate_expand_cr = 1
" c-f 跳出边界
imap <C-f> <Plug>delimitMateS-Tab
""for python docstring
autocmd FileType Python let b:delimitMate_nesting_quotes = ['"']
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vimcdoc
" Vim 中文文档
nnoremap <F1> :packadd vimcdoc <BAR>nnoremap <F1> :help<Space><CR>:help<Space>
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" nerdcommenter
" 注释插件
function! s:ReMapNerdcommenter()
  nnoremap <silent><Leader>cc :<C-u>call nerdcommenter#Comment("n", "Comment")<CR>
  xnoremap <silent><Leader>cc :<C-u>call nerdcommenter#Comment("x", "Comment")<CR>
  nnoremap <silent><Leader>cu :<C-u>call nerdcommenter#Comment("n", "Uncomment")<CR>
  xnoremap <silent><Leader>cu :<C-u>call nerdcommenter#Comment("x", "Uncomment")<CR>
  nnoremap <silent><Leader>cm :<C-u>call nerdcommenter#Comment("n", "Minimal")<CR>
  xnoremap <silent><Leader>cm :<C-u>call nerdcommenter#Comment("x", "Minimal")<CR>
  nnoremap <silent><Leader>cs :<C-u>call nerdcommenter#Comment("n", "Sexy")<CR>
  xnoremap <silent><Leader>cs :<C-u>call nerdcommenter#Comment("x", "Sexy")<CR>
endfunction

nnoremap <silent><Leader>cc :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("n", "Comment")<BAR>call <SID>ReMapNerdcommenter()<CR>
xnoremap <silent><Leader>cc :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("x", "Comment")<BAR>call <SID>ReMapNerdcommenter()<CR>
nnoremap <silent><Leader>cu :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("n", "Uncomment")<BAR>call <SID>ReMapNerdcommenter()<CR>
xnoremap <silent><Leader>cu :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("x", "Uncomment")<BAR>call <SID>ReMapNerdcommenter()<CR>
nnoremap <silent><Leader>cm :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("n", "Minimal")<BAR>call <SID>ReMapNerdcommenter()<CR>
xnoremap <silent><Leader>cm :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("x", "Minimal")<BAR>call <SID>ReMapNerdcommenter()<CR>
nnoremap <silent><Leader>cs :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("n", "Sexy")<BAR>call <SID>ReMapNerdcommenter()<CR>
xnoremap <silent><Leader>cs :<C-u>packadd nerdcommenter<BAR>call nerdcommenter#Comment("x", "Sexy")<BAR>call <SID>ReMapNerdcommenter()<CR>

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" SimpylFold
" Python 代码折叠
" 显示预览
autocmd FileType Python let g:SimpylFold_docstring_preview = 1
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-highlightedyank
" 高亮操作对象
let g:highlightedyank_highlight_duration = 150
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-airline
" 状态栏增强
let g:airline_symbols_ascii = 1
let g:airline_extensions = []
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Emmet-vim
let g:user_emmet_expandabbr_key = '<Leader><Leader><Tab>'
"only enable insert mode functions.
let g:user_emmet_mode='i'
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" tpope/vim-surround
" 包裹符号
let g:surround_no_mappings = 1
xmap s <Plug>VSurround
xmap ' <Plug>VSurround'
xmap " <Plug>VSurround"
xmap ( <Plug>VSurround(
xmap ) <Plug>VSurround)
xmap [ <Plug>VSurround[
xmap ] <Plug>VSurround]
xmap { <Plug>VSurround{
xmap } <Plug>VSurround}
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" rainbow_parentheses.vim
" 高亮括号
if exists(':RainbowParenthesesToggle')
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
endif
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" ultisnips
" 代码片段
let g:UltiSnipsExpandTrigger="<Leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<Leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<Leader><s-tab>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-easy-align
" 对齐插件
vnoremap <silent>ga :<Home>packadd vim-easy-align<BAR>vmap ga <Plug>(EasyAlign)<BAR><End>EasyAlign<CR>
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" vim-easymotion
" 快速跳转
let g:EasyMotion_smartcase = 1

function! s:ReMapEasymotion()
  map  <silent><Leader><Leader>f <Plug>(easymotion-s)
  map  <silent><Leader><Leader>h <Plug>(easymotion-linebackward)
  map  <silent><Leader><Leader>j <Plug>(easymotion-j)
  map  <silent><Leader><Leader>k <Plug>(easymotion-k)
  map  <silent><Leader><Leader>l <Plug>(easymotion-lineforward)
  map  <silent>/ <Plug>(easymotion-sn)
  omap <silent>/ <Plug>(easymotion-tn)
endfunction

map  <silent><Leader><Leader>f :packadd vim-easymotion<BAR>call <sid>ReMapEasymotion()<CR><Plug>(easymotion-s)
map  <silent><Leader><Leader>h :packadd vim-easymotion<BAR>call <sid>ReMapEasymotion()<CR><Plug>(easymotion-linebackward)
map  <silent><Leader><Leader>j :packadd vim-easymotion<BAR>call <sid>ReMapEasymotion()<CR><Plug>(easymotion-j)
map  <silent><Leader><Leader>k :packadd vim-easymotion<BAR>call <sid>ReMapEasymotion()<CR><Plug>(easymotion-k)
map  <silent><Leader><Leader>l :packadd vim-easymotion<BAR>call <sid>ReMapEasymotion()<CR><Plug>(easymotion-lineforward)
map  <silent>/ :packadd vim-easymotion<BAR>call <sid>ReMapEasymotion()<CR><Plug>(easymotion-sn)
omap <silent>/ :packadd vim-easymotion<BAR>call <sid>ReMapEasymotion()<CR><Plug>(easymotion-tn)
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" NERDTree
" 树形目录
nnoremap <silent><F9> :packadd nerdtree<BAR>nnoremap <lt>silent><lt>F9> :NERDTreeToggle<lt>CR><BAR>NERDTreeToggle<CR>
let g:NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:NERDTreeNaturalSort=1
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" tagbar
" 大纲式导航
" sudo apt-get install ctags
" brew tap universal-ctags/universal-ctags
" brew install --HEAD universal-ctags
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
nnoremap <silent><F10> :packadd tagbar<BAR>nnoremap <lt>silent><lt>F10> :TagbarToggle<lt>CR><BAR>TagbarToggle<CR>
" 启动时自动获得焦点
let g:tagbar_autofocus = 1
" 按文件中顺序排序
let g:tagbar_sort = 0
" 显示行号
"  0：不显示任何行号
"  1：显示绝对行号
"  2：显示相对行号
" -1：使用全局行号设置
let g:tagbar_show_linenumbers = -1

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Signify
" 显示 Git Gutter 插件
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let g:signify_vcs_list = ['git']
highlight DiffAdd    cterm=bold ctermbg=30 ctermfg=255
highlight DiffDelete cterm=bold ctermbg=124 ctermfg=255
highlight DiffChange cterm=bold ctermbg=55  ctermfg=255

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" ale
" 异步的代码检查
" brew install fq
" pip install flake8
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:ale_disable_lsp = 1
let g:ale_open_list = 1

" 关闭实时检测 因为和代码片段有冲突
"let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_text_changed = 'never'
" 离开I模式时检测 0 关闭 1 开启
let g:ale_lint_on_insert_leave = 0
" 打开文件时的检测 0 关闭 1 开启
let g:ale_lint_on_enter = 1
"let g:ale_set_quickfix = 1
let g:ale_list_window_size = 5
let g:ale_python_pyflakes_auto_pipenv = 1
let g:ale_python_pylint_auto_pipenv = 1
let g:ale_python_pylint_use_msg_id = 1
let g:ale_python_pylint_options = '-d C0114,C0115,C0116,C0301'
let g:ale_linters = {
    \ 'python' : [
    \ 'pyflakes',
    \ 'pylint',
    \ ],
    \ }

autocmd FileType python,json nnoremap <buffer> <F8> :ALEFix<CR>
" Auto-close the error list
autocmd QuitPre * if empty(&bt) | lclose | endif

let g:ale_fixers = {
    \'python' : ['yapf', 'isort'],
    \'json' : ['jq'],
    \}

" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" YouCompleteMe
" python ~/.vim/bundle/YouCompleteMe/install.py --racer-completer
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" 注释和字符串中的文字会被收集用来补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_python_binary_path = 'python3'
"退出I模式时自动关闭preview窗口
let g:ycm_autoclose_preview_window_after_insertion = 1

" 签名帮助
let g:ycm_auto_trigger = 1
" 在注释输入中补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中补全
let g:ycm_complete_in_strings = 1
" 跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
" 直接触发补全
let g:ycm_key_invoke_completion = '<Leader>f'
" 回车作为选中
let g:ycm_key_list_stop_completion = ['<CR>']
" 触发补全字数
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_register_as_syntastic_checker = 0
" 开启语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 提示UltiSnips
let g:ycm_use_ultisnips_completer = 1
" 关闭自动弹出文档
let g:ycm_auto_hover = ''
" K 弹出文档
nmap K <Plug>(YCMHover)
" T 查看文档
nnoremap T :YcmCompleter GetDoc<CR>
" <Leader>d 跳转
nnoremap <Leader>d :topleft vertical YcmCompleter GoTo<CR>

if s:darwin
  let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'swift',
  \     'cmdline': '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp',
  \     'filetypes': ['swift'],
  \     'project_root_files': [ '*.xcworkspace', '*.xcodeproj', 'Package.swift' ]
  \   },
  \ ]
endif

" 黑名单,不启用
let g:ycm_filetype_blacklist = {
    \ 'tagbar' : 1,
    \ 'gitcommit' : 1,
    \}

"}}}
" =========================================================
