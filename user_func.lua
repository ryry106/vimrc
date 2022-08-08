-- local

local current_line_num = function(lnum)
  return vim.fn.getpos(lnum)[2]
end

local setline_table = function(lnum, tbl)
  local line_num = current_line_num(lnum)
  -- luaのindexは1から
  for i, v in ipairs(tbl) do
    vim.fn.setline(line_num + i - 1, v)
  end
end

local split = function(str, ts)
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
local setline_heredoc = function(heredoc)
  local tbl = split(heredoc, "\n")
  setline_table(".", tbl)
end




-- global
todo = function()
  local line = vim.fn.getline(".")
  if vim.regex("^$"):match_str(line) then
    vim.fn.setline(".","- [ ] : ")
    vim.api.nvim_command("startinsert!")
    return
  end

  if vim.regex("^- \\[ \\]"):match_str(line) then
    vim.api.nvim_command(":s/- \\[ \\]/- [x]/")
  elseif vim.regex("^- \\[x\\]"):match_str(line) then
    vim.api.nvim_command( ":s/- \\[x\\]/- [ ]/")
  else
    return
  end
  vim.api.nvim_command("noh")
end

