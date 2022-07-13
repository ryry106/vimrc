function! Todo()
  let s:linesrc = getline(".")
  if s:linesrc =~ "^$"
    call setline(".","- [ ] : ")
    startinsert!
    return
  endif

  if s:linesrc =~ "^- \\[ \\]"
    let s:cmd = ":s/- \\[ \\]/- [x]/"
  elseif s:linesrc =~ "^- \\[x\\]"
    let s:cmd = ":s/- \\[x\\]/- [ ]/"
  else
    return
  endif
  execute s:cmd
  execute ":noh"
endfunction


function! TemplateGoTest()
  let s:text =<< END
func TestExec(t *testing.T) {
  tests := []struct{
    name string
    expect  string
  }{
    {
      name: "test name",
      expect: "",
    },
  }

  for _, tt := range tests {
    actucl := Exec()
    if actucl != tt.expect {
      t.Error("# " + tt.name)
      t.Error("--- expect : " + tt.expect)
      t.Error("--- actual : " + actucl)
    }
  }
}
END
  call append('.', s:text)
endfunction

