local awful = require("awful")
local gears = require("gears")
local button = require("configuration.powermenu.powerbutton")



local powermenupop = awful.popup {
    ontop = true,
    visible = false,
    shape = gears.shape.rounded_rect,
    border_width = 1,
    border_color = "#93B6FF",
    maximum_width = 400,
    offset = {y = 5},
    hide_on_right_click = true,
    widget = button
}

return powermenupop