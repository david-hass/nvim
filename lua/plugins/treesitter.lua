

vim.filetype.add({
  extension = {
    flow = "flow",
  },
})

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",

  config = function()

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.flow = {
      install_info = {
        url = vim.fn.expand("~/projects/lsp-introduction/grammar"),
        files = { "src/parser.c" },
        requires_generate_from_grammar = false,
      },

      filetype = "flow",
    }

    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "flow",

        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "go",
      },
    })
    vim.treesitter.language.register("bash", "zsh")
  end,
}
