-- Setup colorizer.
local status_ok, npairs = pcall(require, "colorizer")
if not status_ok then
  return
end
require 'colorizer'.setup()
