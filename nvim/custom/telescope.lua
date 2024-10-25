require('telescope').setup{
  defaults = {
    layout_strategy = "horizontal",  -- or "vertical", "center", etc.
    layout_config = {
      width = 0.99,    -- Adjust the width (0.8 = 80% of the window)
      height = 0.8,   -- Adjust the height (0.6 = 60% of the window)
      preview_cutoff = 120,  -- When to hide the preview window (optional)
      horizontal = {         -- For horizontal layout
        preview_width = 0.6, -- Adjust the preview width (optional)
      },
      vertical = {           -- For vertical layout (optional)
        mirror = false,      -- Set to true if you want to flip the preview and results
      },
    },
    sorting_strategy = "ascending",  -- Sort from top to bottom (optional)
    prompt_position = "top",         -- Place prompt at the top (optional)
  }
}
