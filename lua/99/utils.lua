local M = {}
--- TODO: some people change their current working directory as they open new
--- directories.  if this is still the case in neovim land, then we will need
--- to make the _99_state have the project directory.
--- @return string
function M.random_file()
    return string.format(
        "%s/tmp/99-%d",
        vim.uv.cwd(),
        math.floor(math.random() * 10000)
    )
end

--- Wraps the given output.
---
--- It returns a table with wrapped lines using the limit of 80 columns.
--- @param output string?
--- @return (string[])
function M.wrap_output(output)
    if not output then
        return {}
    end

    local lines = {}

    for line in vim.gsplit(output, "\n") do
        local current_line = ""

        for word in vim.gsplit(line, "%s+") do
            for i, subword in ipairs(vim.split(word, "-", { plain = true })) do
                if #subword > 0 then
                    local has_hyphen = i
                        < #vim.split(word, "-", { plain = true })

                    local space = #current_line > 0 and " " or ""
                    local fits = #current_line + #space + #subword <= 80

                    if fits then
                        current_line = current_line
                            .. space
                            .. subword
                            .. (has_hyphen and "-" or "")
                    elseif has_hyphen then
                        table.insert(
                            lines,
                            current_line .. space .. subword .. "-"
                        )

                        current_line = ""
                    else
                        local available = 80 - #current_line - #space

                        if #current_line > 0 and available >= 2 then
                            local fit_chars = available - 1

                            current_line = current_line
                                .. space
                                .. vim.fn.strcharpart(subword, 0, fit_chars)
                                .. "-"

                            table.insert(lines, current_line)

                            current_line =
                                vim.fn.strcharpart(subword, fit_chars)
                        else
                            if #current_line > 0 then
                                table.insert(lines, current_line)
                            end

                            current_line = subword
                        end
                    end
                end
            end
        end

        if #current_line > 0 then
            table.insert(lines, current_line)
        end
    end

    return lines
end

return M
