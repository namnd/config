local modifier = {'ctrl', 'shift'}

local apps = {
  ["1"] = "kitty",
  ["2"] = "qutebrowser",
  ["3"] = "Slack",
  ["0"] = "Finder",
}
for k,v in pairs(apps) do
  hs.hotkey.bind(modifier, k, function() print(hs.application.launchOrFocus(v)) end)
end
hs.hotkey.bind(modifier, "r", function() hs.reload() end)

-- Install spoons
hs.loadSpoon("SpoonInstall")

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
