-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
--      modified by luxick   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
theme = {}
theme.wallpaper = { os.getenv("HOME").."/.config/awesome/themes/zenburn-luxick/zenburn-background-new.png" }
theme.tasklist_disable_icon = true
-- }}}

-- {{{ Styles
theme.font      = "Terminus 8"
theme.useless_gap_width = 10

-- {{{ Colors
theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#00FFFF"
theme.fg_urgent = "#CC9393"
theme.bg_urgent = "#3F3F3F"

theme.bg_normal = "#202020"
theme.bg_focus  = "#202020"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#00FFFF"
theme.border_marked = "#CC9393"

-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "100"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/taglist/squarefz.png"
theme.taglist_squares_unsel = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/awesome-icon.png"
theme.menu_submenu_icon      = os.getenv("HOME") .. "/.config/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = os.getenv("HOME") .. "/.config/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile          = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/tile.png"
theme.layout_tileleft      = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/tileleft.png"
theme.layout_tilebottom    = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/tilebottom.png"
theme.layout_tiletop       = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/tiletop.png"
theme.layout_fairv         = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/fairv.png"
theme.layout_fairh         = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/fairh.png"
theme.layout_spiral        = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/spiral.png"
theme.layout_dwindle       = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/dwindle.png"
theme.layout_max           = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/max.png"
theme.layout_fullscreen    = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/fullscreen.png"
theme.layout_magnifier     = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/magnifier.png"
theme.layout_floating      = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/layouts/floating.png"
theme.layout_termfair      = os.getenv("HOME") .. "/.config/awesome/vain/themes/zenburn/layouts/termfair.png"
theme.layout_browse        = os.getenv("HOME") .. "/.config/awesome/vain/themes/zenburn/layouts/browse.png"
theme.layout_gimp          = os.getenv("HOME") .. "/.config/awesome/vain/themes/zenburn/layouts/gimp.png"
theme.layout_cascade       = os.getenv("HOME") .. "/.config/awesome/vain/themes/zenburn/layouts/cascade.png"
theme.layout_cascadebrowse = os.getenv("HOME") .. "/.config/awesome/vain/themes/zenburn/layouts/cascadebrowse.png"
theme.layout_centerwork    = os.getenv("HOME") .. "/.config/awesome/vain/themes/zenburn/layouts/centerwork.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/close_focus.png"
theme.titlebar_close_button_normal = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = os.getenv("HOME") .. "/.config/awesome/themes/zenburn-luxick/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
