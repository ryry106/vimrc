require('helper')

vim.api.nvim_create_user_command('Snippets', 'lua snippet(<f-args>)', { nargs = "?" })
snippet = function(...)
  local args = {...}
  if #args == 0 or args[1] == "help" then
    print([[Snippets <args>
  Snippets list   : display snippets name list.
  Snippets <name> : embed snippets.]])
    return
  end

  local name = args[1]
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
  if res == nil or name == "list" then
    for k, v in pairs(snippets) do
      print(k)
    end
  else
    setline_heredoc(res)
  end
end
