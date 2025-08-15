
-- lua/plugins/vue.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Vue 3 with Volar
      opts.servers.volar = {
        filetypes = { "vue" },
        init_options = {
          typescript = {
            tsdk = vim.fn.stdpath("data")
              .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
          },
        },
      }

      -- Optional: TypeScript/JavaScript LSP
      opts.servers.tsserver = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vue",
        "typescript",
        "javascript",
        "html",
        "css",
        "json",
      },
      highlight = { enable = true },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "vue-language-server", -- Mason name for Volar
        "typescript-language-server",
        "prettier", -- optional
      },
    },
  },
}
