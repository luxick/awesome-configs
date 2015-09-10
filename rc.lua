awful           = require("awful")
wibox           = require('wibox')
awful.autofocus = require("awful.autofocus")
awful.rules     = require("awful.rules")
awful.util      = require("awful.util")
beautiful       = require("beautiful")
naughty         = require("naughty")
lain            = require("lain")
--vain            = require("vain")
vicious         = require("vicious")
blingbling		= require("blingbling")

-- Variable definitions
configpath      = os.getenv("HOME").."/.config/awesome/"
iconpath        = configpath.."icons/"
networks        = {'eth0','wlan0'}
webbrowser      = "firefox"
filebrowser     = "thunar"
terminal        = "/usr/bin/urxvt"
editor          = os.getenv("EDITOR") or "editor"
editor_cmd      = terminal .. " -e " .. editor

beautiful.init(configpath.."/themes/zenburn-luxick/theme.lua")


-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    lain.layout.uselesstile,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    --awful.layout.suit.floating
}

-- Tags
tags = {
    main = {1, 2, 3, 4, 5, 6, "term", "www", "mail"},
    others = {1, 2, 3, 4,}
}
-- Settings for the main screen
tags[1] = awful.tag(tags.main, 1, layouts[1])
awful.layout.set(lain.layout.uselessfair, tags[1][7])
awful.tag.setnmaster(2, tags[1][7])
awful.tag.setncol(2, tags[1][7])

awful.layout.set(awful.layout.suit.tile, tags[1][8])
--awful.tag.setmwfact(0.5, tags[1][2])
--awful.tag.setncol(1, tags[1][7])

awful.layout.set(awful.layout.suit.tile, tags[1][9])
--awful.tag.setmwfact(0.5, tags[1][2])
--awful.tag.setncol(1, tags[1][8])

-- Additional screens get tags from 1-9
for s = 2, screen.count() do
    tags[s] = awful.tag(tags.others, s, layouts[1])
end

require("functions")
require("keybindings")
require("wiboxes")
require("startup")
require("rulesandsignals")

-- Set keys
root.keys(globalkeys)
