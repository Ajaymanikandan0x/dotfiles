require('toggleterm').setup{
    -- Add your configuration options here
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved',
        winblend = 3,
    },
}

-- Define custom key mappings
function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)          -- Exit to normal mode
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)             -- Alternative exit to normal mode
    vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)    -- Navigate left
    vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)    -- Navigate down
    vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)    -- Navigate up
    vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)    -- Navigate right
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')