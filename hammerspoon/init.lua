local modifier = {'cmd', 'shift'}

hs.hotkey.bind('cmd', "return", function() print(hs.application.launchOrFocus('kitty')) end)
hs.hotkey.bind(modifier, "r", function() hs.reload() end)

-- Install spoons
hs.loadSpoon("SpoonInstall")

-- clipboard history
spoon.SpoonInstall:andUse("TextClipboardHistory", {
  config = {
    hist_size = 1000,
    paste_on_select = true,
    show_in_menubar = false,
  },
  hotkeys = {
    show_clipboard = {modifier, "v"}
  }
})
spoon.TextClipboardHistory:start()

spoon.SpoonInstall:andUse("PasswordGenerator", {
  config = {
    password_style = 'xkcd',
    word_separators = '$',
    word_uppercase = 2,
    word_count = 2,
  },
  hotkeys = {
    copy = {modifier, "p"}
  }
})

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

