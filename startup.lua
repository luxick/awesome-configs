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


awful.util.spawn_with_shell("xrdb -merge .Xresources")
awful.util.spawn_with_shell("wmname LG3D")
awful.util.spawn_with_shell("setxkbmap -option compose:rctrl")
awful.util.spawn_with_shell("xrandr --output HDMI3 --primary")
awful.util.spawn_with_shell("disable_dpms")
awful.util.spawn_with_shell("touchpadcontrol deactivate")


awful.util.spawn_with_shell("run_once mpd")
awful.util.spawn_with_shell("run_once compton")
awful.util.spawn_with_shell("run_once owncloud")
awful.util.spawn_with_shell("run_once telegram")
awful.util.spawn_with_shell("run_once nm-applet")
awful.util.spawn_with_shell("run_once thunderbird-beta")
awful.util.spawn_with_shell("run_once firefox")
awful.util.spawn_with_shell("run_once volumeicon")
awful.util.spawn_with_shell("run_once redshift-gtk")

update_wallpaper()
