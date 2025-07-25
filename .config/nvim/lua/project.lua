local M = {}

-- Godot project setup.
local paths_to_check = { "/", "/../" }
M.is_godot_project = false
M.godot_project_path = ""
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for _, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    M.is_godot_project = true
    M.godot_project_path = cwd .. value
    break
  end
end

return M
