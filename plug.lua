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

local get_runtimepath_table = function()
  return split(vim.api.nvim_get_option('runtimepath'), ",")
end

local is_currentdir_in_runtimepath = function()
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


set_denops_dev = function()
  if is_currentdir_in_runtimepath() then
    return
  end

  if is_exists_dir_currentdir("denops") then
    vim.api.nvim_command('set runtimepath^=' .. vim.fn.getcwd())
    vim.api.nvim_command('let g:denops#debug = 1')
    print("[user_func.lua]sat runtimepath currentdir.")
  end
end

snippet = function(name)

  snippets = {
    denotest = [[
Deno.test("name", () => {
})
]],
    runsh = [[
#!/bin/bash
subcommand="$1"
shift

case $subcommand in
    foo)
        echo "foo"
        ;;
    help)
        echo "./run.sh [subcommand]"
        echo "subcommand list"
        echo "  - cmd : description."
        ;;
    *)
        echo "default"
        ;;
esac
]],
  }

  res = snippets[name]
  if res == nil then
    for k, v in pairs(snippets) do
      print(k)
    end
  else
    setline_heredoc(res)
  end
end
