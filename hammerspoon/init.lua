local hyper = {'ctrl', 'alt', 'cmd', 'shift'}
local miniHyper = {'cmd', 'shift'}

hs.hotkey.bind(hyper, "1", function() print(hs.application.launchOrFocus('kitty')) end)
hs.hotkey.bind(hyper, "2", function() print(hs.application.launchOrFocus('Google Chrome')) end)
hs.hotkey.bind(hyper, "3", function() print(hs.application.launchOrFocus('Slack')) end)
hs.hotkey.bind(hyper, "0", function() print(hs.application.launchOrFocus('Finder')) end)
hs.hotkey.bind(hyper, "9", function() print(hs.application.launchOrFocus('Brave Browser')) end)
hs.hotkey.bind(hyper, "r", function() hs.reload() end)

hs.alert.show("Config reload")

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
    show_clipboard = {miniHyper, "v"}
  }
})
spoon.TextClipboardHistory:start()

-- window management
hs.window.animationDuration = 0
spoon.SpoonInstall:andUse("MiroWindowsManager", {
  config = {
    sizes = {2, 3, 3/2}
  },
  hotkeys = {
    up = {hyper, "w"},
    right = {hyper, "d"},
    down = {hyper, "s"},
    left = {hyper, "a"},
    fullscreen = {hyper, "f"},
  }
})

menubar = hs.menubar.new()
menubar:setIcon(hs.image.imageFromName("NSActionTemplate"))

function code()
  local screen = hs.screen.allScreens()[1]:name()
  local windowLayout = {
    {"kitty", nil, screen, hs.layout.right70, nil, nil},
    {"Brave Browser", nil, screen, hs.layout.left30, nil, nil},
  }
  hs.layout.apply(windowLayout)
end

if menubar then
  menubar:setMenu({
    { title = "Code", fn = code },
  })
end

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
