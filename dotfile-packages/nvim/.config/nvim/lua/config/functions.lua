local M = {}

function M.open_clipboard_location()
    local s = vim.fn.getreg("+"):gsub("^%s+", ""):gsub("%s+$", "")
    s = s:match("%]%((.-)%)") or s
    s = s:gsub("^file://", "")

    local path, line, col = s:match("^(.-):(%d+):?(%d*)")
    if not path then
        path, line = s:match("^(.-)#L(%d+)")
    end
    path = path or s

    vim.cmd.edit(vim.fn.fnameescape(path))
    if line then
        local l = math.min(tonumber(line), vim.api.nvim_buf_line_count(0))
        local c = math.max((tonumber(col) or 1) - 1, 0)
        pcall(vim.api.nvim_win_set_cursor, 0, { l, c })
        vim.cmd("normal! zz")
    end
end

function M.clear_mappings(mapping_table)
    for _, map in ipairs(mapping_table) do
        local modes, lhs = map[1], map[2]
        for _, mode in ipairs(modes) do
            -- pcall prevents Neovim from throwing an error if a key wasn't explicitly bound
            pcall(vim.keymap.del, mode, lhs)
        end
    end
end

-- Helper function to apply all mappings in a table
function M.apply_mappings(mapping_table, layout_name)
    for _, map in ipairs(mapping_table) do
        local modes, lhs, rhs, desc = map[1], map[2], map[3], map[4]
        vim.keymap.set(modes, lhs, rhs, {
            noremap = true,
            silent = true,
            desc = string.format("[%s] %s", layout_name:upper(), desc),
        })
    end

    _G.current_layout = layout_name
end

function M.hover_or_lookup()
    if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" }) > 0 then
        vim.lsp.buf.hover({
            border = "rounded",
        })
    else
        vim.cmd("normal! K") -- fall back to keywordprg (man, help, etc.)
    end
end

function M.goto_type()
    local src = vim.w.lsp_floating_bufnr
    if not src then
        return require("telescope.builtin").lsp_type_definitions()
    end

    -- Inside an LSP hover float: resolve the word under the cursor by name
    local float_win = vim.api.nvim_get_current_win()
    local word = vim.fn.expand("<cword>")
    local client = vim.lsp.get_clients({ bufnr = src, method = "workspace/symbol" })[1]
    if not client then
        return vim.notify("No workspace/symbol support", vim.log.levels.WARN)
    end

    client:request("workspace/symbol", { query = word }, function(err, res)
        local hits = vim.tbl_filter(function(s) return s.name == word end, (not err and res) or {})
        if #hits == 0 then
            return vim.notify("No symbol named '" .. word .. "'", vim.log.levels.WARN)
        end
        pcall(vim.api.nvim_win_close, float_win, true)
        if #hits == 1 then
            vim.lsp.util.show_document(hits[1].location, client.offset_encoding, { focus = true })
        else
            local items = vim.lsp.util.symbols_to_items(hits, src, client.offset_encoding)
            vim.fn.setqflist({}, " ", { title = "Type: " .. word, items = items })
            vim.cmd.copen()
        end
    end, src)
end

return M
