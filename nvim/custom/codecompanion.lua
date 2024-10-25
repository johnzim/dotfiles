local codecompanion = require('codecompanion')

codecompanion.setup({
    strategies = {
    chat = {
      adapter = "anthropic",
      keymaps = {
        codeblock = {
          modes = {
            n = "gl",
          },
          index = 6,
          callback = "keymaps.codeblock",
          description = "Insert Codeblock",
        },
      },
    },
    inline = {
      adapter = "anthropic",
    },
    agent = {
      adapter = "anthropic",
    },
  },
})
