local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi

local power_btn = function(args)
	local icon = args.icon
	local onclick = args.onclick or function() end

	local btn = wibox.widget {
		{
			{
				markup = icon,
				scaling_quality = "nearest",
				align = "center",
				valign = "center",
				widget = wibox.widget.textbox
			},
			valign = 'center',
			margins = dpi(25),
			widget = wibox.container.margin
		},

		id = "btn_role",
		bg = beautiful.bg,
		widget = wibox.container.background
	}

	btn:connect_signal("mouse::enter", function(self)
		local specific_btn = self:get_children_by_id("btn_role")[1]
		specific_btn.bg = beautiful.bg_focus
	end)

	btn:connect_signal("mouse::leave", function(self)
        local specific_btn = self:get_children_by_id("btn_role")[1]
		specific_btn.bg = beautiful.bg_normal
	end)

	btn:connect_signal("button::press", function()
		awesome.emit_signal("widget::powermenu")
		awful.spawn.with_shell(onclick)
	end)

	return btn
end

return power_btn