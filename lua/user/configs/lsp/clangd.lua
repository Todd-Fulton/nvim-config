return {
  -- TODO: Enable use on Windows
  -- Use systemd-run to isolate clangd and limit memory usage
  cmd = {
    "systemd-run",
    "--scope",
    "-p",
    "MemoryMax=32G",
    "--user",
    "direnv", "exec", ".", "clangd",
    "--background-index",
    "--completion-style=detailed",
    -- "--clang-tidy",
    "--enable-config",
    "--completion-parse=auto",
  },
  capabilities = {
    offsetEncoding = "utf-8",
  },
}
