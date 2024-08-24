return {
    -- Plugin: which-key.nvim
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
        require("which-key").setup()
        vim.keymap.set("n", "<leader>?", ":WhichKey<CR>", {})
        vim.keymap.set("n", "<leader>f", function()
            local file_ext = vim.api.nvim_buf_get_option(0, 'filetype')
            if file_ext == "python" or file_ext == "dart" or file_ext == "lua" or file_ext == "text" or file_ext == "config"  then
                vim.api.nvim_command(":%!fmt")
            else
                print("Format not supported for this file type.")
            end
        end, {})
    end,
}