return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup({})
    telescope.load_extension("fzf")

    local buildin = require('telescope.builtin')

    vim.keymap.set("n", "<leader>ff", buildin.find_files,
      { desc = "Fuzzy find files in cwd", silent = true, noremap = true })

    vim.keymap.set("n", "<leader>gi", buildin.lsp_implementations,
      { desc = "Go To LSP implemtation", silent = true, noremap = true })

    vim.keymap.set("n", "<leader>gd", buildin.lsp_definitions,
      { desc = "Go To LSP definitions", silent = true, noremap = true })


    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>",
      { desc = "Find string in cwd", silent = true, noremap = true })

    vim.keymap.set(
      "n",
      "<leader>fc",
      "<cmd>Telescope grep_string<cr>",
      { desc = "Find string under cursor in cwd" }
    )

    vim.keymap.set("n", "<leader>fC", "<cmd>Telescope commands<cr>",
      { desc = "Fuzzy find commands", silent = true, noremap = true })

    vim.keymap.set("n", "<leader>ft", "<cmd>Telescope filetypes<cr>",
      { desc = "Change filetype", silent = true, noremap = true })

    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope spell_suggest<cr>",
      { desc = "Show spell suggest", silent = true, noremap = true })
  end,
}
