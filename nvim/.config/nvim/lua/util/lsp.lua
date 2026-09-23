local keymap = vim.keymap

local M = {}

-- set keymaps on the active lsp server
M.on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	--set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostic<CR>", opts)
	keymap.set("n", "<leader>pd", "<cmd>Lspsaga show_cursor_diagnostic<CR>", opts)
	keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump<CR>", opts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "<leader>lo", "<cmd>LsOutlineToggle<CR>", opts)

  if client.name == "pyright" then
    keymap.set("n", "<leader>oi", "<cmd>PyrightOrganizeImports<CR>", opts)
  end
end

return M
