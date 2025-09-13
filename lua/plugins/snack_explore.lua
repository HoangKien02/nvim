return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        hidden = true, -- explorer (leader + e) shows hidden files
      },
      picker = {
        -- global picker settings
        hidden = true,  -- show hidden by default in pickers
        ignored = true, -- also include files ignored by gitignore (if wanted)
        sources = {
          files = {
            hidden = true, -- specifically for the find-files source
            ignored = true,
          },
          -- possibly other sources like grep etc. if they need explicit hidden setting
        },
      },
    },
  },
}
