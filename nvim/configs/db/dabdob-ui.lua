local M = {}

M.init = function()
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_show_database_icon = 1
  vim.g.db_ui_force_echo_notifications = 1
  vim.g.db_ui_win_position = "left"
  vim.g.db_ui_winwidth = 80
  vim.g.db_ui_auto_execute_table_helpers = 1
  vim.g.db_ui_execute_on_save = 0
  vim.g.db_ui_use_nvim_notify = 1

  vim.g.db_ui_table_helpers = {
    postgresql = {
      _Count = "SELECT count(*) FROM {optional_schema}{table}",
      _Describe = [[\d {optional_schema}{table}]],
      _List = "SELECT * FROM {optional_schema}{table} LIMIT 10",
    },
  }
  vim.g.db_ui_hide_schemas = {
    -- Postgres
    "information_schema",
    "pg_catalog",
    "pg_toast",
  }

  vim.g.db_ui_icons = {
    expanded = {
      db = "▾ ",
      buffers = "▾ ",
      saved_queries = "▾ ",
      schemas = "▾ ",
      schema = "▾ פּ",
      tables = "▾ 藺",
      table = "▾ ",
    },
    collapsed = {
      db = "▸ ",
      buffers = "▸ ",
      saved_queries = "▸ ",
      schemas = "▸ ",
      schema = "▸ פּ",
      tables = "▸ 藺",
      table = "▸ ",
    },
    saved_query = "",
    new_query = "璘",
    tables = "離",
    buffers = "﬘",
    add_connection = "",
    connection_ok = "✓",
    connection_error = "✕",
  }
end

return M
