return {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }

      local status_ok_telescope, builtin = pcall(require, "telescope.builtin")
      if status_ok_telescope then
        vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
        vim.keymap.set("n", "gr", builtin.lsp_references, opts)
        vim.keymap.set("n", "<leader>/", builtin.lsp_document_symbols, opts)
      else
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      vim.keymap.set('n', 'gl', function()
        vim.diagnostic.open_float({ border = "rounded" })
      end, { desc = "Zeige Diagnosedaten (Floating)" })


      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
        on_attach(client, bufnr)
      end
    })

    local capabilities
    local status_ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok_cmp then
      capabilities = cmp_lsp.default_capabilities()
    else
      capabilities = vim.lsp.protocol.make_client_capabilities()
    end


    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "gopls", "clangd", "jsonls", "hyprls" },
      automatic_enable = true,

      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["jsonls"] = function()
          require("lspconfig").jsonls.setup({
            capabilities = capabilities,
            settings = {
              json = {
                schemas = require('schemastore').json.schemas(), -- Nutzt schemastore Plugin
                validate = { enable = true },
              },
            },
          })
        end,

      }
    })

    local util = require 'lspconfig.util'

    vim.lsp.config("flow", {
      cmd = { vim.fn.expand("~/projects/lsp-introduction/server/flow-lsp") },
      filetypes = { "flow" },
      root_dir = util.find_git_ancestor() or util.path.dirname,
      capabilities = capabilities,
    })

    vim.lsp.enable("flow")
  end,
}
