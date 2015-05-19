--Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

-- Put everything here, that shoud be executed at awesome startup
--awful.util.spawn_with_shell("nitrogen --restore")
run_once("mpd")
run_once("keepassx")
run_once("owncloud")
run_once("nm-applet")
run_once("icedove")
run_once("pidgin")
run_once("xrdb -merge .Xresources")
run_once("volumeicon")
run_once("udisks-glue")
-- Script for using trackpall+middel mouse button to scroll
run_once("trackscroll")
-- compose Unicode using right control key
run_once("setxkbmap -option compose:rctrl")
-- prevent Java Swing applications from fucking up because of tiling
run_once("wmname LG3D")

