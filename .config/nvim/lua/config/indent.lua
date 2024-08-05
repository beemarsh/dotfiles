local status_ok, gitsigns = pcall(require, "ibl")
if not status_ok then
	return
end
require("ibl").setup()
