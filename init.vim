syntax on
"set shiftwidth=4 // Normal
set shiftwidth=2 "EatClub!
set expandtab
set relativenumber
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let mapleader = ","
set colorcolumn=80
set cb=unnamedplus
set autoindent
set autoread
set shell=/bin/bash

" Drop all Trailing Whitespace
autocmd BufWritePre * :%s/\s\+$//e


" Auto reload in buffer when nvim gains focus again
au FocusGained,BufEnter * :silent! !

" auto save when you leave a buffer but don't worry about linting
au FocusLost,WinLeave * :silent! noautocmd w


:set mouse=nicr

set path+=**
set wildmenu

" VUNDLE STUFF
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.config/nvim/plugged')

" VimAirline stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
Plug 'python-mode/python-mode'

" Syntastic stuff
"#Plug 'scrooloose/syntastic'
"#Plug 'mtscout6/syntastic-local-eslint.vim'

Plug 'w0rp/ale'

Plug 'godlygeek/Tabular'
Plug 'kien/ctrlp.vim'

Plug 'airblade/vim-gitgutter'

Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'Shougo/neocomplcache'
Plug 'craigemery/vim-autotag'
"Plug 'nixprime/cpsm'

Plug 'mileszs/ack.vim'

Plug 'shougo/deoplete.nvim'

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/L9'
" Git plugin not hosted on GitHub
Plug 'git://git.wincent.com/command-t.git'
Plug 'scrooloose/nerdcommenter'
call plug#end()


"Use deoplete.
let g:deoplete#enable_at_startup = 1

nnoremap <Leader>a :Ack<space>
let g:ackprg = 'rg --vimgrep --no-heading'

" Airline Config
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

let g:airline_theme= 'solarized'
"let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#enabled = 0

let g:airline#extensions#ale#enabled = 1

"let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

"let g:airline_section_z = ['line number']

" I like Mac style saves
:map <M-s> :w<kEnter>  "Works in normal mode, must press Esc first"
:imap <M-s> <Esc>:w<kEnter>i "Works in insert mode, saves and puts back in insert mode"

nnoremap ( :Ack <cword><cr>




" CTRLP Stuff
set wildignore+=**/installer
set wildignore+=**/node_modules
nmap <silent> <Leader>fr :CtrlPMixed<CR>
nnoremap <silent> <leader>C :ClearCtrlPCache<cr>\|:CtrlP<cr>

" use RipGrep for searching
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0

" Commenting
":map <D-/> <leader>c<space>

" Enter normal mode in terminal with Esc
:tnoremap <Esc> <C-\><C-n>


"set statusline+=%#warningmsg#
"set statusline+=%*
"
"set statusline+=%{SyntasticStatuslineFlag()}
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_loc_list_height = 5
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
"let g:syntastic_javascript_checkers = ['eslint']
"
"
"let g:syntastic_error_symbol = '❌'
"let g:syntastic_style_error_symbol = '⁉️'
"let g:syntastic_warning_symbol = '⚠️'
"let g:syntastic_style_warning_symbol = '💩'
"
"highlight link SyntasticErrorSign SignColumn
"highlight link SyntasticWarningSign SignColumn
"highlight link SyntasticStyleErrorSign SignColumn
"highlight link SyntasticStyleWarningSign SignColumn
"

"let g:python_host_prog="/Users/johnlouisswaine/.virtualenvs/neovim/bin/python"
let python_highlight_all = 1

"let g:pymode = 1


"let g:pymode_folding = 1
"let g:pymode_quickfix_minheight = 3
"let g:pymode_quickfix_maxheight = 6
"let g:pymode_virtualenv = 1
"let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_bind = '<leader>b'

"let g:pymode_rope = 1
"let g:pymode_rope_completion = 1
"let g:pymode_rope_lookup_project = 0
"let g:pymode_rope_complete_on_dot = 1
"let g:pymode_rope_completion_bind = '<C-Space>'
"let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime']
"let g:pymode_rope_goto_definition_bind = '<leader>g'
"let g:pymode_rope_goto_definition_cmd = 'new'

let g:ale_enabled = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'


let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PlugList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugSearch foo - searches for foo; append `!` to refresh local cache
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plug stuff after this line
set termguicolors
colorscheme solarized

"highlight FoldColumn  gui=bold    guifg=grey65     guibg=Grey90
highlight Folded      gui=italic
"highlight LineNr      gui=NONE    guifg=grey60     guibg=Grey90

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
set undodir=$HOME/.config/nvim/tmp
set dir=$HOME/.config/nvim/tmp/swap
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif
