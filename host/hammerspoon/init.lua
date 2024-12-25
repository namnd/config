local modifier = { 'cmd', 'shift' }

local apps = {
  ["k"] = "Ghostty",
  ["j"] = "zen Browser",
  ["l"] = "Slack",
}
for k, v in pairs(apps) do
  hs.hotkey.bind(modifier, k, function() print(hs.application.launchOrFocus(v)) end)
end
hs.hotkey.bind(modifier, "r", function() hs.reload() end)

hs.hotkey.bind(modifier, "g", function()
  local screen = hs.screen 'mi'
  if screen:name() == "Mi Monitor" then
    hs.grid.setGrid(hs.geometry.size(5, 1), screen)
    hs.grid.show()
  end
end)

-- sleep/awake menu item
local caffeine = hs.menubar.new()
function SetCaffeineDisplay(state)
  if state then
    caffeine:setIcon(hs.image.imageFromName("NSStatusAvailable"), false)
  else
    caffeine:setIcon(hs.image.imageFromName("NSStatusPartiallyAvailable"), false)
  end
end

function CaffeineClicked()
  SetCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
  caffeine:setClickCallback(CaffeineClicked)
  SetCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
CaffeineClicked()

hs.alert.show("Config reloaded")
