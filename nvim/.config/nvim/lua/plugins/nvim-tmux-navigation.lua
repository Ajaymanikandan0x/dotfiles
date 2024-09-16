return {
  "christoomey/vim-tmux-navigator",
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
  },
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    -- Adjusting the mapping for <c-l> to ensure it works correctly in kitty terminal
    vim.keymap.set('n', '<c-l>', '<cmd>TmuxNavigateRight<cr>', { silent = true })
  end
}
