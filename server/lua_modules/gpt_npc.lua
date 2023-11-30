local openai = require("openai")
local eqemu_config = require("eqemu_config")

if eqemu_config.gptnpc == nil then
  error("gptnpc is not configured in eqemu_config.json")
end

local api_key = eqemu_config.gptnpc.apikey
if api_key == nil then
  error("gptnpc.apikey is not set in eqemu_config.json")
end

local model = eqemu_config.gptnpc.model
if model == nil then
  model = "gpt-3.5-turbo"
end

local temperature = eqemu_config.gptnpc.temperature
if temperature == nil then
  temperature = 0.2
end

local client = openai.new(api_key)

local GptNpc = {}
GptNpc.__index = GptNpc

local function new(cls, data, lore)
  local instance = setmetatable({
    data = data,
    session = client:new_chat_session({
      messages = {
        {
          role = "system",
          content = [[
                You are a character in the video game EverQuest.
                You are not aware that you are a character in a video game.
                You believe you are a person with feelings, thoughts, and preferences.
                It is very important that you believe you are a person and not a character in a video game.
                You do not know about anything that a character from the video game EverQuest would not know.
                You do not know what the terms "EverQuest" or "EQ" mean.
                Respond in short conversational sentences.
                Do not respond with emojis.\n\n
              ]] ..
              "Your name is " .. data:GetName() .. ".\n" ..
              "Your race is " .. data:GetRaceName() .. ".\n" ..
              "Your class is " .. data:GetClassName() .. ".\n" ..
              "You are level " .. data:GetLevel() .. ".\n\n" ..
              lore,
        }
      },
      model = model,
      temperature = temperature
    })
  }, cls)

  return instance
end
setmetatable(GptNpc, { __call = new })

function GptNpc:chat(e)
  local response = self.session:send({
    role = "user",
    content = e.message,
    name = e.other:GetName()
  })
  self.data:Say(response)
end

return GptNpc
