-- https://igorlfs.github.io/nvim-dap-view/home
return {
    "igorlfs/nvim-dap-view",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
        auto_toggle = true,
        windows = {
            position = "below",
            size = 0.3,
        },
        virtual_text = {
            -- Control with `DapViewVirtualTextToggle`
            enabled = true,
            -- Supported options include "inline", "eol", and "eol_right_align"
            position = "inline",
            format = function(variable)
                return " " .. variable.value
            end,
            -- Prepend the variable name (when using eol positioning)
            prefix = function(position, node, bufnr)
                if position == "eol" or position == "eol_right_align" then
                    local name = vim.treesitter.get_node_text(node, bufnr)

                    return name .. " ="
                end
            end,
            -- Add commas between variables (when using eol positioning)
            suffix = function(position, _, _, var_index, num_var_line)
                if position == "eol" or position == "eol_right_align" then
                    return var_index == num_var_line and "" or ","
                end
            end,
        },

    }
}
