local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

require("configuration.powermenu.textbox.popup")
require("configuration.powermenu.textbox.button")


local powerbtn = wibox.widget.textbox('<span foreground="#BF616A">  </span>')

powerbtn:buttons(gears.table.join (
    awful.button({}, 1, function()
    awesome.emit_signal("widget::powermenu")
end)))

return powerbtn