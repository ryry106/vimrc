vim.api.nvim_create_user_command('Gt', 'lua go_test(<f-args>)', { nargs = "?" })
go_test = function(...)
  local args = {...}
  if args[1] == "help" then
    print([[Gt <TestName>
  go test . -v
    or
  go test . -v -run TestName]])
    return
  end
  local run_opt = ""
  if #args >= 1 then
    run_opt = "-run "..args[1]
  end
  vim.api.nvim_command('!go test . -v '..run_opt)
end
