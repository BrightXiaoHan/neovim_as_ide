# Neovim As IDE
从零开始讲neovim打造成Python，C++开发利器。

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

### 插件管理器Vundle
克隆Vundle到~/.vim/bundle/Vundle.vim
```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
在你的.config/nvim/init.vim中添加如下内容，内容中的Plugin示范了所有可接受的格式，如果不需要可以将他们移除。以下内容放在配置文件的最前面。
```vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```
打开nvim，在普通模式下输入```:PluginInstall```安装所有插件。也可以再命令行下执行```vim +PluginInstall +qall```

### 配置自动保存
使用Vundle安装 auto-save插件
```vim
Plugin '907th/vim-auto-save'
```
配置自动保存
```vim
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
```

### 配置颜色主题
[onehalf](https://github.com/sonph/onehalf/tree/master/vim)，NeoVim + Tmux with true colors on iTerm2。我最钟情的一个配色主题。使用vundle安装：

```vim
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
```
其中第一个插件为状态栏插件，第二个是状态栏的一些配色主题，在normal模式下可以自由切换状态栏主题配色
```
 :AirlineTheme THEME_NAME
```
所有的主题配色名称你可以在[这里](https://github.com/vim-airline/vim-airline/wiki/Screenshots)找到


### 集成Git
[fugitive](https://vimawesome.com/plugin/fugitive-vim)，使用vundle安装
```vim
Plugin 'tpope/vim-fugitive'
```
安装完成后，你可以在normal模式下执行一些Git的命令，如
```
:Git commit
```
同时安装此插件后也会在前面配置的状态栏中看到git的当前分支信息

### 自动补全插件
[YouCompleteMe]()插件支持补全C++、Python等各种语言，vim下最流行的自动补全插件
使用vundle安装
```
Plugin 'valloric/youcompleteme'
```
进入`~/.vim/bundle/YouCompleteMe`目录，安装python，c++的补全服务
```
python3 install.py --clangd-completer  # python 的补全服务是默认安装的
```
如果想支持所有语言的补全（c++, java, c#, go等），使用如下命令
```
python3 install --all
```

Preview windwo 默认是出现在窗口的上方的，这会导致我们输入代码时闪来闪去去的，这是因为vim默认的新分割窗口出现在上方，我们将它配置到窗口下方出现
```vim
set splitbelow
```
