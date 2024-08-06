local map = require("helpers.keys").map

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>", "Exit Insert Mode")
map("i", "kj", "<esc>", "Exit Insert Mode")

-- Nvimtree
map("n", "<leader>e", ":NvimTreeToggle<cr>", "Open Nvim Tree")

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save file")

-- Easier access to beginning and end of lines
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

map("n", "<leader>ww", "<C-W>p", "Move to Other window")
map("n", "<leader>wd", "<C-W>c", "Delete current window")
map("n", "<leader>wh", "<C-W>s", "Split window horizontal")
map("n", "<leader>wv", "<C-W>v", "Split window vertical")

-- Move with shift-arrows
--[[ map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right") ]]

-- Resize window with arrows
map("n", "<C-Up>", ":resize +2<CR>", "Horizontally increase size of window")
map("n", "<C-Down>", ":resize -2<CR>", "Horizontally decrease size of window")
map("n", "<C-Left>", ":vertical resize +2<CR>", "Vertically increase the of window")
map("n", "<C-Right>", ":vertical resize -2<CR>", "Vertically decrease size of window")

-- Files
map("n", "<leader>fn", "<cmd>enew<cr>", "Create a New File")

-- Deleting buffers
map("n", "<leader>db", "<cmd>BufDel<cr>", "Current buffer")
map("n", "<leader>do", "<cmd>BufDelOthers<cr>", "Other buffers")
map("n", "<leader>da", "<cmd>BufDelAll<cr>", "All buffers")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", "Next Buffer")
map("n", "<S-h>", ":bprevious<CR>", "Previous Buffer")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", "Move down")
map("n", "<A-k>", "<cmd>m .-2<cr>==", "Move up")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move down")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move up")
map("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move down")
map("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move up")

-- Switch between light and dark modes
map("n", "<leader>ut", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end, "Toggle between light and dark themes")

-- Clear after search
map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

-- Telescope and Search
map(
	"n",
	"<leader>sf",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	"Search files"
)
map("n", "<leader>st", "<cmd>Telescope live_grep<cr>", "Search text")
map("n", "<leader>sb", "<cmd>Telescope buffers<cr>", "Search buffers")
map("n", "<leader>ss", "<cmd>Telescope grep_string<cr>", "Search for string under the cursor")

-- Git with Telescope
map("n", "<leader>gf", "<cmd>Telescope git_files<cr>", "Search for git files (Git Directory)")
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", "View git commits")
map("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", "View commits from the current buffer")
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", "View git branches")
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", "View current changes per file (git status)")

-- Git with Git signs
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", "View Hunks under the cursor")
map("n", "<leader>gH", "<cmd>Gitsigns preview_hunk_inline<cr>", "View Hunks Inline under the cursor")
map("n", "<leader>gm", "<cmd>Gitsigns blame_line<cr>", "View Last Modification of the line (git blame)")
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", "View Git Diff")

-- Formatting
map("n", "<M-f>", "<cmd>lua vim.lsp.buf.format()<cr>", "Format the code")
-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", "Quit all")

-- Open Projects
map("n","<C-o><C-p>","<cmd>Telescope projects<cr>","Open Recent Projects")

-- Code Runner
map('n', '<F5>', "<cmd>CompilerOpen<cr>", "Open Compile Options")
-- Stop compiler when Pressing Shift + F5
map('n', '<F17>', "<cmd>CompilerStop<cr>", "Stop Compiler")
-- Toggle compiler results when Pressing Shift + F6
map('n', '<F18>', "<cmd>CompilerToggleResults<cr>", "Open or Close Compiler Results")
