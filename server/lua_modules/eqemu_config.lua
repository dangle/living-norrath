local json = require('lunajson')

local function parse_json_file(filename)
  local file = io.open(filename, "rb")
  if not file then
    error("unable to open file: " .. filename)
  end

  local content = file:read("*a")
  file:close()

  local data = json.decode(content)

  return data
end

local lua_modules_dir = debug.getinfo(1).source:match("@?(.*/)")
local config = parse_json_file(lua_modules_dir .. "/../eqemu_config.json")

return config
