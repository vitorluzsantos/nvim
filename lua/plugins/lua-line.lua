return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local cyberdream_colors = require("cyberdream.colors").default

    local is_git = function()
      local git_dir = vim.fn.finddir(".git", ".;")
      return git_dir ~= nil and #git_dir > 0
    end

    local is_not_git = function()
      return not is_git()
    end

    local get_filename_with_icon = function()
      local ok, devicons = pcall(require, "nvim-web-devicons")
      local fname = vim.fn.expand("%:t")
      if fname == "" then return "" end

      if ok then
        local ext = vim.fn.expand("%:e")
        local icon = devicons.get_icon(fname, ext, { default = true })
        return (icon or "󰈙") .. " " .. fname
      end
      return fname
    end

    local custom_cyberdream = {
      normal = {
        a = { fg = cyberdream_colors.bg, bg = cyberdream_colors.blue, gui = "bold" },
        b = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg_alt },
        c = { fg = cyberdream_colors.fg, bg = "NONE" },
        x = { fg = cyberdream_colors.fg, bg = "NONE" },
        y = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg_alt },
        z = { fg = cyberdream_colors.bg, bg = cyberdream_colors.green, gui = "bold" },
      },
      insert = {
        a = { fg = cyberdream_colors.bg, bg = cyberdream_colors.green, gui = "bold" },
      },
      visual = {
        a = { fg = cyberdream_colors.bg, bg = cyberdream_colors.magenta, gui = "bold" },
      },
      replace = {
        a = { fg = cyberdream_colors.bg, bg = cyberdream_colors.red, gui = "bold" },
      },
      command = {
        a = { fg = cyberdream_colors.bg, bg = cyberdream_colors.orange, gui = "bold" },
      },
      inactive = {
        a = { fg = cyberdream_colors.grey, bg = cyberdream_colors.bg_alt },
        c = { fg = cyberdream_colors.grey, bg = "NONE" },
      },
    }

    require("lualine").setup({
      options = {
        theme = custom_cyberdream,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            function()
              return ""
            end,
            separator = { left = "", right = "" },
          },
          {
            "mode",
            separator = { left = "", right = "" },
          },
        },
        lualine_b = {
          {
            get_filename_with_icon,
            cond = is_git,
            color = { fg = cyberdream_colors.fg, bg = cyberdream_colors.bg_alt },
            separator = { left = "", right = "" },
          },
          {
            get_filename_with_icon,
            cond = is_not_git,
            color = { fg = cyberdream_colors.fg, bg = "NONE" },
            separator = { left = "", right = "" },
          },
          {
            "branch",
            icon = "",
            cond = is_git,
            color = { fg = cyberdream_colors.bg, bg = cyberdream_colors.magenta, gui = "bold" },
            separator = { left = "", right = "" },
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            "location",
            icon = "",
            separator = { left = "", right = "" },
          },
        },
      },
    })
  end,
}
