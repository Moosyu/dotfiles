local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
local power_btn = require("configuration.powermenu.imagebox.button")

local popup_box = wibox {
    width = dpi(270),
    height = dpi(90),
    bg = beautiful.bg,
    border_width = dpi(4),
    border_color = beautiful.border_focus,
    ontop = true,
    visible = false,
    shape = function(cr, width, height)
        gears.shape.rectangle(cr, width, height)
    end
}

popup_box:setup {
    power_btn { text = beautiful.shutdown_btn, onclick = "shutdown now" },
    power_btn { text = beautiful.logout_btn, onclick = "awesome-client command 'awesome.quit()'" },
    power_btn { text = beautiful.restart_btn, onclick = "reboot" },
    layout = wibox.layout.align.horizontal
}


awesome.connect_signal("widget::powermenu", function()
    popup_box.visible = not popup_box.visible

    awful.placement.centered(
        popup_box,
        {
            margins = {
                top = dpi(340), },
            parent = awful.screen.focused()
        }
    )
end)

