local status_ok, bufferline = pcall(require, "bufferline") if not status_ok then
  return
end

--[[ Buffer Delete ]]
local status_ok_bufdel, buf_del = pcall(require, "bufdel")
if not status_ok_bufdel then
  return
end

buf_del.setup({
  next = "tabs",
  quit = false, -- quit Neovim when last buffer is closed
})

bufferline.setup({
  options = {
    numbers = "none",     -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = true,   -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = true,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
})
