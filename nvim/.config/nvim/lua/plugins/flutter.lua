return {
    -- Plugin: flutter-tools.nvim
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
        "neovim/nvim-lspconfig", -- Added for language server protocol support
        "hrsh7th/nvim-cmp", -- Added for autocompletion
        "hrsh7th/cmp-nvim-lsp", -- Added for autocompletion with LSP
    },
    config = function()
        require("flutter-tools").setup({
            ui = {
                border_style = "rounded",
                notification_style = "short",
            },
            widget_guides = {
                enabled = true,
            },
            dev_log = {
                enabled = true,
                open_cmd = "tabedit",
            },
            dev_tools = {
                widget_guides = true,
                dev_log = true,
                debugger = {
                    enabled = true,
                    execute_terminal = "vert term",
                },
            },
        })
        -- Configuration for language server protocol and autocompletion
        require("lspconfig").dartls.setup{
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            cmd = { "~/development/flutter/bin/flutter", "language-server", "--protocol=lsp" } -- Adjusted path here
        }
    end,
}
