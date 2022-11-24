local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local button = wibox.widget{
    {
        {
            image  = beautiful.shutdown_btn,
            resize = false,
            widget = wibox.widget.imagebox
            },
            
        top = 100, bottom = 100, left = 120, right = 120,
        widget = wibox.container.margin
    },
    
    shape = function(cr, width, height) 
        gears.shape.rounded_rect(cr, width, height, 4) 
    end,
    widget = wibox.container.background
}


button:connect_signal("mouse::enter", function(c) c:set_bg("#181926") end)
button:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

return button