return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>tf",
				function()
					-- If autoformat is currently disabled globally,
					-- then enable it globally, otherwise disable it globally
					if vim.g.disable_autoformat then
						vim.cmd("FormatEnable")
					else
						vim.cmd("FormatDisable")
					end
				end,
				desc = "Toggle autoformat globally",
			},
			{
				"<leader>hf",
				function()
					vim.cmd("FormatEnabled")
				end,
				desc = "Check autoformat enabled",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome", stop_after_first = true },
				typescript = { "biome", stop_after_first = true },
				javascriptreact = { "biome", stop_after_first = true },
				typescriptreact = { "biome", stop_after_first = true },
				json = { "biome", stop_after_first = true },
			},
			format_on_save = function(bufnr)
				-- if global autoformat is disabled, return nil
				if vim.g.disable_autoformat then
					return
				end
				local disable_filetypes = { c = false, cpp = false }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters = {
				biome = {
					command = vim.fn.expand("$APPDATA/npm/biome.cmd"),
				},
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)

			vim.api.nvim_create_user_command("FormatDisable", function()
				-- :FormatDisable disables autoformat globally
				vim.g.disable_autoformat = true
				vim.notify("Auto format disabled globally")
			end, {
				desc = "Disable autoformat-on-save",
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.g.disable_autoformat = false
				vim.notify("Auto format enabled globally")
			end, {
				desc = "Re-enable autoformat-on-save",
			})
			vim.api.nvim_create_user_command("FormatEnabled", function()
				local isEnabledMessage = ""
				if vim.g.disable_autoformat then
					isEnabledMessage = "disabled"
				else
					isEnabledMessage = "enabled"
				end
				vim.notify("Auto format is: " .. isEnabledMessage)
			end, { desc = "Check global auto format enabled" })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
