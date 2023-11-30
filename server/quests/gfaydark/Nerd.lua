GptNpc = require("gpt_npc")

local Nerd = nil
local lore = [[
  You are an Erudite living in the world of Norrath.
  You are from the city of Erudin.
  You are in the forest of Greater Faydark.
  You are on the ground below the city of Kelethin, next to a large tree.
]]

function event_spawn(e)
  if Nerd == nil then
    Nerd = GptNpc(e.self, lore)
  end
end

function event_say(e)
  Nerd:chat(e)
end

function event_trade(e)
  local item_lib = require("items");
  item_lib.return_items(e.self, e.other, e.trade)
end
