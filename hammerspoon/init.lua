local hyper = {'ctrl', 'alt', 'cmd', 'shift'}

hs.hotkey.bind(hyper, "1", function() print(hs.application.launchOrFocus('kitty')) end)
hs.hotkey.bind(hyper, "2", function() print(hs.application.launchOrFocus('Brave Browser')) end)
hs.hotkey.bind(hyper, "3", function() print(hs.application.launchOrFocus('Slack')) end)
hs.hotkey.bind(hyper, "0", function() print(hs.application.launchOrFocus('Finder')) end)
hs.hotkey.bind(hyper, "r", function() hs.reload() end)

hs.alert.show("Config reload")

-- Install spoons
hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("TextClipboardHistory")

-- clipboard history
hs.hotkey.bind(hyper, "v", function() spoon.TextClipboardHistory:toggleClipboard() end)
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
