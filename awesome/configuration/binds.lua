local awful = require("awful")
local def = require("configuration.defaults")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- Aliases for the used keys
local modkey = "Mod4"
local shift = "Shift"
local ctrl = "Control"
local alt = "Mod1"



-- Bindings
awful.keyboard.append_global_keybindings({
	-- doing weird thing where first one doesnt work just gonna leave this here
	-- until i can fix it
	awful.key(
		{ modkey }, "Return", function()
		end 
	),

	awful.key(
		{ modkey }, "Return", function()
			awful.spawn(def.apps.term)
		end,
	 	{description = "open a terminal", group = "launcher"}
  	),

	awful.key(
		{ modkey }, "s",
			hotkeys_popup.show_help,
		{description = "show help page", group = "launcher"}
	),

	awful.key(
		{ modkey }, "p", function()
			awful.spawn(def.apps.launcher)
		end,
		{description = "launch rofi", group = "launcher"}
	),

	awful.key(
		{ modkey, ctrl }, "q",
			awesome.quit,
		{description = "quit awesome", group = "awesome"}
	),

	awful.key(
		{ modkey, ctrl }, "r",
			awesome.restart,
		{description = "restart awesome", group = "awesome"}
	),

    awful.key(
		{ modkey, shift }, "j", function()
			awful.client.swap.byidx(-1)
		end,
		{description = "swap with previous client by index", group = "client"}
	),

   	awful.key(
		{ modkey, shift }, "k", function()
			awful.client.swap.byidx( 1)
		end,
		{description = "swap with next client by index", group = "client"}
	),

    	awful.key(
		{ modkey }, "j", function()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus the previous screen", group = "client"}
	),

   	awful.key(
		{ modkey }, "k", function()
			awful.client.focus.byidx( 1)
		end,
		{description = "focus the next screen", group = "client"}
	),

	awful.key(
		{ modkey }, "h", function()
			awful.tag.incmwfact(-0.05)
		end,
		{description = "decrease width", group = "layout"}
	),

	awful.key(
		{ modkey }, "l", function()
			awful.tag.incmwfact(0.05)
		end,
		{description = "increase width", group = "layout"}
	),
	
	
	awful.key(
		{ modkey }, "Left",
			awful.tag.viewprev,
			{description = "view previous", group = "tag"}
	),

	awful.key(
		{ modkey }, "Right",
			awful.tag.viewnext,
		{description = "view next", group = "tag"}
	),

	awful.key {
		modifiers = { modkey, shift },
		keygroup = "numrow",
		on_press = function(index)

		if client.focus then
			local tag = client.focus.screen.tags[index]
			if tag then
				client.focus:move_to_tag(tag)
				tag:view_only()
			end
		end
	end
	}
})

-- Client/Layout related bindings
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
        	awful.key(
			{ modkey }, "f", function(c)
                		c.fullscreen = not c.fullscreen
                		c:raise()
            		end,
					{description = "fullscreen application", group = "client"}
		),

		awful.key(
			{ modkey }, "space", function(c)
				c.floating = not c.floating
				c:raise()
			end,
			{description = "toggle floating", group = "client"}
		),
	
		awful.key(
			{ modkey }, "m", function(c)
				c.maximized = not c.maximized
				c:raise()
			end,
			{description = "maximize window", group = "client"}
		),

		awful.key(
			{ modkey }, "n", function(c)
				c.minimized = true
			end,
			{description = "minimize window", group = "client"}),


		awful.key(
			{ modkey }, "q", function(c)
				c:kill()
			end,
			{description = "close window", group = "client"}
		),
	})
end)

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button(
			{ }, 1, function(c)
				c:activate { context = "mouse_click" }
        		end
		),

        	awful.button(
			{ modkey }, 1, function(c)
	            		c:activate { context = "mouse_click", action = "mouse_move"  }
	        	end
		),

        	awful.button(
			{ modkey }, 3, function(c)
	            		c:activate { context = "mouse_click", action = "mouse_resize"}
			end
		),
	})
end)

for i = 1, 6 do
	awful.keyboard.append_global_keybindings({
        -- View tag only.
    	awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"})}
		)end
		