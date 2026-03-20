return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Go
    vim.lsp.config.gopls = {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_markers = { "go.work", "go.mod", ".git" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
    vim.lsp.enable("gopls")

    -- Lua
    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    }
    vim.lsp.enable("lua_ls")

    -- YAML
    vim.lsp.config.yamlls = {
      cmd = { "yaml-language-server", "--stdio" },
      filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
      root_markers = { ".git" },
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
          },
        },
      },
    }
    vim.lsp.enable("yamlls")

    -- JSON
    vim.lsp.config.jsonls = {
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      root_markers = { ".git" },
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }
    vim.lsp.enable("jsonls")
  end,
  dependencies = {
    "b0o/schemastore.nvim", -- JSON schemas for jsonls
  },
}
