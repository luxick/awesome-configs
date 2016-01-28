---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2009, Lucas de Vries <lucas@glacicle.com>
---------------------------------------------------

-- {{{ Grab environment
local io = { lines = io.lines }
local setmetatable = setmetatable
local string = { gmatch = string.gmatch }
-- }}}

-- Fan: provides Fan Mode and rpm
-- vicious.widgets.fan
local fan = {}

-- {{{ Fan Widget
local function worker(format)
    local _fan = { buf = {}, swp = {}}

    -- Get Fan infos
    for line in io.lines("/proc/acpi/ibm/fan") do
        for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+") do
            if     k == "status"  then _fan.status = v
            elseif k == "speed"   then _fan.speed = v
            elseif k == "level"   then _fan.level = v
            end
        end
    end

    return { _fan.status, _fan.speed, _fan.level }
end

return setmetatable(fan, { __call = function(_, ...) return worker(...) end })
-- }}}