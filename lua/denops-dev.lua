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
