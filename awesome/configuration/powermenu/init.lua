local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

require("configuration.powermenu.popup")
require("configuration.powermenu.button")


local powerbtn = wibox.widget.imagebox(beautiful.shutdown_btn)

powerbtn:buttons(gears.table.join (
    awful.button({}, 1, function()
    awesome.emit_signal("widget::powermenu")
end)))

return powerbtn