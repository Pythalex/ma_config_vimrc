set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
"  Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'arcticicestudio/nord-vim'
Plugin 'tomasiser/vim-code-dark'
Bundle 'Valloric/YouCompleteMe'
Plugin 'nvie/vim-flake8'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'tell-k/vim-autopep8'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhinz/vim-startify'

Plugin 'airblade/vim-gitgutter'
set updatetime=1000

" All of your Plugins must be added before the following line
call vundle#end()            " required

" enable number line
set nu

filetype plugin indent on    " required

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" pep8 indentation
" au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix

" highlight bad whitespaces
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" default utf 8
set encoding=utf-8

let g:ycm_autoclose_preview_window_after_completion=1 " quit auto complete window after it is done
" goto def shortcut
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> 

let python_highlight_all=1
syntax on

"colorscheme zenburn
colorscheme codedark

"change color of Selected tab
hi TabLineSel ctermfg=Black ctermbg=Yellow


"NOT WORKING switch dark/light theme with solarized with F5
"call togglebg#map("<F5>")

:let mapleader=","

" Nerd tree shortcuts
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" save with control s
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a

" auto run flake 8 when opening py file
autocmd BufWritePost *.py call flake8#Flake8()
set laststatus=2

" powerline
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

" powerline
"set  rtp+=$HOME/.local/lib/python3.9/site-packages/powerline/bindings/vim/
"set laststatus=2
"set t_Co=256

" delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

	" delete when saving python file
autocmd BufWrite *.py :call DeleteTrailingWS()
	" delete when using leader (,) + w
noremap <leader>w :call DeleteTrailingWS()<CR>

" allow bash aliases
set shellcmdflag=-ic

" find class and open file using grep
" TODO: make it work
func! Findclass()
	exe "tab split"
	exe "NERDTreeTabsOpen"
	let classname = expand("<cword>")
	let str = "\"class " . classname . "(\"" 
	exe "grep -rn . -e " . str
endfunc
nnoremap <leader>fc :call Findclass()<CR> 

" open nerdtree before startify or else startify won't show up
autocmd VimEnter *
	\   if !argc()
	\ |   Startify
	\ |   NERDTree
	\ |   wincmd w
	\ |   wincmd w
	\ |   wincmd q
	\ | endif

" use F1 to list all functions in file
noremap <F1> :g/def\ .*<CR>
" use F2 to list all classes in file
noremap <F2> :g/class\ .*<CR>

" use F3 to toggle nerdtree on and off
noremap <F3> :NERDTreeToggle<CR>

" display invisible characters
set list listchars=tab:»\ ,trail:·,nbsp:⚠,precedes:<,extends:>
" set list listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>

" change GitGutter colours
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
