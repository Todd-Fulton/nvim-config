---@module 'nvim-dap-virtual-text'
return {
  {
    "mfussenegger/nvim-dap",
    ft = { "cpp", "c" },
    init = function()
      local augroup = vim.api.nvim_create_augroup("UserDapConfig", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = { "cpp", "c" },
        callback = function(ev)
          local wk = require "which-key"
          wk.add {
            { "<Leader>d", group = "Debug", icon = " ", buffer = ev.buf, noremap = true },
            {
              "<Leader>db",
              function() require("dap").toggle_breakpoint() end,
              icon = " ",
              desc = "Toggle breakpoint",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>dB",
              function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
              icon = " ",
              desc = "Breakpoint condition",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>dp",
              function() require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ") end,
              icon = " ",
              desc = "Log point",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>dd",
              function()
                require("dap.ext.vscode").load_launchjs(nil, {lldb = {"c", "cpp"}})
                require("dap").continue({new = true})
              end,
              icon = " ",
              desc = "Start debugging session",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>dC",
              function() require("dap").continue() end,
              icon = " ",
              desc = "Continue/Start",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>do",
              function() require("dap").step_over() end,
              icon = " ",
              desc = "Step over",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>dO",
              function() require("dap").step_out() end,
              icon = " ",
              desc = "Step Out",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>di",
              function() require("dap").step_into() end,
              icon = " ",
              desc = "Step into",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>dS",
              function() require("dap").terminate() end,
              icon = " ",
              desc = "Stop",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<Leader>du",
              function() require("dapui").toggle() end,
              icon = "",
              desc = "Toggle dap ui",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<M-b>",
              function() require("dap").toggle_breakpoint() end,
              icon = " ",
              desc = "Toggle breakpoint",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<M-c>",
              function() require("dap").continue() end,
              icon = " ",
              desc = "Continue/Start",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<M-o>",
              function() require("dap").step_over() end,
              icon = " ",
              desc = "Step over",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<M-u>",
              function() require("dap").step_out() end,
              icon = " ",
              desc = "Step Out",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<M-i>",
              function() require("dap").step_into() end,
              icon = " ",
              desc = "Step into",
              buffer = ev.buf,
              noremap = true,
            },
            {
              "<M-s>",
              function() require("dap").terminate() end,
              icon = " ",
              desc = "Stop",
              buffer = ev.buf,
              noremap = true,
            },
          }
        end,
      })
    end,
    config = function(_, _)
      local dap, dapui = require "dap", require "dapui"
      local dap_configs = require "user.configs.dap"
      for adapter, map in pairs(dap_configs.adapters) do
        dap.adapters[adapter] = map
      end
      for config, map in pairs(dap_configs.configurations) do
        dap.configurations[config] = map
      end
      dap.configurations.c = dap.configurations.cpp
      require "nvim-dap-virtual-text"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl="DiagnosticInfo" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl="DiagnosticInfo" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl="DiagnosticError" })
      vim.fn.sign_define("DapLogPoint", { text = "󰛿", texthl="DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "󰁕", texthl="DiagnosticWarn" })
      vim.fn.sign_define("Debugger", { text = "", texthl="DiagnosticInfo" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    lazy = true,
    opts = {},
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "nvim-treesitter/nvim-treesitter", "mfussenegger/nvim-dap" },
    lazy = true,
    opts = {
      enabled = true, -- enable this plugin (the default)
      enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true, -- show stop reason when stopped for exceptions
      commented = false, -- prefix virtual text with comment string
      only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
      all_references = false, -- show virtual text on all all references of the variable (not only definitions)
      clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
      --- A callback that determines how a variable is displayed or whether it should be omitted
      --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
      --- @param buf number
      --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
      --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
      --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
      --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == "inline" then
          return " = " .. variable.value
        else
          return variable.name .. " = " .. variable.value
        end
      end,
      -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
      virt_text_pos = vim.fn.has "nvim-0.10" == 1 and "inline" or "eol",

      -- experimental features:
      all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    },
  },
}
