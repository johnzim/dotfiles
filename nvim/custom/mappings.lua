local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader>ffnt', ":lua find_files_no_test()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ftnt', ":lua find_text_no_test()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bl', "<cmd>GitBlameToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '(', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':lua DeleteBufferAndKeepSplit()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', "<cmd>%delete_ | put + | 1delete_<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fl', ':lua AddNextFlag()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_var('@l', ':lua jl_comment()<CR>')
vim.api.nvim_set_var('@k', ':%s/_\\(\\w\\)/\\u\\1/g<CR>')
vim.api.nvim_set_keymap('n', '<leader>fo', ':Format<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>CodeCompanionToggle<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', { noremap = true, silent = true })

-- Just doing :so init.vim doesn't reload all the LUA stuff so this function is mapped
vim.api.nvim_create_user_command('ReloadConfig', 'lua ReloadConfig()', {})

vim.cmd([[cab cc CodeCompanion]])
