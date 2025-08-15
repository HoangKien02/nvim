return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      width = 100,
      pane_gap = 20,
      row = nil,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      preset = {
        keys = {
          {
            { key = "n", hidden = true, action = ":ene | startinsert" },
            { key = "f", hidden = true, action = ":lua Snacks.dashboard.pick('files')" },
            { key = "r", hidden = true, action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { key = "g", hidden = true, action = ":lua Snacks.dashboard.pick('live_grep')" },
            { key = "s", hidden = true, section = "session" },
            { key = "L", hidden = true, action = ":Lazy",                                  enabled = package.loaded.lazy ~= nil },
            { key = "q", hidden = true, action = ":qa",                                    enabled = package.loaded.lazy ~= nil },
          },
        },
      },
      formats = {
        key = { "" },
        file = function(item)
          return {
            { item.key,                           hl = "key" },
            { " " },
            { item.file:sub(2):match("^(.*[/])"), hl = "NonText" },
            { item.file:match("([^/]+)$"),        hl = "Normal" },
          }
        end,
        icon = { "" },
      },
      sections = {
        -- hidden
        { section = "keys" },
        -- not hidden
        {
          pane = 1,
          section = "terminal",
          cmd =
          "onefetch",
          height = 27,
          width = 100,
          indent = 20,
        },
        {
          pane = 2,
          indent = 21,
          {
            { text = "" },
            {
              text = {
                { "n ",        hl = "key" },
                { "New file",  hl = "Normal" },
                { "",          width = 12 },
                { "g ",        hl = "key" },
                { "Grep text", hl = "Normal" },
              },
            },
            { text = "", padding = 1 },
            {
              text = {
                { "f ",             hl = "key" },
                { "Find file",      hl = "Normal" },
                { "",               width = 11 },
                { "s ",             hl = "key" },
                { "Reload session", hl = "Normal" },
              },
            },
            { text = "", padding = 1 },
            {
              text = {
                { "r ",           hl = "key" },
                { "Recent files", hl = "Normal" },
                { "",             width = 8 },
                { "L ",           hl = "key" },
                { "Lazy",         hl = "Normal" },
              },
            },
          },
          { text = "",            padding = 2 },
          { title = "Projects",   padding = 1, indent = 21 },
          { section = "projects", limit = 5,   padding = 2, indent = 20 },
          { title = "TODO List",  padding = 1, indent = 21 },
        },
      },
    },
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#5ceef6" })
    vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = "#c49aee" })
  end,
}
