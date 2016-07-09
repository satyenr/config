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
let mapleader='\'

" ==========================================
" Plugins
" ==========================================
set runtimepath+=~/.local/share/nvim
call plug#begin('~/.local/share/nvim/plugins')
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'morhetz/gruvbox'
call plug#end()

" ==========================================
" Appearance and Behaviour
" ==========================================
" Automatically detect file types
filetype plugin indent on
" Turn on syntax highlighting
syntax on

" Show line numbers
set number
" Show (partial) command in the last line of the screen
set showcmd
" Show line and column number in bottom right hand corner
set ruler

" Show non-printables correctly using 'set list'
set listchars=trail:-,tab:>-,eol:$

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
autocmd FileType yaml set softtabstop=2 shiftwidth=2

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

" ==========================================
" Miscellaneous
" ==========================================
" Arrow Key Fix (https://github.com/spf13/spf13-vim/issues/780)
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif

" Command to view the changes made to the current buffer
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

