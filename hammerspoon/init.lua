spaces = require("hs._asm.undocumented.spaces")

local hyper = {'ctrl', 'alt', 'cmd', 'shift'}
local miniHyper = {'cmd', 'shift'}

hs.hotkey.bind(miniHyper, "return", function() print(hs.application.launchOrFocus('kitty')) end)
hs.hotkey.bind(miniHyper, "g", function() print(hs.application.launchOrFocus('Google Chrome')) end)
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

spoon.SpoonInstall:andUse("PasswordGenerator", {
  config = {
    password_style = 'xkcd',
    word_separators = '$',
    word_uppercase = 2,
    word_count = 2,
  },
  hotkeys = {
    copy = {hyper, "g"}
  }
})

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

function code(ratio)
  local screen = hs.screen.allScreens()[1]
  local screenWidth = screen:fullFrame().w
  local screenHeight = screen:fullFrame().h
  local width = screenWidth * ratio
  local x = screenWidth - width
  local windowLayout = {
    {"kitty", nil, screen:name(), nil, hs.geometry.rect(x, 0, width, screenHeight), nil},
    {"Google Chrome", nil, screen:name(), nil, hs.geometry.rect(0, 0, x, screenHeight), nil},
  }
  hs.layout.apply(windowLayout)
end
hs.hotkey.bind(hyper, "2", function() code(1/2) end)
hs.hotkey.bind(hyper, "3", function() code(3/5) end)

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

-- workspaces menu
local workspaces = {}
function workspaceLabel(index)
  if index == spaces.currentSpace() then
    return index .. "°"
  end
  return index
end
function setWorkspaceMenu()
  local allSpaces = spaces.query()
  local spacesCount = spaces.count()
  for k,v in pairs(allSpaces) do
    local i = spacesCount - k + 1
    if workspaces[i] == nil then
      workspaces[i] = hs.menubar.new()
    end
    workspaces[i]:setTitle(workspaceLabel(i))
  end
end
setWorkspaceMenu()
spacesWatcher = hs.spaces.watcher.new(setWorkspaceMenu)
spacesWatcher:start()
