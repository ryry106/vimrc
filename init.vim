"tmp -------------------------
"set verbosefile=~/vim.log

"basic -------------------------
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

"search -------------------------
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

"indent -------------------------
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2

"map/command -------------------------
nnoremap j gj
nnoremap k gk
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <C-q> :bd<CR>

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>

"other -------------------------
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set virtualedit=onemore
let mapleader = "\<Space>"
let g:python3_host_prog='/usr/bin/python3'
"https://qiita.com/delphinus/items/a202d0724a388f6cdbc3
set termguicolors
set pumblend=10
"grep to quickfixwindow
autocmd QuickFixCmdPost *grep* cwindow
"terminal
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
autocmd TermOpen * startinsert
"load lua file from ~/.config/nvim/lua
lua require('snippets')
lua require('go-test')
lua require('todo')
lua require('denops-dev')



"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = '~/.cache/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml = '~/.config/nvim/'

    call dein#load_toml(s:toml . 'dein.toml', {'lazy': 0})
    call dein#load_toml(s:toml . 'dein-ddc.toml', {'lazy': 0})
    call dein#load_toml(s:toml . 'dein-lsp.toml', {'lazy': 0})
"    call dein#load_toml(s:toml . 'dein-dap.toml', {'lazy' : 1})

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
