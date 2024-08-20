-- Better Around/Inside textobjects setup
require("mini.ai").setup({ n_lines = 500 })

-- Add/delete/replace surroundings setup
require("mini.surround").setup()

-- Simple and easy statusline setup
local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- Override default behavior for cursor location section in statusline
statusline.section_location = function()
    return "%2l:%-2v"
end
