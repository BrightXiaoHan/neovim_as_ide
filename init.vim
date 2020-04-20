" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug '907th/vim-auto-save'  " 自动保存插件
Plug 'sonph/onehalf', {'rtp': 'vim/'}  " onehalf 主题配色插件
" Markdown 相关插件
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"图标插件
Plug 'ryanoasis/vim-devicons'
" 状态栏插件
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Git相关插件
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
" 自动补全插件
Plug 'valloric/youcompleteme'
" NERDTree插件
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" 自动生成索引插件
Plug 'ludovicchabant/vim-gutentags'
" 语法检查插件
Plug 'dense-analysis/ale'
" 括号引号自动补全插件
Plug 'jiangmiao/auto-pairs'
" 文件快速切换
Plug 'yggdroot/leaderf'"
" 语法高亮显示增强
Plug 'sheerun/vim-polyglot'
" python mode
Plug 'klen/python-mode'
" terminal help
Plug 'voldikss/vim-floaterm'
" 异步任务执行插件
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" 测试插件
Plug 'janko-m/vim-test'

" 即时运行插件
Plug 'thinca/vim-quickrun'
" Initialize plugin system
call plug#end()

"设置显示行号
set number

" 设置indent间隔为4
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" 设置自动保存
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

" 强制显示侧边栏
set signcolumn=yes

" 设置jk键为退出边界模式
inoremap jk <ESC>

" 设置leader键为空格
let mapleader = "\<space>"


" 颜色主题onehalf配置
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

" YouCompleteMe的相关配置
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
noremap <c-z> <NOP>
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

" 配置NERDTree
map <C-n> :NERDTreeToggle<CR> " ctrl + n 开启和关闭文件树
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " 当只剩下NERDTree一个窗口时自动关闭vim
" 配置忽略文件
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.git']

" 配置自动索引插件vim-gutentags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" ALE配置
let g:ale_linters = {
\   'python': ['flake8'],
\   'c++': ['clang'],
\   'c': ['clang'],
\}
let g:ale_fixers = {
\   'python': ['autopep8', 'yapf'],
\   'c++': ['clang-format', 'clangtidy', 'uncrustify'],
\}

" LeaderF配置
let g:Lf_WindowPosition = 'popup' " 设置悬浮窗显示
let g:Lf_PreviewInPopup = 1

" floaterm 配置
let g:floaterm_keymap_new    = '<leader>n'
let g:floaterm_keymap_next   = '<leader><tab>'
let g:floaterm_keymap_toggle = '<leader>w'
" Set floaterm window's background to black
hi FloatermNF guibg=black
" " Set floating window border line color to cyan, and background to orange
hi FloatermBorderNF guibg=orange guifg=cyan

" AsyncRun AsyncTask 配置
let g:asynctasks_term_pos = "floaterm"
