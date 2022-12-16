current_line_num = function(lnum)
  return vim.fn.getpos(lnum)[2]
end

local setline_table = function(lnum, tbl)
  local line_num = current_line_num(lnum)
  -- luaのindexは1から
  for i, v in ipairs(tbl) do
    vim.fn.setline(line_num + i - 1, v)
  end
end

split = function(str, ts)
  -- 引数がないときは空tableを返す
  if ts == nil then return {} end

  local t = {} ;
  i=1
  for s in string.gmatch(str, "([^"..ts.."]+)") do
    t[i] = s
    i = i + 1
  end

  return t
end

-- ヒアドキュメントの改行が@^に変換されてしまうため
-- :h NL-used-for-NUL
setline_heredoc = function(heredoc)
  local tbl = split(heredoc, "\n")
  setline_table(".", tbl)
end

get_runtimepath_table = function()
  return split(vim.api.nvim_get_option('runtimepath'), ",")
end

is_currentdir_in_runtimepath = function()
  local current_dir = vim.fn.getcwd()
  for k, v in ipairs(get_runtimepath_table()) do
    if v == current_dir then
      return true
    end
  end
  return false
end

local is_exists_dir_currentdir = function(search)
  return vim.fn.finddir(search) == search
end
