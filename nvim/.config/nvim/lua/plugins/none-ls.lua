return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim", -- For eslint_d and other extras
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      -- Enable debug logging to help diagnose issues
      -- Comment this out when everything works
      debug = true,

      sources = {
        -- JavaScript/TypeScript
        require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.formatting.prettierd,

        -- Lua
        null_ls.builtins.diagnostics.selene,
        null_ls.builtins.formatting.stylua,

        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.mypy,

        -- Go
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,

        -- Completion
        null_ls.builtins.completion.spell,
      },
    })

    -- Format keymap
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
