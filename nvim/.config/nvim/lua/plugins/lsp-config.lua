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
                ensure_installed = { "lua_ls", "ts_ls", "html" },
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

            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
            })

            local function navigate_diagnostics_and_show_window(direction)
                if direction == "next" then
                    vim.diagnostic.goto_next()
                else
                    vim.diagnostic.goto_prev()
                end
                
                local line = vim.api.nvim_win_get_cursor(0)[1] - 1
                local diagnostics = vim.diagnostic.get(0, { lnum = line })
                
                if #diagnostics > 0 then
                    local width = math.floor(vim.o.columns * 0.8)
                    local height = math.floor(vim.o.lines * 0.8)
                    local bufnr = vim.api.nvim_create_buf(false, true)
                    local win_opts = {
                        relative = "editor",
                        width = width,
                        height = height,
                        row = math.floor((vim.o.lines - height) / 2),
                        col = math.floor((vim.o.columns - width) / 2),
                        style = "minimal",
                        border = "rounded"
                    }
                    
                    local winnr = vim.api.nvim_open_win(bufnr, true, win_opts)
                    local lines = {}
                    for _, d in ipairs(diagnostics) do
                        local msg = d.message:gsub("\n", " ")
                        table.insert(lines, string.format("[%s] %s", vim.diagnostic.severity[d.severity], msg))
                    end
                    
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
                    vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
                    vim.keymap.set('n', 'q', ':q<CR>', { buffer = bufnr })
                end
            end

            vim.keymap.set("n", "]d", function() navigate_diagnostics_and_show_window("next") end, {})
            vim.keymap.set("n", "[d", function() navigate_diagnostics_and_show_window("prev") end, {})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
