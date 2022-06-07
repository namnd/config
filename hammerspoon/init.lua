local modifier = {'cmd', 'shift', 'alt', 'ctrl'}

local apps = {
  f = "Firefox",
  k = "kitty",
  s = "Safari",
  m = "Slack",
  z = "zoom.us",
}
for k,v in pairs(apps) do
  hs.hotkey.bind(modifier, k, function() print(hs.application.launchOrFocus(v)) end)
end
hs.hotkey.bind(modifier, "r", function() hs.reload() end)
function startNote()
  hs.execute("~/dotfiles/bin/start_note.sh", true)
  hs.application.launchOrFocus('kitty')
end
hs.hotkey.bind(modifier, "n", function() startNote() end)

-- Install spoons
hs.loadSpoon("SpoonInstall")

-- sleep/awake menu item
caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
  if state then
    caffeine:setIcon(hs.image.imageFromName("NSStatusAvailable"), false)
  else
    caffeine:setIcon(hs.image.imageFromName("NSStatusPartiallyAvailable"), false)
  end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
caffeineClicked()

hs.alert.show("Config reloaded")
