" ============================================================================
" General Settings
" ============================================================================
set shiftwidth=2
set expandtab
set relativenumber
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set colorcolumn=80
set clipboard=unnamedplus
set autoindent
set smartindent
set cindent
set autoread
set shell=/bin/bash
set mouse=nicr
set path+=**
set wildmenu
set updatetime=100
set title
set titlestring=%{expand('%')}
set termguicolors

let mapleader = ","
nnoremap Y yy

" ============================================================================
" Autocommands
" ============================================================================
autocmd BufWritePre * :%s/\s\+$//e           " Drop trailing whitespace on save
autocmd FocusGained,BufEnter * :silent! !     " Auto-reload buffer on focus gain
autocmd FocusLost,WinLeave * :silent! noautocmd w " Auto save on focus lost

" ============================================================================
" Plugin Management
" ============================================================================
lua require('plugins')

nnoremap <leader>d :let bnr=bufnr('#')<CR>:if bnr != -1 && buflisted(bnr)<CR>:b#<bar>bd<CR>:else<CR>:enew<bar>bd#<CR>:endif<CR>


" ============================================================================
" Key Mappings
" ============================================================================
lua require('custom.mappings')

" ============================================================================
" Language Server Configuration
" ============================================================================
lua require('custom.lspconfig')
lua require('custom.treesitter')
lua require('custom.cmp')
lua require('custom.comment')
lua require('custom.supermaven')
lua require('custom.telescope')
lua require('custom.codecompanion')

" ============================================================================
" Additional Configurations and Custom Functions
" ============================================================================
lua require('custom.functions')

" ============================================================================
" Airline Configuration
" ============================================================================
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let airline#extensions#languageclient#error_symbol = '!'
let airline#extensions#nvimlsp#error_symbol = '!'

" ============================================================================
" Colorscheme
" ============================================================================
colorscheme NeoSolarized

" ============================================================================
" Miscellaneous Settings
" ============================================================================
set undodir=$HOME/.config/nvim/tmp
set directory=$HOME/.config/nvim/tmp/swap
if !isdirectory(&directory)
    call mkdir(&directory, 'p', 0700)
endif

" Load helptags after all plugins are loaded
silent! helptags ALL
