require("mason-nvim-dap").setup_handlers {
  python = function(source_name)
    local dap = require "dap"
    dap.adapters.python = {
      type = "executable",
      command = vim.fn.exepath "/opt/anaconda3/envs/py3-13-2/bin/python3", -- or the path to your virtual environment's python
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
      },
    }
  end,
}

require("dap-go").setup()

require("dap").configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
    -- Additional options can be added here
  },
}

-- vim.keymap.set("n", "<leader>nd", function() require("noice").dismiss() end, { desc = "Dismiss All" })
