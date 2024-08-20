-- Autocompletion setup in plugins/autocompletion.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Setup LuaSnip
luasnip.config.setup({})

-- Setup nvim-cmp
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- Expand snippets using LuaSnip
        end,
    },
    completion = { completeopt = "menu,menuone,noinsert" }, -- Configure completion options
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(), -- Navigate to the next item
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- Navigate to the previous item
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),    -- Scroll documentation backward
        ["<C-f>"] = cmp.mapping.scroll_docs(4),     -- Scroll documentation forward
        ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        ["<C-Space>"] = cmp.mapping.complete({}),   -- Manually trigger completion
        ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then -- Expand or jump snippet
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then -- Jump snippet backward
                luasnip.jump(-1)
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" }, -- LSP sources
        { name = "luasnip" },  -- LuaSnip snippets
        { name = "path" },     -- Path completion
    },
})