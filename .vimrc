set nocompatible              " required
filetype off                  " required
" allow to change buffers without saving
set hidden

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Vundle Plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" Plugin 'scrooloose/nerdtree' " Awesome file explorer
" let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive' " All git commands with 'Git X'
Plugin 'arcticicestudio/nord-vim'
Plugin 'tomasiser/vim-code-dark' " Good color scheme
Plugin 'nvie/vim-flake8'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'tell-k/vim-autopep8'
Plugin 'mhinz/vim-startify' " Startup screen on main buffer when no file is opened
Plugin 'tomtom/quickfixsigns_vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'prabirshrestha/vim-lsp' " Language server protocol
Plugin 'mattn/vim-lsp-settings' " Easy setup for most common languages
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'tpope/vim-sleuth' " auto detect indentation from file
Plugin 'jeetsukumaran/vim-buffergator' " (dynamic buffer list)
Plugin 'tpope/vim-surround' " to change surrounding characters (parenthesis, quotes)
Plugin 'mileszs/ack.vim' " To use ack or ag
Plugin 'itchyny/lightline.vim' " Like powerline but lighter
" FZF, commands using FZF such as file search
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'vim-scripts/taglist.vim' " Add command Tlist to get a side window with class definitions etc, to jump in code

"  Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Bundle 'Valloric/YouCompleteMe'

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

"let g:ycm_autoclose_preview_window_after_completion=1 " quit auto complete window after it is done
" goto def shortcut
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> 

let python_highlight_all=1
syntax on

"colorscheme zenburn
colorscheme codedark

" Highlight current line
set cursorline

"change color of Selected tab
hi TabLineSel ctermfg=Black ctermbg=Yellow


"NOT WORKING switch dark/light theme with solarized with F5
"call togglebg#map("<F5>")

:let mapleader=","

" Nerd tree shortcuts
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" save with control s
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a

" auto run flake 8 when opening py file
"autocmd BufWritePost *.py call flake8#Flake8()
"set laststatus=2

" powerline
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

" powerline
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
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

" find class using grep
func! Findclass()
	exe "tab split"
	" exe "NERDTreeTabsOpen"
	let classname = expand("<cword>")
	let str = "\"class " . classname . "(\"" 
	exe "grep -rn . -e " . str
endfunc
nnoremap <leader>fc :call Findclass()<CR> 

" find method using grep
func! Findmethod()
	exe "tab split"
	let classname = expand("<cword>")
	let str = "\"def " . classname . "(\"" 
	exe "grep -rn . -e " . str
endfunc
nnoremap <leader>fm :call Findmethod()<CR>

" open all files modified since master branch
func! GitModified()
	let commit_master = system("git rev-list -n 1 master")
	let modified_files = system("git diff --name-only HEAD " . commit_master)
	for file in split(modified_files, "\n")
		exe "e " . file
	endfor
endfunc

" use F1 to toggle Tlist
nnoremap <F1> :Tlist <CR> :wincmd h <CR> :vertical resize +30 <CR>

" use leader d to open new empty tab
noremap <leader>d :tabnew<CR>

" display invisible characters
set list listchars=tab:»\ ,trail:·,nbsp:⚠,precedes:<,extends:>
" set list listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>

" change GitGutter colours
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" navigation between buffers
nnoremap <C-S-Left> :bprev<CR>
nnoremap <C-S-Right> :bnext<CR>

let g:lsp_settings = {
\   'pylsp-all': {
\     'workspace_config': {
\       'pylsp': {
\         'configurationSources': ['flake8']
\       }
\     }
\   },
\}

" Buffergator settings
let g:buffergator_viewport_split_policy = "B" " horizontal bottom
let g:buffergator_autoupdate = 1 " auto update when buffer list changes
let g:buffergator_show_full_directory_path = 0 " show only relative path of buffer file
let g:buffergator_hsplit_size = 10 " buffer split size on creation

" open nerdtree before startify or else startify won't show up
function Windowsetup()
	if !argc()
		exe "Startify"
	endif
	exe "BuffergatorOpen"
	exe "wincmd w"
endfunction
autocmd VimEnter * call Windowsetup()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Remap control arrow to movements
map <ESC>[1;5A <PageUp>
map <ESC>[1;5C <C-Right>
map <ESC>[1;5B <PageDown>
map <ESC>[1;5D <C-Left>
" needed for edit mode
map! <ESC>[1;5A <PageUp>
map! <ESC>[1;5C <C-Right>
map! <ESC>[1;5B <PageDown>
map! <ESC>[1;5D <C-Left>

" Remap F to fzf cmd Files
nmap F :Files <CR>
nmap D :Ag <CR>

" Remove -- INSERT -- because  Lightline already has an 'INSERT' status bar
set noshowmode
