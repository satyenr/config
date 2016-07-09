" vim: set sw=4 ts=4 sts=4 et tw=78

" ==========================================
" Function Definitions
" ==========================================
" Identify Platform
silent function! MacOS()
    return has('macunix')
endfunction

silent function! Linux()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

silent function! Windows()
    return  (has('win32') || has('win64'))
endfunction

silent function! NeoVim()
    return has('nvim')
endfunction

" ==========================================
" Essentials
" ==========================================
let mapleader="<space>"

" ==========================================
" Plugins
" ==========================================
set runtimepath+=~/.local/share/nvim
call plug#begin('~/.local/share/nvim/plugins')
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'morhetz/gruvbox'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
call plug#end()

" ==========================================
" Appearance and Behaviour
" ==========================================
" Automatically detect file types
filetype plugin indent on
" Turn on syntax highlighting
syntax on

" Use UTF-8 by default
set encoding=utf-8
" Show line numbers
set number
" Show (partial) command in the last line of the screen
set showcmd
" Show line and column number in bottom right hand corner
set ruler

" Use universal clipboard
set clipboard=unnamed

" Show non-printables correctly using 'set list'
set listchars=trail:-,tab:>-,eol:$

" Autocomplete settings
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\~$']

" Highlight trailing whitespaces - except while typing at the end of the line
" Details can be found at http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Jump to the last known cursor position - except when the position is invalid
" or when inside an event handler (happens when dropping a file on gvim), or
" when the mark is in the first line - that is the default starting position.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Use gruvbox theme
" colorscheme gruvbox
" Enable rainbow brackets
let g:rainbow_active=1

" ==========================================
" Indentation Settings
" ==========================================
" Copy indent from current line when starting a new line
set autoindent
" Indent/unindent after open/close braces
set smartindent
" Number of columns a tab counts. Affects how existing text is displayed
set tabstop=4
" Number of columns text is indented with the reindent operations
set shiftwidth=4
" Number of columns to use when Tab is pressed in insert mode
set softtabstop=4
" Replace tabs by spaces
set expandtab
" Round indent to multiple of 'shiftwidth'
set shiftround
" Don't indent to the left when pressing the # key
set indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except,0#
" Always use tab character for Makefiles and Go
autocmd FileType make set noet ts=8
autocmd FileType go set noet ts=4
" For YAML files, let a tab mean 2 spaces
autocmd FileType yaml js html css set ts=2 sts=2 sw=2

" ==========================================
" Search
" ==========================================
" Case-insensitive search by default
set ignorecase
" Unless at least 1 letter is capitalized
set smartcase
" Highligh search results by default
set hlsearch
" Highlight search as you type
set incsearch

" ==========================================
" Key Bindings
" ==========================================
" Toggle background between light and dark
map <F2> :let &background = (&background == 'dark' ? 'light' : 'dark') <CR>
" Toggle line number display
map <F3> :set number! <CR>
" Toggle paste mode
set pastetoggle=<F5>
" Split pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ==========================================
" Python
" ==========================================
" Code folding
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<<Paste>
let g:SimpylFold_docstring_preview=1
" PEP-8
autocmd FileType python set ts=4 sts=4 sw=4 tw=79 et ai ff=unix
" Prettify Python code
let python_highlight_all=1
syntax on

" VirtualEnv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" ==========================================
" Miscellaneous
" ==========================================
" Arrow Key Fix (https://github.com/spf13/spf13-vim/issues/780)
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif

" Command to view the changes made to the current buffer
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

