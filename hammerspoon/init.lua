local modifier = {'cmd', 'shift'}

hs.hotkey.bind(modifier, "r", function() hs.reload() end)
hs.hotkey.bind(modifier, "g", function() print(hs.application.launchOrFocus('Firefox')) end)

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
