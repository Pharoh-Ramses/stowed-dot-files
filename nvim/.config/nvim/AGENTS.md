# Neovim Configuration - Agent Guidelines

## Build/Test Commands
- No build system - this is a Neovim Lua configuration
- Test by reloading Neovim: `:source %` or restart nvim
- Check syntax: `lua vim.cmd('luafile %')` in nvim command mode
- Validate config: Open nvim and check for errors on startup

## Code Style & Conventions
- **Indentation**: 2 spaces (set in vim-options.lua)
- **File structure**: Plugin configs in `lua/plugins/`, main config in `init.lua`
- **Plugin format**: Return table with plugin spec using lazy.nvim format
- **Naming**: kebab-case for files, snake_case for Lua variables
- **Imports**: Use `require("module")` at top of functions, not file level
- **Keymaps**: Use `vim.keymap.set()` with descriptive opts table
- **LSP setup**: Configure in lsp-config.lua with capabilities from cmp_nvim_lsp

## Plugin Patterns
- Each plugin file returns a table of plugin specifications
- Use `config = function()` for setup code
- Include dependencies in plugin spec
- Set keymaps within plugin config functions
- Use lazy loading when appropriate (`event`, `cmd`, `ft`)

## Error Handling
- No explicit error handling patterns observed
- Rely on Neovim's built-in error reporting
- Use `pcall()` for optional requires if needed