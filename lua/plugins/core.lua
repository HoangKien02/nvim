-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- LazyVim extras should be imported first
  { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.lang.json" },


  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      background = "white"
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { "/Users/kienbz/.rbenv/versions/3.2.0/bin/ruby-lsp" },
        },
        rubo_cop = {

          -- enabled = formatter == "rubocop" and lsp ~= "solargraph",
        }
      },
    },
  },
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  -- { import = "lazyvim.plugins.extras.lang.typescript" }, -- moved to top

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "ruby"
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      if opts.ensure_installed then
        vim.list_extend(opts.ensure_installed, {
          "tsx",
          "typescript",
        })
      end
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" }, -- moved to top

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  -- { import = "lazyvim.plugins.extras.lang.json" }, -- moved to top

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  {
    --- ~/.config/nvim/lua/plugins/snacks.nvim
    "folke/snacks.nvim",
    --- Updated this section to align with approach taken in other LazyVim snacks configs
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, opts)
      -- Credit for this section goes to exsesx
      -- https://github.com/LazyVim/LazyVim/discussions/4232#discussioncomment-11191278
      local snacks = require("snacks")
      -- Check whether Copilot is installed
      if pcall(require, "copilot") then
        --- Workaround to keep track of state
        vim.g.snacks_copilot_enabled = true
        snacks
            .toggle({
              name = "Toggle (Copilot Completion)",
              color = {
                enabled = "azure",
                disabled = "orange",
              },
              get = function()
                return vim.g.snacks_copilot_enabled
              end,
              set = function(state)
                if state then
                  vim.g.snacks_copilot_enabled = true
                  require("copilot.command").enable()
                else
                  vim.g.snacks_copilot_enabled = false
                  require("copilot.command").disable()
                end
              end,
            })
            :map("<leader>at")
      end
    end,
  },

  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin will only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = " <summary> • <date> • <author>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },

  },
  {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "bash-language-server",
          "css-lsp",
          "eslint-lsp",
          "gopls",
          "helm-ls",
          "html-lsp",
          "json-lsp",
          "jdtls",
          "marksman",
          "phpactor",
          "typescript-language-server",
          "vue-language-server",
        },
      },
    },
    {
      "nvim-lspconfig",
      keys = {
        { "<leader>ce", "<cmd>EslintFixAll<cr>", desc = "ESLint Fix All" },
      },
      opts = {
        setup = {
          volar = function()
            require("lazyvim.util").lsp.on_attach(function(client, _)
              if client.name == "volar" then
                client.server_capabilities.documentFormattingProvider = false
              end
            end)
          end,
        },
      },
    },
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup()
    end
  },
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    }
  },
  --   {
  --     "anAcc22/sakura.nvim",
  --     dependencies = "rktjmp/lush.nvim",
  --     config = function()
  --         vim.opt.background = "light" -- or "light"
  --         vim.cmd('colorscheme sakura') -- sets the colorscheme
  --     end
  -- },
  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = { -- you can just pass {}, defaults below
      events = {
        render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
        clear_buffer = { "BufLeave" },
      },
      renderer_options = {
        mermaid = {
          background = nil, -- nil | "transparent" | "white" | "#hex"
          theme = nil,      -- nil | "default" | "dark" | "forest" | "neutral"
          scale = 1,        -- nil | 1 (default) | 2  | 3 | ...
          width = nil,      -- nil | 800 | 400 | ...
          height = nil,     -- nil | 600 | 300 | ...
        },
        plantuml = {
          charset = nil,
        },
        d2 = {
          theme_id = nil,
          dark_theme_id = nil,
          scale = nil,
          layout = nil,
          sketch = nil,
        },
        gnuplot = {
          size = nil,  -- nil | "800,600" | ...
          font = nil,  -- nil | "Arial,12" | ...
          theme = nil, -- nil | "light" | "dark" | custom theme string
        },
      }
    },
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme tokyonight-day]])
  --   end,
  -- },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },
  {
    {
      "neovim/nvim-lspconfig",
      opts = {
        setup = {
          tsserver = function(_, opts)
            local mason_registry = require("mason-registry")
            local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
                .. "/node_modules/@vue/language-server"

            opts.init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_language_server_path,
                  languages = { "vue" },
                },
              },
            }
            opts.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
          end,
        },
        servers = {
          tsserver = {},
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      -- Set default options
      default_format_opts = {
        lsp_format = "fallback",
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500 },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
}
