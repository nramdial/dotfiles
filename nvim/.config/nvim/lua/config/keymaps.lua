local keymap = vim.keymap

local opts = { noremap = true, silent = true  }

-- Directory Navigation
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", opts)
keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", opts)

-- Pane and Window  Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts) -- Navigate left
keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts) -- Navigate down
keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts) -- Navigate up
keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts) -- Navigate right
keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts) -- Navigate left
keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts) -- Navigate down
keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split Vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split Horizontally
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimize
-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")


-- Comments 
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false }) -- Normal Mode comment
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false }) -- Visual Mode comment 
