local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

require("configuration.powermenu.imagebox.popup")
require("configuration.powermenu.imagebox.button")


local powerbtn = wibox.widget.imagebox(beautiful.shutdown_btn)

powerbtn:buttons(gears.table.join (
    awful.button({}, 1, function()
    awesome.emit_signal("widget::powermenu")
end)))

return powerbtn