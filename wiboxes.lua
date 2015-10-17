-- Create a wibox for each screen and add it
mytopbox = {}
mybottombox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}


mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do

    -- Top Wibox
    -- Create a textclock widget
    mytextclock = awful.widget.textclock("|%H:%M " .. '<span color="' .. beautiful.fg_focus .. '">%d/%m/%y</span>|', 10)

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags,
        mytasklist.buttons)

    -- Bottom Wibox
    -- {{{CPU and RAM Widgets
    cpuwidget = wibox.widget.textbox()
    vicious.register(cpuwidget, vicious.widgets.cpu,
        "cpu:" .. '<span color="' .. beautiful.fg_focus .. '">$1%</span>|', 3)

    ramwidget = wibox.widget.textbox()
    vicious.register(ramwidget, vicious.widgets.mem,
        "ram:" .. '<span color="' .. beautiful.fg_focus .. '">$1%</span>|', 3)

    thermalwidget  = wibox.widget.textbox()
    vicious.register(thermalwidget, vicious.widgets.thermal,
    "temp:" .. '<span color="' .. beautiful.fg_focus .. '">$1°C</span>|', 3, "thermal_zone0")
    -- }}}

    -- Battery Widget
    battext = wibox.widget.textbox()
    vicious.register(battext, vicious.widgets.bat,
        function(widget, args)
            if args[3] == "N/A" then
                return 'batt:<span color="' .. beautiful.fg_focus .. '">'.. args[2]..'%</span>' .. '|'
            elseif args[2] == "100" then
                return args[1] .. '|'
            else
                return 'bat:<span color="' .. beautiful.fg_focus .. '">'.. args[2]..'%</span>' ..'|'
                        .. args[1]..'<span color="' .. beautiful.fg_focus .. '">'..args[3]..'</span>' .. '|'
            end
        end, 1, "BAT0")

    -- Show Wifi SSID
    mywifissid = wibox.widget.textbox()
    vicious.register(mywifissid, vicious.widgets.wifi,
        function (widget, args)
            if args["{ssid}"] == "N/A" then
                return ''
            else
                return 'ssid:' .. "<span color='" .. beautiful.fg_focus .. "'>" .. args["{ssid}"] .. "</span>|"
            end
        end, 3, "wlp3s0")

    -- {{{ File System Widget
    fswidget = wibox.widget.textbox()
    vicious.register(fswidget, vicious.widgets.fs,
    "disk:" .. "<span color='" .. beautiful.fg_focus .. "'>" .. "${/ used_p}%".. "</span>|", 60)
    ubaywidget = wibox.widget.textbox()
    vicious.register(ubaywidget, vicious.widgets.fs,
    "ubay:" .. "<span color='" .. beautiful.fg_focus .. "'>" .. "${/mnt/ultrabay used_p}%".. "</span>|", 60)
    -- }}}

    -- {{{ Network usage
    function print_net(name, down, up)
        return name .. ':' ..'↓<span color="'
        .. beautiful.fg_focus ..'">' .. down .. ' MB/s'.. '</span> ↑<span color="'
        .. beautiful.fg_focus ..'">' .. up  .. ' MB/s'.. '</span>|'
    end
    -- Initialize widget
   netwidget = wibox.widget.textbox()
    -- Register widget
    vicious.register(netwidget, vicious.widgets.net,
    function (widget, args)
        local ethdown = args["{enp0s25 down_mb}"]
        local ethup = args["{enp0s25 up_mb}"]
        local ethactive = (tonumber(args["{enp0s25 carrier}"]) == 1)
        local wifidown = args["{wlp3s0 down_mb}"]
        local wifiup = args["{wlp3s0 up_mb}"]
        local wifiactive = (tonumber(args["{wlp3s0 carrier}"]) == 1)

        local down = ethdown
        local up = ethup
        local ifname = "wired"
        if (not ethactive and wifiactive) then
            down = wifidown
            up = wifiup
            ifname = "wifi"
        end
        return print_net(ifname, down, up)
    end, 3)
    -- }}}

    -- {{{ MPD Widget
    mpdwidget = wibox.widget.textbox()
    -- Register widget
    vicious.register(mpdwidget, vicious.widgets.mpd,
        function (widget, args)
            if args["{state}"] == "N/A" then
                return "|"
            end
            if args["{state}"] == "Stop" then
                return "|"
            elseif args["{Artist}"] == "N/A" then
                return '|mpd:' .. "<span color='" .. beautiful.fg_focus .. "'>" .. args["{Title}"] .. "</span>|"
            else
                return '|mpd:' .. "<span color='" .. beautiful.fg_focus .. "'>" .. args["{Artist}"]..' - '
                .. args["{Title}"] .. "</span>|"
            end
        end, 1)
    -- }}}

    -- Create the Topbox
    mytopbox[s] = awful.wibox({ position = "top", screen = s })
    -- Create Bottombox
    mybottombox[s] = awful.wibox({ position = "bottom", screen = s})

    -- Top Boxes
    local top_layout_left = wibox.layout.fixed.horizontal()
    if s == 1 then top_layout_left:add(wibox.widget.textbox("|")) end
    if s == 1 then top_layout_left:add(wibox.widget.systray()) end
    top_layout_left:add(mytextclock)

    -- Bottom Boxes
    local bottom_layout_left = wibox.layout.fixed.horizontal()
    bottom_layout_left:add(mytaglist[s])
    bottom_layout_left:add(mypromptbox[s])

    local bottom_layout_right = wibox.layout.fixed.horizontal()
    bottom_layout_right:add(mpdwidget)
    bottom_layout_right:add(mywifissid)
    bottom_layout_right:add(netwidget)
    bottom_layout_right:add(fswidget)
    bottom_layout_right:add(ubaywidget)
    bottom_layout_right:add(ramwidget)
    bottom_layout_right:add(cpuwidget)
    bottom_layout_right:add(thermalwidget)
    bottom_layout_right:add(battext)

    -- Bring Top Box Together
    local top_layout = wibox.layout.align.horizontal()
    --top_layout:set_left(mylayoutbox[s])
    top_layout:set_middle(mytasklist[s])
    top_layout:set_right(top_layout_left)

    -- Bring Bottom Box Together
    local bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_layout_left)
    if s == 1 then bottom_layout:set_right(bottom_layout_right) end

    -- Add widgets to the Topbox
    mytopbox[s]:set_widget(top_layout)
    -- Add Widgets to Bottombox
    mybottombox[s]:set_widget(bottom_layout)

end
