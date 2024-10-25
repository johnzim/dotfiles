local lspconfig = require'lspconfig'
local conform = require'conform'

-- Python
lspconfig.pyright.setup{}

lspconfig.vtsls.setup{}


-- Conform setup
conform.setup({
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    javascript = { "prettier", stop_after_first = true },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    json = { "prettier", stop_after_first = true },
  },
})

-- formatters_by_ft = {
--     lua = { "stylua" },
--     python = { "black", "isort" },
--     javascript = { "prettierd", "eslint" },
--     typescript = { "prettierd", "eslint" },
--     typescriptreact = { "prettierd", "eslint" },
--     javascriptreact = { "prettierd", "eslint" },
-- },

vim.api.nvim_create_user_command('PrintTsServerStatus', function()
  local active_clients = vim.lsp.get_active_clients()
  local tsserver_client = nil
  for _, client in ipairs(active_clients) do
    if client.name == "tsserver" then
      tsserver_client = client
      break
    end
  end

  if tsserver_client then
    print("TSServer is active:")
    print("  Root directory: " .. tsserver_client.config.root_dir)
    print("  Capabilities: ")
    print(vim.inspect(tsserver_client.server_capabilities))
  else
    print("TSServer is not active in any buffer")
  end
end, {})
