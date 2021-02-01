local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')


local left = {
  {
    icon = icons.chrome,
    type = 'chrome',
    defaultApp = apps.default.browser,
    screen = 1
  },
  {
    icon = icons.folder,
    type = 'files',
    defaultApp = apps.default.files,
    screen = 1
  },
  {
    icon = icons.music,
    type = 'music',
    defaultApp = apps.default.music,
    screen = 1
  }
}

local right = {
  {
    icon = icons.terminal,
    type = 'any',
    defaultApp = apps.default.terminal,
    screen = 2
  },
  {
    icon = icons.code,
    type = 'code',
    defaultApp = apps.default.editor,
    screen = 2
  },
  {
    icon = icons.git,
    type = 'code',
    defaultApp = apps.default.git,
    screen = 2
  },
  {
    icon = icons.lab,
    type = 'any',
    defaultApp = apps.default.rofi,
    screen = 2
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating
}

local function initScreens(screen_layout, single)

  for i, tag in pairs(screen_layout) do
    awful.tag.add(
      i,
      {
        icon = tag.icon,
        icon_only = true,
        layout = awful.layout.suit.tile,
        gap_single_client = false,
        gap = 4,
        screen = single and screen[1] or screen[tag.screen],
        defaultApp = tag.defaultApp,
        selected = i == 1
      }
    )
  end
end

if (screen.count() == 1) then
  local tags = right
  for k,v in pairs(left) do 
    table.insert(tags, v)
  end
  initScreens(tags, true)
else
  initScreens(left, false)
  initScreens(right, false)
end

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)
