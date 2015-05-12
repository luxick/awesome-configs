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

-- This is used later as the default terminal and editor to run.
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
    names = {1, 2, 3, 4, 5, "term", "www", "mail", "im",}
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, layouts[1])

    awful.layout.set(vain.layout.termfair, tags[s][6])
    awful.tag.setnmaster(2, tags[s][6])
    awful.tag.setncol(2, tags[s][6])

    awful.layout.set(vain.layout.browse, tags[s][7])
    awful.tag.setmwfact(0.5, tags[s][2])
    awful.tag.setncol(1, tags[s][7])

    awful.layout.set(vain.layout.browse, tags[s][8])
    awful.tag.setmwfact(0.5, tags[s][2])
    awful.tag.setncol(1, tags[s][8])
end

require("functions")
require("menu")
require("keybindings")
require("wiboxes")
require("startup")
require("rulesandsignals")
-- Set keys
root.keys(globalkeys)
