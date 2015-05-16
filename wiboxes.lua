-- Create a wibox for each screen and add it
mytopbox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mybottombox = {}

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
    mytextclock = awful.widget.textclock({ align = "right" })
    -- Create a systray
    mysystray = widget({ type = "systray" })

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Bottom Wibox
    -- CPU and RAM Widgets
    mycpuusage = vain.widgets.cpuusage()
    mymemusage = vain.widgets.memusage()

    -- Battery Widget
    battext = widget({ type = "textbox" })
    vicious.register(battext, vicious.widgets.bat, '$1 ' .. '<span color="' .. beautiful.fg_focus
    .. '">$2%</span>', 61, "BAT0")

    -- Show Wifi SSID
    mywifissid = widget({ type = "textbox"})
    vicious.register(mywifissid, vicious.widgets.wifi,
        function (widget, args)
            if args["{ssid}"] == "N/A" then
                return ""
            else
                return 'wifi: ' .. "<span color='" .. beautiful.fg_focus .. "'>" .. args["{ssid}"] .. "</span> "
            end
        end, 3, "wlan0")

       
    -- {{{ Network usage
    function print_net(name, down, up)
        return name .. ': ' ..'↓<span color="'
        .. beautiful.fg_focus ..'">' .. down .. ' KB/s'.. '</span> ↑<span color="'
        .. beautiful.fg_focus ..'">' .. up  .. ' KB/s'.. '</span> '
    end

    dnicon = widget({ type = "imagebox" })
    upicon = widget({ type = "imagebox" })

    -- Initialize widget
    netwidget = widget({ type = "textbox" })
    -- Register widget
    vicious.register(netwidget, vicious.widgets.net,
        function (widget, args)
            for _,device in pairs(networks) do
                if tonumber(args["{".. device .." carrier}"]) > 0 then
                    netwidget.found = true
                    dnicon.image = image(beautiful.widget_net)
                    upicon.image = image(beautiful.widget_netup)
                    return print_net(device, args["{"..device .." down_kb}"], args["{"..device.." up_kb}"])
                end
            end
        end, 3)
    -- }}}

    -- {{{ MPD Widget
    mpdwidget = widget({ type = "textbox" })
    -- Register widget
    vicious.register(mpdwidget, vicious.widgets.mpd,
        function (widget, args)
            if args["{state}"] == "Stop" then 
                return ""
            else 
                return 'mpd: ' .. "<span color='" .. beautiful.fg_focus .. "'>" .. args["{Artist}"]..' - '
                .. args["{Title}"] .. "</span>   "
            end
        end, 2)
    -- }}}
    
    -- Create the Topbox
    mytopbox[s] = awful.wibox({ position = "top", screen = s })

    -- Add widgets to the Topbox - order matters
    mytopbox[s].widgets = {
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

    -- Create Bottombox
    mybottombox[s] = awful.wibox({ position = "bottom", screen = s})

    -- Add Widgets to Bottombox
    mybottombox[s].widgets = {
        {
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        battext,
        mycpuusage,
        mymemusage,
        netwidget,
        mywifissid,
        mpdwidget,
        layout = awful.widget.layout.horizontal.rightleft
    }

end
