local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi


local temp = wibox.widget {
    awful.widget.watch('bash -c "cat /sys/class/thermal/thermal_zone*/temp | sed -e \"s/...$//\" | sed -e \"1,3d\""', 3),
    fg = "#A3BE8C",
    widget = wibox.container.background
}
return temp