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
let mapleader = '\'

" ==========================================
" Plugins
" ==========================================
set runtimepath+=~/.local/share/nvim
call plug#begin('~/.local/share/nvim/plugins')
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
call plug#end()

" ==========================================
" Appearance and Behaviour
" ==========================================
" Show (partial) command in the last line of the screen
set showcmd
" Show line and column number in bottom right hand corner
set ruler
" Automatically detect file types
filetype plugin indent on
" Turn on syntax highlighting
syntax on
" Show line numbers
set number

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


