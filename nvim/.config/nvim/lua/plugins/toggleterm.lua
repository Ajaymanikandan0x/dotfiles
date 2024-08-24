
return {
    -- terminal
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("plugins.toggleterm")

        -- Set key mapping for toggling the terminal
        vim.api.nvim_set_keymap("n", "<C-\\>", "<cmd>lua require('toggleterm').toggle()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("t", "<C-\\>", "<C-\\><C-n><cmd>lua require('toggleterm').toggle()<CR>", { noremap = true, silent = true })
    end,
}