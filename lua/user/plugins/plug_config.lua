-- dap config stuff
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
-- noice config stuff
require("noice").setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}

-- compiler config stuff
-- Open compiler
vim.api.nvim_set_keymap("n", "mo", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap(
  "n",
  "ms",
  "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
    .. "<cmd>CompilerRedo<cr>",
  { noremap = true, silent = true }
)

-- Toggle compiler results
vim.api.nvim_set_keymap("n", "mt", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

-- In your init.lua or a relevant configuration file
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroFileOpened",
  callback = function()
    vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#FF0000" })
    vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#FFA500" })
    vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#00FF00" })
    vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#0000FF" })
    vim.diagnostic.config {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        -- source = "always",
        header = "",
        prefix = "",
        timeout = 500, -- Adjust this value to control the popup duration
      },
    }
  end,
})
