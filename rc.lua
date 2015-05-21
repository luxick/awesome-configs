-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Load Debian menu entries
require("debian.menu")
require("vain")
require("vicious")

-- Variable definitions
configpath="/home/"..os.getenv("USER").."/.config/awesome/"
iconpath= configpath.."icons/"
beautiful.init(configpath.."/themes/zenburn-luxick/theme.lua")
networks = {'eth0','wlan0'}
webbrowser = "firefox"
filebrowser = "thunar"
terminal = "/usr/bin/urxvt"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

-- Tags
tags = {
    main = {1, 2, 3, 4, 5, "term", "www", "mail", "im",},
    others = {1, 2, 3, 4, 5, 6, 7, 8, 9,}
}
-- Settings for the main screen
tags[1] = awful.tag(tags.main, 1, layouts[1])
awful.layout.set(vain.layout.termfair, tags[1][6])
awful.tag.setnmaster(2, tags[1][6])
awful.tag.setncol(2, tags[1][6])

awful.layout.set(vain.layout.browse, tags[1][7])
awful.tag.setmwfact(0.5, tags[1][2])
awful.tag.setncol(1, tags[1][7])

awful.layout.set(vain.layout.browse, tags[1][8])
awful.tag.setmwfact(0.5, tags[1][2])
awful.tag.setncol(1, tags[1][8])

-- Additional screens get tags from 1-9
for s = 2, screen.count() do
    tags[s] = awful.tag(tags.others, s, layouts[1])
end

require("functions")
require("menu")
require("keybindings")
require("wiboxes")
require("startup")
require("rulesandsignals")
-- Set keys
root.keys(globalkeys)
