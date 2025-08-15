return
-- {
--   {
--     "mfussenegger/nvim-dap",
--     dependencies = {
--       "nvim-neotest/nvim-nio",
--       "rcarriga/nvim-dap-ui",
--       "nvim-telescope/telescope.nvim",
--       "suketa/nvim-dap-ruby",
--     },
--     config = function()
--       local dap = require("dap")
--       local dapui = require("dapui")
--       local vscode = require("dap.ext.vscode")
--
--       -- Setup Ruby DAP
--       require("dap-ruby").setup()
--       dap.adapters.rdbg = {
--         type = "server",
--         host = "localhost",
--         port = "1234", -- port rdbg will listen on
--       }
--       -- Load custom launch config
--       vscode.load_launchjs(
--         vim.fn.getcwd() .. "/.vscode/launch_nvim.json",
--         {
--           ruby = { "ruby" },   -- map type "ruby" => adapter ruby
--           rdbg = { "server" }, -- map type "rdbg" => adapter server
--         }
--       )
--       -- stylua: ignore
--       -- keys = {
--       --   { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
--       --   { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
--       --   { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
--       --   { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
--       --   { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
--       --   { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
--       --   { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
--       --   { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
--       --   { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
--       --   { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
--       --   { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
--       --   { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
--       --   { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
--       --   { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
--       --   { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
--       --   { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
--       --   { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
--       -- }
--
--
--
--       -- DAP UI setup
--       dapui.setup()
--
--       dap.listeners.after.event_initialized["dapui_config"] = function()
--         dapui.open()
--       end
--       dap.listeners.before.event_terminated["dapui_config"] = function()
--         dapui.close()
--       end
--       dap.listeners.before.event_exited["dapui_config"] = function()
--         dapui.close()
--       end
--
--       -- Keymap chọn config DAP qua Telescope
--       vim.keymap.set("n", "<leader>dd", function()
--         require("telescope").extensions.dap.configurations()
--       end, { desc = "Pick DAP Config" })
--     end,
--   },
--   {
--     "nvim-telescope/telescope-dap.nvim",
--     dependencies = { "nvim-telescope/telescope.nvim" },
--     config = function()
--       require("telescope").load_extension("dap")
--     end,
--   },
-- }
--
{
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope.nvim",
      "suketa/nvim-dap-ruby",
    },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
      { "<leader>dd", function() require("telescope").extensions.dap.configurations() end,                  desc = "Pick DAP Config" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local vscode = require("dap.ext.vscode")

      -- Setup Ruby DAP (rdebug-ide via nvim-dap-ruby)
      require("dap-ruby").setup()

      -- Add rdbg adapter (Ruby's built-in debugger)
      dap.adapters.rdbg = {
        type = "server",
        host = "localhost",
        port = "1234",
      }

      -- Load launch_nvim.json configs
      vscode.load_launchjs(
        vim.fn.getcwd() .. "/.vscode/launch_nvim.json",
        {
          ruby = { "ruby" }, -- rdebug-ide adapter
          rdbg = { "rdbg" }, -- rdbg adapter
        }
      )

      -- Setup DAP UI
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keymap for picking DAP config via Telescope
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },

}
