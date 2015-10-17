--Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

-- awful.util.spawn_with_shell("feh --bg-scale "..os.getenv("HOME")
--     .."/.config/awesome/themes/zenburn-luxick/zenburn-background.png")

-- Put everything here, that shoud be executed at awesome startup
run_once("mpd")
run_once("compton")
run_once("keepassx")
run_once("owncloud")
run_once("telegram")
run_once("nm-applet")
run_once("thunderbird")
--run_once("pidgin")
run_once("xrdb -merge .Xresources")
run_once("volumeicon")
-- Script for using trackpall+middel mouse button to scroll
run_once("trackscroll")
run_once("trackpadtoggle")
-- prevent Java Swing applications from fucking up because of tiling
run_once("wmname LG3D")
-- compose Unicode using right ctrl key
run_once("setxkbmap -option compose:rctrl")
run_once("xrandr --output HDMI3 --primary")
run_once("disable_dpms")
run_once("redshift-gtk")