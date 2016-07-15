" vim: set sw=4 ts=4 sts=4 et:

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
let mapleader=' '

" ==========================================
" Vim Compatibility
" ==========================================
if !NeoVim()
    " Use vim settings, not vi ones
    " Must be first - changes other options
    set nocompatible

    " Avoid polluting home directory with dotfiles
    " Create required directories
    silent !mkdir -p ~/.local/share/vim > /dev/null 2>&1
    silent !mkdir -p ~/.cache/vim > /dev/null 2>&1
    " Store viminfo in cache directory
    set viminfo+=n~/.cache/vim/viminfo
    " Store netrwhist in cache directory
    let g:netrw_home=expand('~/.cache/vim')

    " Keep backup only while file is being written
    set nobackup writebackup
    " Stop the annoying beep
    set visualbell t_vb=

endif

" ==========================================
" Plugins
" ==========================================
set runtimepath+=~/.local/share/nvim
call plug#begin('~/.local/share/nvim/plugins')
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'

" Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'

" Not working - to be investigated later
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plug 'Valloric/YouCompleteMe'
call plug#end()

" ==========================================
" Appearance and Behaviour
" ==========================================
filetype plugin indent on   " Automatically detect file types
syntax on                   " Turn on syntax highlighting
set encoding=utf-8          " Use UTF-8 by default
set number                  " Show line numbers
set showcmd                 " Show (partial) command in the last line of the screen
set ruler                   " Show line and column number in bottom right hand corner
set clipboard=unnamed       " Use universal clipboard
set cursorline              " Show curser line
set modeline                " Respect modeline
set scrolloff=4             " Always leave 4 lines above and below screen top/bottom
set listchars=trail:-,tab:>-,eol:$
                            " Show non-printables correctly using 'set list'
let g:rainbow_active=1      " Enable rainbow brackets

" Autocomplete settings
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\~$']

" Highlight trailing whitespaces - except while typing at the end of the line
" Details can be found at http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Does not work when any colorscheme is active. Need to find a workaround. The
" one given at the link mentioned above link doesn't work.
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Jump to the last known cursor position - except when the position is invalid
" or when inside an event handler (happens when dropping a file on gvim), or
" when the mark is in the first line - that is the default starting position.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" ==========================================
" Indentation Settings
" ==========================================
set autoindent      " Copy indent from current line when starting a new line
set smartindent     " Indent/unindent after open/close braces
set tabstop=4       " Number of columns a tab counts - affects how existing text is displayed
set shiftwidth=4    " Number of columns text is indented with the reindent operations
set softtabstop=4   " Number of columns to use when Tab is pressed in insert mode
set expandtab       " Replace tabs by spaces
set shiftround      " Round indent to multiple of 'shiftwidth'
set indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except,0#
                    " Don't indent to the left when pressing the # key

" Always use tab character for Makefiles and Go
autocmd FileType make set noet ts=8
autocmd FileType go set noet ts=4

" For YAML files, let a tab mean 2 spaces
autocmd FileType yaml js html css set ts=2 sts=2 sw=2

" ==========================================
" Search
" ==========================================
set ignorecase      " Case-insensitive search by default
set smartcase       " Unless at least 1 letter is capitalized
set hlsearch        " Highligh search results by default
set incsearch       " Highlight search as you type

" ==========================================
" Key Bindings
" ==========================================
" Toggle background between light and dark
map <F2> :let &background = (&background == 'dark' ? 'light' : 'dark') <CR>
" Toggle line number display
map <F3> :set number! <CR>
" Toggle NerdTree pane
nmap <F4> :NERDTreeToggle <CR>
" Toggle paste mode
set pastetoggle=<F5>
" Toggle :set list
map <F6> :set list! <CR>

" Split pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Emacs binding for begin and end
nnoremap <C-a> <home>
nnoremap <C-e> <end>

" Switch to shell
nmap <C-d> :term <CR>

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Turn off highlighting
map <silent> \ :let @/="" <CR>

" Use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next <CR>
nnoremap <C-P> :prev <CR>

" Suppress all spaces at end/beginning of lines
nmap _s :%s/\s\+$//<CR>
nmap _S :%s/^\s\+//<CR>


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
if has('python')
    py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" ==========================================
" Miscellaneous
" ==========================================
" Arrow Key Fix (https://github.com/spf13/spf13-vim/issues/780)
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif

" Command to view the changes made to the current buffer
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

