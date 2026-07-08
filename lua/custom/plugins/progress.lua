vim.filetype.add({
    extension = {
        p = "openedge",
        cls = "openedge",
        w = "openedge",
        i = "openedge",
        pf = "openedge",
    },
})

vim.lsp.config("openedge-language-server", {
    filetypes = { "openedge" },
})

vim.lsp.enable("openedge-language-server")
