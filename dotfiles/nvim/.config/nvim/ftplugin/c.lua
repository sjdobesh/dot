local function findmakefile()
  if vim.loop.fs_stat("Makefile") or vim.loop.fs_stat("makefile") then
    return "make"
  else
    return "gcc % && ./a.out"
  end
end
vim.opt_local.makeprg = findmakefile()
vim.opt_local.errorformat = "%f:%l:%c:%m"
