return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- Show hidden files in telescope
      show_hidden = true, -- refer to the configuration section below
    })
  end,
}
