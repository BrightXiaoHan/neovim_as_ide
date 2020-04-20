### 安装neovim
这里以常用的Ubuntu系统为例
使系统可以使用add-apt-repository
```
sudo apt-get install software-properties-common
```
使用apt安装vim
```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```

### 配置文件的位置
Neovim 是能使用 vim 的配置文件的，如果有 vim 的配置，直接软链接就好：
```vim
ln -s ~/.vim .config/nvim
ln -s ~/.vimrc .config/nvim/init.vim
```
如果没有 vim 的配置文件，但想 vim 和 nvim 使用同一个配置，也按上面的方法配置就行。
　　有时 neovim 的某些指令在 vim 中是不能使用的, 所以可使用 has('nvim') 来判断当前使用的版本：
```vim
if has('nvim')
    ...
endif
```
如果想 nvim 单独使用一个配置，那就在 .config 下创建配置文件就行：

```vim
mkdir .config/nvim
touch .config/nvim/init.vim
```

### 配置indent间隔为4（默认为8）
```vim
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
```

### 配置显示行号
neovim默认配置是不显示行号的，如果要nvim显示行号，需要在normal模式下输入
```
:set number
```
如果想永久显示行号，将上述命令写入到配置文件中
```
set number 
```

### 插件管理器vim-plug
这是比较基本的一个东西，如今 Vim 下熟练开发的人，基本上手都有 20-50 个插件，遥想十年前，Vim里常用的插件一只手都数得过来。过去我一直使用老牌的 Vundle 来管理插件，但是随着插件越来越多，更新越来越频繁，Vundle 这种每次更新就要好几分钟的东西实在是不堪重负了，在我逐步对 Vundle 失去耐心之后，我试用了 vim-plug ，用了两天以后就再也回不去 Vundle了，它支持全异步的插件安装，安装50个插件只需要一分钟不到的时间，这在 Vundle 下面根本不可想像的事情，插件更新也很快，不像原来每次更新都可以去喝杯茶去，最重要的是它支持插件延迟加载。抛弃 Vundle 切换到 vim-plug 以后，不仅插件安装和更新快了一个数量级，大量的插件我都配置成了延迟加载，Vim 启动速度比 Vundle 时候提高了不少。使用 Vundle 的时候一旦插件数量超过30个，管理是一件很痛苦的事情，而用了 vim-plug 以后，50-60个插件都轻轻松松。
```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \\n    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
在你的.config/nvim/init.vim中添加如下内容
```vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Put your plugins here

" Initialize plugin system
call plug#end()
```
打开nvim，在普通模式下输入```:PluginInstall```安装所有插件。

### 括号自动补全以及tab键跳出括号
很多现代 IDE 都有自动补全配对括号的功能，比如输入了左括号“(”，IDE 就自动在后面添加一个对应的右括号“)”，并且将光标移到括号中间
除了括号的自动补全，有时我们也需要括号的自动删除。比如在输入了左括号后突然发现输错了，本来只需要简单地按一下退格键，将刚才输入的左括号删除就行了，但现在 VIM 自动加了一个右括号，退格键只能删除左括号，这个自动加上右括号还得按一下 DELETE 键才能删掉。所以，我们还需要一个功能，如果按退格键删除了左括号，那么也要自动地把对应的右括号删除。我综合比较了自己配置和各种插件，觉得[auto-pairs](https://github.com/jiangmiao/auto-pairs)用起来最顺手，bug最少。
```vim
Plug'jiangmiao/auto-pairs'
```
另外，在自动补全了右括号之后，如果用户再输入右括号会怎么样呢？一般来说，比较合理的做法似乎是忽略掉这个后输入的多余的右括号，直接将光标向右移到一格。
eclipse当中有一个很给力的设定，括号自动匹配后，可以使用tab来跳出括号，这无疑比右手整个移动到方向键区按右方向键来的快多了。目前我没有找到好的插件来实现这个功能，我们可以自定义一个函数来实现
```vim
"设置跳出自动补全的括号
func SkipPair()  
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'  
        return "\<ESC>la"  
    else  
        return "\t"  
    endif  
endfunc  
" 将tab键绑定为跳出括号  
inoremap <TAB> <c-r>=SkipPair()<CR>
```

### 配置自动保存
使用Vundle安装 auto-save插件
```vim
Plug '907th/vim-auto-save'
```
配置自动保存
```vim
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
```

### 配置颜色主题
[onehalf](https://github.com/sonph/onehalf/tree/master/vim)，NeoVim + Tmux with true colors on iTerm2。我最钟情的一个配色主题。使用vundle安装：

```vim
Plug 'sonph/onehalf', {'rtp': 'vim/'}
```
安装后进行颜色主题的配置
```vim
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
" lightline
" let g:lightline.colorscheme='onehalfdark'
```
该插件还支持真彩色（需要系统以及终端的支持），具体配置可以参考[onehalf](https://github.com/sonph/onehalf/tree/master/vim)。


### 打造一个漂亮的状态栏
[vimairline](https://github.com/vim-airline/vim-airline)，使用vundle安装
```vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
```
其中第一个插件为状态栏插件，第二个是状态栏的一些配色主题，在normal模式下可以自由切换状态栏主题配色
```
 :AirlineTheme THEME_NAME
```
所有的主题配色名称你可以在[这里](https://github.com/vim-airline/vim-airline/wiki/Screenshots)找到


### 集成Git
[fugitive](https://vimawesome.com/plugin/fugitive-vim)，使用vundle安装
```vim
Plug 'tpope/vim-fugitive'
```
安装完成后，你可以在normal模式下执行一些Git的命令，如
```
:Git commit
```
同时安装此插件后也会在前面配置的状态栏中看到git的当前分支信息

#### 修改比较
这是个小功能，在侧边栏显示一个修改状态，对比当前文本和 git/svn 仓库里的版本，在侧边栏显示修改情况，以前 Vim 做不到实时显示修改状态，如今推荐使用 vim-signify 来实时显示修改状态，它比 gitgutter 强，除了 git 外还支持 svn/mercurial/cvs 等十多种主流版本管理系统。没注意到它时，你可能觉得它不存在，当你有时真的看上两眼时，你会发现这个功能很贴心。最新版 signify 还有一个命令:SignifyDiff，可以左右分屏对比提交前后记录，比你命令行 svn/git diff 半天直观多了。并且对我这种同时工作在 subversion 和 git 环境下的情况契合的比较好。Signify 和前面的 ALE 都会在侧边栏显示一些标记，默认侧边栏会自动隐藏，有内容才会显示，不喜欢侧边栏时有时无的行为可设置强制显示侧边栏：`set signcolumn=yes` 。
使用vundle安装
```vim
Plug 'mhinz/vim-signify'
```

### 自动补全插件
[YouCompleteMe]()插件支持补全C++、Python等各种语言，vim下最流行的自动补全插件
使用vundle安装
```
Plug 'valloric/youcompleteme'
```
进入`~/.vim/bundle/YouCompleteMe`目录，安装python，c++的补全服务
```
python3 install.py --clangd-completer  # python 的补全服务是默认安装的
```
如果想支持所有语言的补全（c++, java, c#, go等），使用如下命令
```
python3 install --all
```
下面是简单的配置，输入两个字符就自动弹出语义补全，不用等到 . 或者 -> 才触发，同时关闭了预览窗口和代码诊断这些 YCM 花边功能，保持清静，对于原型预览和诊断我们后面有更好的解决方法，YCM这两项功能干扰太大。
```vim
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

```

### 树形文件目录
[nerdtree](https://github.com/preservim/nerdtree)插件可以使vim像ide一样显示树形文件目录结构。
使用vundle安装
```vim
Plug 'preservim/nerdtree'
```
默认情况下，我们需要输入`:NERDTree`来打开文件树，我们可以为此配置一个快捷键 `ctrl + n`
```vim
map <C-n> :NERDTreeToggle<CR> 
```
由于NERDTree开启后独占一个窗口，当我们关闭所有打开的文件时，还会有NEADTree窗口留下，我们可以配置它当所有文件窗口关闭时一起关闭NERDTree窗口
```vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
```
在我们的项目目录下，我们不希望文件树中显示一些二进制文件(如`.pyc`这些生成文件)，我们可以配置忽略掉他们
```
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.git']
```
这里推荐一个很好用的插件 nerdtree-git-plugin，在nerdtree的配合下这个插件能显示 git 管理的项目文件变更状态。
```vim
Plug 'Xuyuanp/nerdtree-git-plugin'
```

### 美化Nerdtree
nerdtree默认显示的事没有感情的剪头，下面我们来介绍如何让nerdtree不同的文件类型显示不同的图标。
首先安装 (vim-devicons)[https://github.com/ryanoasis/vim-devicons]插件
```vim
Plug 'ryanoasis/vim-devicons'
```
除此之外，我们还要安装一种可以显示图标的字体，我们可以参考[nerd font](https://github.com/ryanoasis/nerd-fonts#font-patcher)去安装字体，然后在我们的终端配置相应的字体就可以了。

### 符号索引
在编写或者阅读源代码的时候，我们希望可以跳转到方法、变量或者其他类型的定义处，在许多编辑器如vscode和ide如Pycharm中都有类似的功能。在vim中，我们可以使用[ctags](https://github.com/universal-ctags/ctags)来实现类似的功能。首先我们使用homebrew安装ctags（如果你在使用其他的包管理器，也可以找到对应的安装方法）
```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```
分析当前项目目录下的所有代码符号
```
ctags -R .
```
跳转快捷键（normal模式下）
```
ctrl ]  # 跳转到变量方法或类型的定义处
ctrl t 或 ctrl o # 返回
```

### 自动符号索引
过去写几行代码又需要运行一下 ctags 来生成索引，每次生成耗费不少时间。如今自动异步生成 tags 的工具有很多，这里推荐最好的一个：[vim-gutentags](https://github.com/ludovicchabant/vim-gutentags)，这个插件主要做两件事情：
- 确定文件所属的工程目录，即文件当前路径向上递归查找是否有 .git, .svn, .project 等标志性文件（可以自定义）来确定当前文档所属的工程目录。
- 检测同一个工程下面的文件改动，能会自动增量更新对应工程的 .tags 文件。每次改了几行不用全部重新生成，并且这个增量更新能够保证 .tags 文件的符号排序，方便 Vim 中用二分查找快速搜索符号。

使用vundle安装
```vim
Plug 'ludovicchabant/vim-gutentags'
```

vim-gutentags 需要简单配置一下：
```vim
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
```

### 语法检查
代码检查是个好东西，让你在编辑文字的同时就帮你把潜在错误标注出来，不用等到编译或者运行了才发现。网上很多人推syntastic，这是一个老的语法检查插件，它的一大缺点就是无法进行实时检查。只有当你保存文件才运行检查器，所以请用实时 linting 工具 [ALE](https://github.com/dense-analysis/ale)：
```vim
Plug 'dense-analysis/ale'
```
配置python，我们使用flake8作为语法检查器而不是Pylint，Pylint对于语法的检查过于严格，甚至是有些多余，这个就看个人的需求与喜好了。
```vim
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
```
注：要保证你当前环境中已经安装flake8等语法linter和yapf等fixer。

### 文件快速切换
文件/buffer模糊匹配快速切换的方式，比你打开一个对话框选择文件便捷不少，过去我们常用的 CtrlP 可以光荣下岗了，如今有更多速度更快，匹配更精准以及完美支持后台运行方式的文件模糊匹配工具。我自己用的是上面提到的 LeaderF，除了提供函数列表外，还支持文件，MRU，Buffer名称搜索，完美代替 CtrlP。
LeaderF 是目前匹配效率最高的，高过 CtrlP/Fzf 不少，敲更少的字母就能把文件找出来，同时搜索很迅速，使用 Python 后台线程进行搜索匹配，还有一个 C模块可以加速匹配性能，需要手工编译下。LeaderF在模糊匹配模式下按 TAB 可以切换到匹配结果窗口用光标或者 Vim 搜索命令进一步筛选，这是 CtrlP/Fzf 不具备的，更多方便的功能见它的官方文档。
```vim
Plug 'yggdroot/leaderf'
```
