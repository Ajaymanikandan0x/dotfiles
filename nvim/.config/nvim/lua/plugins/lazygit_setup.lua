-- Configuration for LazyGit
return function()
    -- Optional: require plenary.nvim if not already required
    require("plenary")

    -- Set up the keybinding for LazyGit
    vim.keymap.nnoremap("<leader>lg", "<cmd>LazyGit<CR>", { silent = true, desc = "LazyGit" })
end
