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

" lowering the update time for some faster gutters
set updatetime=100

set title
set titlestring=%{expand('%')}

" don't move my cheese
unmap Y

" VUNDLE STUFF
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.config/nvim/plugged')

let @l=':lua jl_comment()'
let @p=':w ! black %'
"
" SnakeCase Convert To camelCase
let @k=':%s/_\(\w\)/\u\1/g'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" VimAirline stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'godlygeek/Tabular'
"Plug 'kien/ctrlp.vim'

Plug 'iCyMind/NeoSolarized'


" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/L9'

" Git plugin not hosted on GitHub
Plug 'git://git.wincent.com/command-t.git'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'f-person/git-blame.nvim'

call plug#end()

syntax on

let g:ackprg = 'rg --vimgrep --no-heading'

" Airline Config
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

let g:airline_theme= 'solarized'
let g:airline#extensions#tabline#enabled = 0

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let airline#extensions#languageclient#error_symbol = '!'
let airline#extensions#nvimlsp#error_symbol = '!'

let g:prettier#autoformat_config_files = ['.prettierrc.json']
let g:gitblame_enabled = 0
let g:CommandTPreferredImplementation='lua'

" Commenting
:map <D-/> <leader>c<space>

" Enter normal mode in terminal with Esc
:tnoremap <Esc> <C-\><C-n>

" bd but keep the split
nnoremap <leader>d :b#<bar>bd#<CR>

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
colorscheme NeoSolarized


"highlight FoldColumn  gui=bold    guifg=grey65     guibg=Grey90
highlight Folded      gui=italic
"highlight LineNr      gui=NONE    guifg=grey60     guibg=Grey90

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
set undodir=$HOME/.config/nvim/tmp
set dir=$HOME/.config/nvim/tmp/swap
set termguicolors
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif

" set up language servers
lua << EOF
local lspconfig = require'lspconfig'

vim.o.completeopt = "menu,menuone,noselect"

-- Jedi
-- require'lspconfig'.jedi_language_server.setup{}

require'lspconfig'.pyright.setup{}


-- Compe setup
local cmp = require'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
   ['<C-n>'] = cmp.mapping({
          c = function()
              if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                  vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
              end
          end,
          i = function(fallback)
              if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                  fallback()
              end
          end
      }),
   ['<C-p>'] = cmp.mapping({
          c = function()
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                  vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
              end
          end,
          i = function(fallback)
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                  fallback()
              end
          end
      }),
  },
  formatting = {
    format = function(entry, vim_item)
      --  vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kindvim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
      return vim_item
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'treesitter' }
  }
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- ts lsp
require'lspconfig'.tsserver.setup{}

-- require("lsp_lines").setup()

vim.diagnostic.config({
  virtual_text = true,
})

require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["console.log"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    config = {
       javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
       typescript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      }
    }
  }
}

telescope = require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {"stormfront/public/*"},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

find_files_no_test = function()
  require('telescope.builtin').find_files({
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob', '!**tests**',
    },
  })
end

find_text_no_test = function()
  require('telescope.builtin').live_grep({
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob', '!**/tests/**',
    },
  })
end

jl_comment = function()
  -- Get current filetype
  local filetype = vim.bo.filetype

  -- Get the full word or expression under the cursor
  local word = vim.fn.expand('<cword>')
  local line = vim.fn.getline('.')
  local cursor_pos = vim.fn.col('.')
  -- Patterns to match the full word or expression
  local left_part = line:sub(1, cursor_pos):match("[_%w%.]+$")
  local right_part = line:sub(cursor_pos + 1):match("^[_%w%.]*")

  -- Combine both parts to get the full word/expression
  local full_word = left_part .. right_part

  -- Get the current line's indentation
  local indent = vim.fn.indent('.')
  local indent_str = string.rep(" ", indent)

  -- Prepare the debug statement based on filetype
  local debug_statement = ""
  if filetype == "python" then
    debug_statement = indent_str .. "print(f'".. full_word .. " is {".. full_word.. "}')"
  elseif filetype == "typescript" or filetype == "javascript" or filetype == "typescriptreact" then
    debug_statement = indent_str .. "console.log('".. full_word .. " is', ".. full_word.. ");"
  end

  -- Insert the debug statement below the current line
  vim.api.nvim_put({debug_statement}, 'l', true, true)
end

local selected_text = (function()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})
    text = string.gsub(text, "\n", "")
    if string.len(text) == 0 then
        text = nil
    end
    return text
  end
)()

vim.opt.termguicolors = true

vim.api.nvim_set_keymap('n', '<leader>ffnt', ":lua find_files_no_test()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ftnt', ":lua find_text_no_test()<CR>", { noremap = true, silent = true })

EOF

nnoremap ( <cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>")})<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader><C-p>
nnoremap <leader>a <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>? <cmd>lua vim.diagnostic.open_float()<cr>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>bl <cmd>GitBlameToggle<cr>

" imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true



"vim.cmd [[highlight IndentBlanklineIndent1 guibg=#002b36 blend=nocombine]]
"vim.cmd [[highlight IndentBlanklineIndent2 guibg=#073642 blend=nocombine]]
"require("indent_blankline").setup {
  "char = " ",
  "space_char_blankline = "",
  "char_highlight_list = {
    ""IndentBlanklineIndent1",
    ""IndentBlanklineIndent2",
  "},
  "space_char_highlight_list = {
    ""IndentBlanklineIndent1",
    ""IndentBlanklineIndent2",
  "},
  "show_trailing_blankline_indent = false,
  "buftype_exclude = {"terminal"},
  "show_current_context = true,
"}

