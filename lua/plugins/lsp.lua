return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "artemave/workspace-diagnostics.nvim",
  },
  opt = {},
  config = function()
    require("mason").setup({
      PATH = "prepend",
      install_root_dir = vim.fn.stdpath("data") .. "/mason",
    })

    require("lspconfig").ts_ls.setup({
      cmd = { "C:\\Users\\Charles\\AppData\\Roaming\\npm\\typescript-language-server.cmd", "--stdio" },
      on_attach = function(client)
        require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
      end,
    })
    require("lspconfig").biome.setup({
      cmd = { "C:\\Users\\Charles\\AppData\\Roaming\\npm\\biome.cmd", "--stdio" },
    })
    require("lspconfig").tailwindcss.setup({
      cmd = { "C:\\Users\\Charles\\AppData\\Roaming\\npm\\tailwindcss-language-server.cmd", "--stdio" },
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      root_dir = require("lspconfig").util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.cjs",
        "package.json"
      ),
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning"
          },
          validate = true
        }
      }
    })
    require("lspconfig").lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
}
