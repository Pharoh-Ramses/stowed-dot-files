return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls","ts_ls", "html" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    border = 'rounded',
                    source = 'always',
                    focusable = true,
                    style = 'minimal',
                    header = '',
                    prefix = '',
                },
            })

            -- Function to navigate diagnostics and show popup
            local function navigate_diagnostics_and_show_popup(direction)
                if direction == "next" then
                    vim.diagnostic.goto_next({ float = false })
                else
                    vim.diagnostic.goto_prev({ float = false })
                end
                -- Defer the float to ensure it appears after navigation
                vim.defer_fn(function()
                    local opts = {
                        focusable = false,
                        close_events = {"InsertEnter"},
                        border = 'rounded',
                        source = 'always',
                        prefix = ' ',
                    }
                    vim.diagnostic.open_float(nil, opts)
                end, 100) -- 100ms delay
            end

            -- Key mappings for diagnostic navigation with popup
            vim.keymap.set("n", "]d", function() navigate_diagnostics_and_show_popup("next") end, {})
            vim.keymap.set("n", "[d", function() navigate_diagnostics_and_show_popup("prev") end, {})
            vim.keymap.set("n", "<leader>e", show_diagnostics_popup, {})

            -- Other LSP-related keybindings
            -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
