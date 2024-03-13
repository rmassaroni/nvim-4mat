local function add_lsqlite3_to_path()
    local plugin_dir = vim.fn.expand("<sfile>:p:h") -- Get the directory of the current Lua file
    local lsqlite3_path = plugin_dir .. "/../deps/lua-lsqlite3/?.lua"
    package.path = package.path .. ";" .. lsqlite3_path
end

-- Call the function to add lsqlite3 to the Lua package path
add_lsqlite3_to_path()

-- Imports the module for handling SQLite.
local sqlite = require("lua-ljsqlite3")

-- Creates an object for the module.
local M = {}

-- Fetches todo tasks from the database and
-- prints the output.
function M.fetch_todos()
    local db = sqlite.open("todo.db")

    local db_results = db:exec("SELECT * FROM todo_list WHERE completed == 'No';")
    for _, item in ipairs(db_results[2]) do print(item) end

    db:close()
end

return M
