require("helper")

vim.keymap.set({'n', 'i'}, '<C-t>', '<Esc>:<C-u>lua todo()<CR>', { silent = true })
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
