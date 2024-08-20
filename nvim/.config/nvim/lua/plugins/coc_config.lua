-- Listen for LSPAttach event
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        -- Define a function for mapping keys
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Map keys to coc.nvim functions
        map("gd", "<Plug>(coc-definition)", "[G]oto [D]efinition")
        map("gr", "<Plug>(coc-references)", "[G]oto [R]eferences")
        map("gI", "<Plug>(coc-implementations)", "[G]oto [I]mplementation")
        map("<leader>D", "<Plug>(coc-type-definition)", "Type [D]efinition")
        map("<leader>ds", "<Plug>(coc-symbols)", "[D]ocument [S]ymbols")
        map("<leader>ws", "<Plug>(coc-workspace-symbols)", "[W]orkspace [S]ymbols")
        map("<leader>rn", "<Plug>(coc-rename)", "[R]e[n]ame")
        map("<leader>ca", "<Plug>(coc-codeaction)", "[C]ode [A]ction")
        map("K", "<Plug>(coc-hover)", "Hover Documentation")
        map("gD", "<Plug>(coc-declaration)", "[G]oto [D]eclaration")
        map("<leader>th", "<Plug>(coc-inlay-hints)", "[T]oggle Inlay [H]ints")
    end,
})

-- Define server configurations (if needed)
local servers = {
    -- Example configuration for a language server
    -- Adjust or remove as needed based on your setup
    tsserver = {},
}

