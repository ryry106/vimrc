"tmp -------------------------
"vimrcデバッグ用
set verbosefile=~/vim.log
"ubuntu
let $VIMRUNTIME="/usr/share/nvim/runtime"
set runtimepath+=/usr/share/nvim/runtime

"基本的な設定 -------------------------
set fenc=utf-8
set fileformats=unix
set nobackup
set noswapfile
set noundofile
set hidden
set showcmd
set clipboard=unnamedplus
set wildmode=list:longest
set number
set cursorline
set laststatus=2
set showmatch
set visualbell

"検索 -------------------------
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

"インデント -------------------------
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2

"map/command -------------------------
"折り返し行を移動しやすく
nnoremap j gj
nnoremap k gk
command Cheat new ~/.config/nvim/CHEAT.md
"vimrc操作
command Rc new $MYVIMRC
command Tom new ~/.config/nvim/dein.toml
command Toml new ~/.config/nvim/dein_lazy.toml
command Rcr source $MYVIMRC
"このファイルを実行
command Py !python3 %
command Node !node %
command Gom !go run main.go
command Go !go run .
command Got !go test -v %
"括弧補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>

"その他 -------------------------
"改行コード、不可視文字を可視化
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
"行末 + 1まで移動
set virtualedit=onemore
"<Leader>割り当て
let mapleader = "\<Space>"
let g:python3_host_prog='/usr/bin/python3'



"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = '~/.cache/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml = '~/.config/nvim/dein.toml'
    let s:lazy_toml = '~/.config/nvim/dein_lazy.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy' : 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif

filetype plugin indent on
syntax enable

