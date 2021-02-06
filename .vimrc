"" Install plug command list below:
"call plug#begin('~/.vim/plugged')
"Plug 'brookhong/cscope.vim'
"Plug 'qrsforever/lookupfile'
"Plug 'vim-scripts/taglist.vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'clones/vim-genutils'
"Plug 'vim-scripts/winmanager'
"call plug#end()

"""""""""""""""""""""""vim setting""""""""""""""""
set nu
set hlsearch
set incsearch
set tabstop=4
set shiftwidth=4
set smartindent
set noswapfile
set expandtab
set nocompatible
set backspace=indent,eol,start

syntax on

source ~/.vim/plugin/minibufexpl.vim

"""""""""""""taglist setting"""""""""""""
set tags=tags;/
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"let Tlist_Show_Menu=1
"let Tlist_Auto_Open=1

""""""""""""winmanager setting"""""""""""
let g:winManagerWindowLayout='TagList'
"let g:winManagerWindowLayout='FileExplorer|TagList'
"let g:winManagerWindowLayout="TagList|FileExplorer"
let g:winManagerWidth=30
nmap <silent> <F8> :WMToggle<cr>

"""""""""""""""""""""""cscope set""""""""""""""""""      
if filereadable("cscope/load.vim")
    source ./cscope/load.vim
endif

" s: Find this C symbol
nmap fs :cs find s <C-R>=expand("<cword>")<CR><cr>
" g: Find this definition
nmap fg :cs find g <C-R>=expand("<cword>")<CR><cr>
" c: Find functions calling this function
nmap fc :cs find c <C-R>=expand("<cword>")<CR><cr>
" t: Find this text string
nmap ft :cs find t <C-R>=expand("<cword>")<CR><cr>
" e: Find this egrep pattern 
nmap fe :cs find e <C-R>=expand("<cword>")<CR><cr>
" f: Find this file
nmap ff :cs find f <C-R>=expand("<cfile>")<CR><cr>
" i: Find files #including this file
nmap fi :cs find i <C-R>=expand("<cfile>")<CR><cr>
" d: Find functions called by this function
nmap fd :cs find d <C-R>=expand("<cword>")<CR><cr>

