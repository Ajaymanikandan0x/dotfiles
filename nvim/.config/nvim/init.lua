-- Set mapleader and maplocalleader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Show line numbers by default
vim.opt.number = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, useful for resizing splits
vim.opt.mouse = "a"

-- Don't show the mode in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep sign column on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time, displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how Neovim will display certain whitespace characters in the editor
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Disable mouse in insert mode and re-enable it in other modes
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.opt.mouse = ''
  end
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    vim.opt.mouse = 'a'
  end
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Set up autocmd to highlight text after yanking

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text", -- Description of the autocmd
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }), -- Create an augroup to manage the autocmd
	callback = function()
		vim.highlight.on_yank() -- Call the function to highlight yanked text
	end,
})

-- Map <Tab> to confirm autocompletion selection
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-y>" : "\\<Tab>"', {expr = true, noremap = true})

-- Path to the lazy.nvim directory
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed
if not vim.loop.fs_stat(lazypath) then
	-- If not installed, clone it from the GitHub repository
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

-- Add the lazy.nvim directory to the runtimepath
vim.opt.rtp:prepend(lazypath)


-- NOTE: Here is where you install your plugins.
require("lazy").setup({


	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- Configuration block for gitsigns.nvim
	{
		-- Plugin: lewis6991/gitsigns.nvim
		"lewis6991/gitsigns.nvim",
		opts = {
			-- Options for gitsigns.nvim
			signs = {
				-- Customize git-related signs displayed in the gutter
				add = { text = "+" }, -- Sign for added lines
				change = { text = "~" }, -- Sign for changed lines
				delete = { text = "_" }, -- Sign for deleted lines
				topdelete = { text = "‾" }, -- Sign for top deleted lines (diff resolution)
				changedelete = { text = "~" }, -- Sign for changed and then deleted lines
			},
		},
	},
	{
		--lazygit
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			-- Load the setup function for LazyGit
			{ "<leader>lg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
		},
	},
	{
		--neo_tree
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("plugins.neo_tree_setup")()
		end,
		keys = {
			{ "<C-e>", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
		},vim.api.nvim_command('autocmd BufWritePre *.dart silent! CocCommand -silent format')
	},
	{
		-- Plugin: flutter-tools.nvim
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
	},
	-- {
	-- 	-- Coc.nvim
	-- 	"neoclide/coc.nvim",
	-- 	event = "VimEnter",
	-- 	branch = "release", -- Or any other branch you're using
	-- 	config = function()
	-- 		require("plugins.coc_config") -- Assuming coc_config.lua is located directly in the 'plugins' directory
	-- 	end,
	-- },
  {
		--coc autocompletion
		"neoclide/coc.nvim", branch = "release"
	},
	{ 
		--dart autoformat
		"dart-lang/dart-vim-plugin" 
    },
	
	{
		-- Plugin: nvim-autopairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
	{
		--terminal
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("plugins.toggleterm")
		end,
	},
	{
		-- Plugin: which-key.nvim
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function()
			-- Load the setup function from the separate file
			require("plugins.which_key_setup")()
		end,
	},
	{
		--Telescope
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("plugins.telescope")
		end,
	},
	-- {
	-- 	--lsp
	-- 	"neovim/nvim-lspconfig",
	-- 	dependencies = {
	-- 		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
	-- 		"williamboman/mason-lspconfig.nvim",
	-- 		"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 		{ "j-hui/fidget.nvim", opts = {} },
	-- 		{ "folke/neodev.nvim", opts = {} },
	-- 	},
	-- 	config = function()
	-- 		require("plugins.lsp")
	-- 	end,
	-- },

	-- {
	-- 	-- Autocompletion
	-- 	"hrsh7th/nvim-cmp",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		{
	-- 			"L3MON4D3/LuaSnip",
	-- 			build = (function()
	-- 				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
	-- 					return
	-- 				end
	-- 				return "make install_jsregexp"
	-- 			end)(),
	-- 			dependencies = {
	-- 				-- Uncomment if you need additional snippets
	-- 				-- { 'rafamadriz/friendly-snippets', config = function() require('luasnip.loaders.from_vscode').lazy_load() end, },
	-- 			},
	-- 		},
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-path",
	-- 	},
	-- 	config = function()
	-- 		require("plugins.autocompletion")
	-- 	end,
	-- },
	{
		-- Autoformat configuration block
		-- Plugin: conform.nvim
		"stevearc/conform.nvim",
		lazy = false, -- Load immediately (not lazy-loaded)
		keys = {
			{
				-- Key mapping: <leader>f to trigger formatting function
				"<leader>f",
				function()
					-- Call the format function provided by conform.nvim
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "", -- Mode: empty string means normal mode
				desc = "[F]ormat buffer", -- Description for the key mapping
			},
		},
		opts = {
			notify_on_error = false, -- Disable notifications on formatting errors
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for certain file types
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500, -- Timeout for format on save
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype], -- Enable LSP fallback unless filetype is disabled
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" }, -- Use stylua formatter for Lua files
	            dart = { "dartfmt" }, -- Use dartfmt formatter for Dart files
				-- Add other formatters for specific file types here
			},
		},
	},

	{ -- You can easily change to a different colorscheme.

		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},

	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		--mini_setup
		"echasnovski/mini.nvim",
		config = function()
			require("plugins.mini_setup")
		end,
	},
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- Run ":TSUpdate" after installation
		opts = {
			ensure_installed = { "bash", "c", "diff", "dart", "lua", "luadoc", "markdown", "vim", "vimdoc" },
			auto_install = true, -- Automatically install languages that are not installed
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			-- Configure Treesitter setup
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
