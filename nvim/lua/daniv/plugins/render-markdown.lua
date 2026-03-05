return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      file_types = { "markdown" },
      heading = {
        enabled = true,
        icons = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " },
        position = "inline",
        width = "block",
        border = false,
      },
      bullet = {
        enabled = true,
        icons = { "✦", "◆", "▶", "•" },
        left_pad = 0,
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
        bullet = true,
        left_pad = 0,
        right_pad = 1,
        unchecked = {
          icon = "☐ ",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = {
          icon = "☑ ",
          highlight = "RenderMarkdownChecked",
        },
        custom = {
          todo = {
            raw = "[-]",
            rendered = "◪ ",
            highlight = "RenderMarkdownTodo",
          },
          in_progress = {
            raw = "[~]",
            rendered = "◔ ",
            highlight = "RenderMarkdownWarn",
          },
          cancelled = {
            raw = "[/]",
            rendered = "✗ ",
            highlight = "RenderMarkdownError",
          },
        },
      },
      code = {
        enabled = true,
        sign = false,
        language = true,
        position = "left",
        language_icon = true,
        language_name = true,
        language_pad = 2,
        width = "full",
        left_margin = 0,
        left_pad = 3,
        right_pad = 3,
        border = "thick",
        language_border = "█",
        inline = true,
        inline_pad = 2,
      },
      quote = {
        icon = "▋",
        repeat_linebreak = true,
      },
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 NOTE", highlight = "RenderMarkdownInfo", category = "github", quote_icon = "▎" },
        tip = { raw = "[!TIP]", rendered = "󰌶 TIP", highlight = "RenderMarkdownSuccess", category = "github", quote_icon = "▎" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 IMPORTANT", highlight = "RenderMarkdownHint", category = "github", quote_icon = "▎" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 WARNING", highlight = "RenderMarkdownWarn", category = "github", quote_icon = "▎" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 CAUTION", highlight = "RenderMarkdownError", category = "github", quote_icon = "▎" },
        abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 ABSTRACT", highlight = "RenderMarkdownInfo", category = "obsidian", quote_icon = "▎" },
        summary = { raw = "[!SUMMARY]", rendered = "󰨸 SUMMARY", highlight = "RenderMarkdownInfo", category = "obsidian", quote_icon = "▎" },
        tldr = { raw = "[!TLDR]", rendered = "󰨸 TLDR", highlight = "RenderMarkdownInfo", category = "obsidian", quote_icon = "▎" },
        info = { raw = "[!INFO]", rendered = "󰋽 INFO", highlight = "RenderMarkdownInfo", category = "obsidian", quote_icon = "▎" },
        todo = { raw = "[!TODO]", rendered = "󰗡 TODO", highlight = "RenderMarkdownInfo", category = "obsidian", quote_icon = "▎" },
        hint = { raw = "[!HINT]", rendered = "󰌶 HINT", highlight = "RenderMarkdownSuccess", category = "obsidian", quote_icon = "▎" },
        success = { raw = "[!SUCCESS]", rendered = "󰄬 SUCCESS", highlight = "RenderMarkdownSuccess", category = "obsidian", quote_icon = "▎" },
        check = { raw = "[!CHECK]", rendered = "󰄬 CHECK", highlight = "RenderMarkdownSuccess", category = "obsidian", quote_icon = "▎" },
        done = { raw = "[!DONE]", rendered = "󰄬 DONE", highlight = "RenderMarkdownSuccess", category = "obsidian", quote_icon = "▎" },
        question = { raw = "[!QUESTION]", rendered = "󰘥 QUESTION", highlight = "RenderMarkdownWarn", category = "obsidian", quote_icon = "▎" },
        help = { raw = "[!HELP]", rendered = "󰘥 HELP", highlight = "RenderMarkdownWarn", category = "obsidian", quote_icon = "▎" },
      },
      win_options = {
        showbreak = {
          default = "",
          rendered = "  ",
        },
        breakindent = {
          default = false,
          rendered = true,
        },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nc"
        end,
      })
    end,
  },
}
