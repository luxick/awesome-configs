function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- {{{ Display Switching
-- Get active outputs
local function outputs()
   local outputs = {}
   local xrandr = io.popen("xrandr -q")
   if xrandr then
      for line in xrandr:lines() do
	 output = line:match("^([%w-]+) connected ")
	 if output then
	    outputs[#outputs + 1] = output
	 end
      end
      xrandr:close()
   end

   return outputs
end

local function arrange(out)
   -- We need to enumerate all the way to combinate output. We assume
   -- we want only an horizontal layout.
   local choices  = {}
   local previous = { {} }
   for i = 1, #out do
      -- Find all permutation of length `i`: we take the permutation
      -- of length `i-1` and for each of them, we create new
      -- permutations by adding each output at the end of it if it is
      -- not already present.
      local new = {}
      for _, p in pairs(previous) do
	 for _, o in pairs(out) do
	    if not awful.util.table.hasitem(p, o) then
	       new[#new + 1] = awful.util.table.join(p, {o})
	    end
	 end
      end
      choices = awful.util.table.join(choices, new)
      previous = new
   end

   return choices
end

-- Build available choices
local function menu()
   local menu = {}
   local out = outputs()
   local choices = arrange(out)

   for _, choice in pairs(choices) do
      local cmd = "xrandr --auto"
      -- Enabled outputs
      for i, o in pairs(choice) do
	 cmd = cmd .. " --output " .. o .. " --auto"
	 if i > 1 then
	    cmd = cmd .. " --right-of " .. choice[i-1]
	 end
      end
      -- Disabled outputs
      for _, o in pairs(out) do
	 if not awful.util.table.hasitem(choice, o) then
	    cmd = cmd .. " --output " .. o .. " --off"
	 end
      end

      local label = ""
      if #choice == 1 then
	 label = 'Only <span weight="bold">' .. choice[1] .. '</span>'
      else
	 for i, o in pairs(choice) do
	    if i > 1 then label = label .. " + " end
	    label = label .. '<span weight="bold">' .. o .. '</span>'
	 end
      end

      menu[#menu + 1] = { label,
			  cmd,
			  }
   end

   return menu
end

-- Display xrandr notifications from choices
local state = { iterator = nil,
		timer = nil,
		cid = nil }
function xrandr()
   -- Stop any previous timer
   if state.timer then
      state.timer:stop()
      state.timer = nil
   end

   -- Build the list of choices
   if not state.iterator then
      state.iterator = awful.util.table.iterate(menu(),
					function() return true end)
   end

   -- Select one and display the appropriate notification
   local next  = state.iterator()
   local label, action, icon
   if not next then
      label, icon = "Keep the current configuration"
      state.iterator = nil
   else
      label, action, icon = unpack(next)
   end
   state.cid = naughty.notify({ text = label,
				icon = icon,
				timeout = 2,
				screen = mouse.screen, -- Important, not all screens may be visible
				font = "Ubuntu 18",
				replaces_id = state.cid }).id

   -- Setup the timer
   state.timer = timer { timeout = 2}
   state.timer:connect_signal("timeout",
			  function()
			     state.timer:stop()
			     state.timer = nil
			     state.iterator = nil
			     if action then
				awful.util.spawn(action, false)
			     end
			  end)
   state.timer:start()
end
-- }}}


function sysbox()
   -- Gather Infos
   local ostmp = wibox.widget.textbox()
   vicious.register(ostmp, vicious.widgets.os,
         "$1 $2 $3 $4 $5 $6")

   osinfo = ostmp.text

   naughty.notify({title="System Information",
            position="bottom_right",
            timeout=-1,
            ontop=true,
            font = "Ubuntu 10",
            screen = mouse.screen,
            text=osinfo})
end

-- ips widget: show internal and external ips as a tooltip on
-- an icon.

-- function to call bash script and return its output.
function get_ips()
    local fd = io.popen("/home/luxick/bin/get_ip")
    local str = fd:read("*all")
    return str 
end

function getinfo()
   local str = ""

   return str
end

function update_wallpaper()
  local f = io.open(os.getenv("HOME")..'/.config/awesome/wall.txt', "r")
  local wallpaper = f:read("*all")
  f:close()
  awful.util.spawn_with_shell("feh --bg-scale "..wallpaper)
end

function new_wallpaper(path_to_new_wallpaper)
  local f = io.open(os.getenv("HOME")..'/.config/awesome/wall.txt', "w")
  io.output(f)
  io.write(path_to_new_wallpaper)
  f:close()
  update_wallpaper()
end