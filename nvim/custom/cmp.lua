local cmp = require'cmp'
local luasnip = require 'luasnip'


cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          print("visible")
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          print("notvisible")
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        print("visible")
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          print("notvisible")
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
        print("cp")
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
      return vim_item
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'treesitter' },
    { name = "supermaven" },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  event = {
    on_confirm_done = function()
      print("CONFIRM DONE")
      vim.defer_fn(function()
        lsp.buf.code_action()
      end, 100)  -- Adjust the delay if necessary
    end,
  }
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').vtsls.setup {
  capabilities = capabilities
}

vim.lsp.set_log_level("debug")
