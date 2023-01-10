-- keybinds haha
-- ~~~~~~~~~~~~~


-- requirements
-- ~~~~~~~~~~~~
local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox         = require("wibox")
local gears         = require("gears")

-- vars/misc
-- ~~~~~~~~~

-- modkey
local modkey    = "Mod4"

-- modifer keys
local shift     = "Shift"
local ctrl      = "Control"
local alt       = "Mod1"


-- Configurations
-- ~~~~~~~~~~~~~~

-- mouse keybindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 3, 
    function() awful.util.mymainmenu:toggle()
    end),

})

-- awesome yeah!
awful.keyboard.append_global_keybindings({
    -- first one doesnt work for some reason
    awful.key({ }, ""),


    awful.key({ modkey }, "s",
        hotkeys_popup.show_help,
    {description="show help", group="awesome"}),

    awful.key({ modkey, ctrl, alt }, "r",
    function() awful.spawn("reboot")
        end,
    {description = "restart pc", group = "computer"}),

    awful.key({ modkey, ctrl, alt }, "q",
    function() awful.spawn("shutdown now")
        end,
    {description = "shutdown pc", group = "computer"}),

    awful.key({ modkey, ctrl }, "r",
        awesome.restart,
    {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, shift }, "q",
        awesome.quit,
    {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey }, "Return",
    function() awful.spawn(likes.terminal)
        end,
    {description = "open terminal", group = "launcher"}),

    awful.key({ modkey }, "b",
    function() awful.spawn.with_shell(likes.browser)
        end,
    {description = "open web browser", group = "launcher"}),

    awful.key({ modkey }, "p",
    function() awful.spawn(likes.launcher)
        end,
    { description = "open rofi", group = "launcher" }),

    awful.key({ modkey, "Shift"   }, "j",
    function() awful.client.swap.byidx(1)
        end,
    {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k",
    function() awful.client.swap.byidx( -1)
        end,
    {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey }, "j",
    function() awful.client.focus.byidx(-1)
        end,
    {description = "focus the previous screen", group = "client"}),

    awful.key({ modkey }, "k",
    function() awful.client.focus.byidx( 1)
        end,
    {description = "focus the next screen", group = "client"}
            ),

    awful.key({ modkey, ctrl }, "j",
    function () awful.screen.focus_relative(1)
        end,
    {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, ctrl }, "k",
    function () awful.screen.focus_relative(-1)
        end,
    {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey, ctrl }, "n",
              function ()
                  local c = awful.client.restore()
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
    {description = "restore minimized", group = "client"}),

    awful.key({ modkey, }, "space",
    function () awful.layout.inc( 1)
        end,
    {description = "select next", group = "layout"}),

    awful.key({ modkey, shift }, "space",
    function () awful.layout.inc(-1)
        end,
    {description = "select previous", group = "layout"}),

    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})


-- mouse mgmt
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({

        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),

        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),

        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),

    })
end)


-- client mgmt
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "c",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
        {description = "toggle fullscreen", group = "client"}),


        awful.key({ modkey }, "q",
        function (c) c:kill()
            end,
        {description = "close", group = "client"}),

        awful.key({ modkey }, "x",
            awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}),


        awful.key({ modkey, ctrl }, "Return",
        function (c) c:swap(awful.client.getmaster())
            end,
        {description = "move to master", group = "client"}),


        awful.key({ modkey }, "o",
        function (c) c:move_to_screen()
            end,
        {description = "move to screen", group = "client"}),


        awful.key({ modkey }, "t",
        function (c) c.ontop = not c.ontop
            end,
        {description = "toggle keep on top", group = "client"}),


        awful.key({ modkey }, "n",
        function (c) c.minimized = true
            end,
        {description = "minimize", group = "client"}),

        awful.key({ modkey }, "m",
        function(c) c.maximized = not c.maximized
            c:raise()
		end,
		{description = "maximize window", group = "client"}),


    })

end)

for i = 1, 9 do

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
            {description = "view tag #"..i, group = "tag"}),
  -- Toggle tag display.
  awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                   awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),
  -- Move client to tag.
  awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
               end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),
  -- Toggle tag on focused client.
  awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
        }
    )
end

