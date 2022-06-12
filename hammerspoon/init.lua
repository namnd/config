local miniModifier = {'cmd', 'shift'}
local modifier = {'cmd', 'shift', 'alt', 'ctrl'}

local apps = {
  ["1"] = "kitty",
  ["2"] = "qutebrowser",
  ["3"] = "Slack",
  ["4"] = "zoom.us",
  ["0"] = "Finder",
}
for k,v in pairs(apps) do
  hs.hotkey.bind(modifier, k, function() print(hs.application.launchOrFocus(v)) end)
end
hs.hotkey.bind(modifier, "r", function() hs.reload() end)
function startNote()
  hs.execute("~/dotfiles/bin/start_note.sh", true)
  hs.application.launchOrFocus('kitty')
end
hs.hotkey.bind(modifier, "9", function() startNote() end)

function moveToOtherSpace()
  hs.execute("~/dotfiles/bin/move_to_other_space.sh", true)
end
hs.hotkey.bind(miniModifier, "m", function() moveToOtherSpace() end)

function focusMode()
  hs.execute("~/dotfiles/bin/focus_mode.sh", true)
end
hs.hotkey.bind(miniModifier, "f", function() focusMode() end)

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
