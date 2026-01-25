local M = {}
--- TODO: some people change their current working directory as they open new
--- directories.  if this is still the case in neovim land, then we will need
--- to make the _99_state have the project directory.
--- @return string
function M.random_file()
  local filename = string.format(
    "%s/99-%d",
    vim.uv.os_tmpdir(),
    math.floor(math.random() * 10000)
  )

  vim.fn.writefile({}, filename)
  return filename
end

return M
