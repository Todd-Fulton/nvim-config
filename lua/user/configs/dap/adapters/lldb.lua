 -- TODO: get dynamically using env.PATH
local lldb_vscode_exe = "lldb-dap"

return {
  type = 'executable',
  command = lldb_vscode_exe,
  name = 'lldb'
}
