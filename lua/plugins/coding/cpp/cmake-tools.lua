---TODO: Load when opening a workspace/project configured with cmake
return {
  "Civitasv/cmake-tools.nvim",
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "cmake" },
  opts = {
    cmake_build_directory = function() return "build" end,
    -- this will automatically make a soft link from compile commands file to project root dir
    cmake_soft_link_compile_commands = true,
    cmake_executor = {
      name = "quickfix",
      quickfix = {
        auto_close_when_success = false, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
    },
    cmake_runner = {
      name = "terminal",
    },
  },
}
