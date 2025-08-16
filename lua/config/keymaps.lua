-- Simple and effective - just add this to your init.lua
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard in insert mode" })

-----------------------------------------------------------
-- Normal Mode
-----------------------------------------------------------
-- Disable Space bar since it'll be used as the leader key
vim.keymap.set("n", "<leader>", "<nop>")

-- nvim treesitter

vim.keymap.set('n', "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Open Nvim Treesitter" })

-----------------------------------------------------------
-- Telescope related
-----------------------------------------------------------
-- open Telescope picker
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<cr>", { desc = "Open Telescope builtin picker" })

-- find files (open in new tab if current tab is empty)
vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files({
		attach_mappings = function(_, map)
			-- select current tab if it is empty, else select new tab and open file over there
			local actions = require("telescope.actions")

			map("i", "<CR>", actions.select_tab)
			map("n", "<CR>", actions.select_tab)
			return true
		end,
    no_ignore = true
	})
end, { desc = "Find files in new tab" })
vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep({
		attach_mappings = function(_, map)
			-- select current tab if it is empty, else select new tab and open file over there
			local actions = require("telescope.actions")

			map("i", "<CR>", actions.select_tab)
			map("n", "<CR>", actions.select_tab)
			return true
		end,
    no_ignore = true
	})
end, { desc = "Find files live grep in new tab" })

-- find files in same buffer
vim.keymap.set("n", "<leader>fF", function()
	require("telescope.builtin").find_files({
    no_ignore = true
	})
end, { desc = "Find files in same tab" })
vim.keymap.set("n", "<leader>fG", function()
	require("telescope.builtin").live_grep({
    no_ignore = true
	})
end, { desc = "Find files live grep in same tab" })


-- tabs
vim.keymap.set("n", "<C-t>", ":tabe<CR>")
vim.keymap.set("n", "<C-w>", ":tabclose<CR>")

-- Redo remap
vim.keymap.set("n", "U", "<C-r>")

-- Swap between split buffers
vim.keymap.set("n", "<C-Left>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-Right>", ":wincmd l<CR>")

-- Save and quit current file quicker
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = false })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = false })

-- Little one from Primeagen to mass replace string in a file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- Navigate through buffers
vim.keymap.set("n", "<S-Right>", ":bnext<CR>", { silent = false })
vim.keymap.set("n", "<S-Left>", ":bprevious<CR>", { silent = false })

-- Close currently active buffer
vim.keymap.set("n", "<C-c>", ":bwipeout<CR>", { silent = false })

-- Center buffer when navigating up and down
vim.keymap.set("n", "<S-Up>", "<C-u>zz")
vim.keymap.set("n", "<S-Down>", "<C-d>zz")

-- Center buffer when progressing through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without replacing paste with what you are highlighted over
vim.keymap.set("n", "<leader>p", '"_dP')

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Open buffer to the right
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")

-----------------------------------------------------------
-- Visual Mode
-----------------------------------------------------------
-- Disable Space bar since it'll be used as the leader key
vim.keymap.set("v", "<leader>", "<nop>")

-- Move selection up and down
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")

vim.api.nvim_create_autocmd(
	"LspAttach",
	{ --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }

			-- Telescope floats
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
			vim.keymap.set("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<cr>", opts)
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

			-- Regular LSP functions
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)

			-- Open the diagnostic under the cursor in a float window
			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float({
					border = "rounded",
				})
			end, opts)
		end,
	}
)
