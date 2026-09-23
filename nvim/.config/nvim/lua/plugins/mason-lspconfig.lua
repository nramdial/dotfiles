local opts = {
  ensure_installed = {
    "efm",
    "lua_ls",
    "ts_ls",
    "tailwindcss",
    "pyright",
    "jsonls",
    "clangd"
  },
  automatic_installation = true,
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
