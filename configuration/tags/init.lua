local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')


local tags = {
  -- {
  --   icon = icons.chrome,
  --   type = 'chrome',
  --   defaultApp = apps.default.browser
  -- },
  {
    icon = icons.terminal,
    type = 'any',
    defaultApp = apps.default.terminal
  },
  {
    icon = icons.code,
    type = 'code',
    defaultApp = apps.default.editor
  },
  {
    icon = icons.git,
    type = 'code',
    defaultApp = apps.default.git
  },
  {
    icon = icons.lab,
    type = 'any',
    defaultApp = apps.default.rofi
  },
  {
    icon = icons.folder,
    type = 'files',
    defaultApp = apps.default.files
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating
}

local function initScreens(screen_layout)

  for i, tag in pairs(screen_layout) do
    awful.tag.add(
      i,
      {
        icon = tag.icon,
        icon_only = true,
        layout = awful.layout.suit.tile,
        gap_single_client = false,
        gap = 4,
        screen = 1,
        defaultApp = tag.defaultApp,
        selected = i == 1
      }
    )
  end
end

initScreens(tags)

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
