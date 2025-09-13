-- return {
--   "catppuccin/nvim",
--   lazy = false,
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       flavour = "mocha",             -- latte, frappe, macchiato, mocha
--       transparent_background = true, -- "transquest" vibe = transparent + dark
--       integrations = {
--         treesitter = true,
--         telescope = true,
--         native_lsp = {
--           enabled = true,
--         },
--       },
--     })
--     vim.cmd.colorscheme "catppuccin"
--   end,
-- }
-- return {
--   "mcauley-penney/ice-cave.nvim",
--   config = function()
--     vim.cmd.colorscheme("ice-cave")
--   end,
--   priority = 1000
-- }
return
-- Or with configuration
{
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      -- ...
    })

    vim.cmd('colorscheme github_light')
  end,
}
