awful           = require("awful")
wibox           = require('wibox')
awful.autofocus = require("awful.autofocus")
awful.rules     = require("awful.rules")
awful.util      = require("awful.util")
beautiful       = require("beautiful")
naughty         = require("naughty")
vain            = require("vain")
vicious         = require("vicious")

-- Variable definitions
configpath      = os.getenv("HOME").."/.config/awesome/"
iconpath        = configpath.."icons/"
webbrowser      = "firefox"
filebrowser     = "nautilus"
terminal        = "/usr/bin/urxvt"
-- terminal        = "terminatior"
editor          = os.getenv("EDITOR") or "editor"
editor_cmd      = terminal .. " -e " .. editor
vain.widgets.terminal = terminal

beautiful.init(configpath.."/themes/zenburn-luxick/theme.lua")
--beautiful.init(configpath.."/themes/zenburn/theme.lua")



-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    --vain.layout.uselesstile,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

-- Tags
tags = {
    main = {1, 2, 3, 4, 5, "im", "term", "www", "mail"},
    others = {1, 2, 3, 4}
}
-- Settings for the main screen
tags[1] = awful.tag(tags.main, 1, layouts[1])

awful.layout.set(vain.layout.termfair, tags[1][7])
awful.tag.setnmaster(2, tags[1][7])
awful.tag.setncol(2, tags[1][7])

awful.layout.set(vain.layout.browse, tags[1][8])
awful.tag.setmwfact(0.5, tags[1][8])
awful.tag.setncol(1, tags[1][8])

awful.layout.set(vain.layout.browse, tags[1][9])
awful.tag.setmwfact(0.5, tags[1][9])
awful.tag.setncol(1, tags[1][9])

-- Additional screens get tags from 1-9
for s = 2, screen.count() do
    tags[s] = awful.tag(tags.others, s, layouts[1])
end

require("functions")
require("rulesandsignals")
require("wiboxes")
require("keybindings")
require("startup")

-- Set keys
root.keys(globalkeys)
