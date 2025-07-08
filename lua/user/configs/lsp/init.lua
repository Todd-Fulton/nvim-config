local modpath = (...):gsub(".init", "")
local M = {}
local utils = require 'cake.utils'

M.configs = {}

for filename in io.popen('ls -pUqAL ' .. utils.script_path()):lines() do
  filename = filename:match "^(.*)%.lua$"
  if filename and filename ~= "init" then
    M.configs[filename] = require(modpath .. "." .. filename)
  end
end

-- Default handlers for all servers
M.handlers = {
  ["textDocument/hover"] =
      vim.lsp.with(
        vim.lsp.buf.hover,
        {
          border = "rounded",
        }
      ),

  ["textDocument/signatureHelp"] =
      vim.lsp.with(
        vim.lsp.buf.signature_help,
        {
          border = "rounded",
        }
      ),
}

M.global = {
  semantic_tokens = true,
  hints = true,
  codelens = true,
  format_on_save = false,
}

return M
