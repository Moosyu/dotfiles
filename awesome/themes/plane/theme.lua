local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")
local awesome, client, os = awesome, client, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/plane"
theme.font = "JetBrainsMono Nerd Font 10.5"
theme.fg_normal = "#BBBBBB"
theme.fg_focus = "#EEEEEE"
theme.bg_normal = "#222222"
theme.bg_focus = "#005577"
theme.fg_urgent = "#CAD3F5"
theme.bg_urgent = "#ED8796"
theme.border_width = dpi(2)
theme.border_normal = "#444444"
theme.border_focus = "#005577"
theme.taglist_fg_focus = "#ECEFF4"
theme.taglist_fg_occupied = "#005577"
theme.awesome_icon = theme.dir .."/icons/awesome.png"
theme.menu_height = dpi(16)
theme.menu_width = dpi(130)
theme.tasklist_disable_icon = true
theme.useless_gap = 3

local markup = lain.util.markup


-- Textclock
--os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock("[ %a %b %d, %l:%M%P ]")
mytextclock.font = theme.font

awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_focus,
        bg   = theme.bg_normal
    }
})

theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, "[ Vol: " .. volume_now.level .. "% ]"))
    end
})
theme.volume.widget:buttons(my_table.join (
          awful.button({}, 1, function()
            awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
          end)
    ))
-- Separators
local first     = wibox.widget.textbox(markup.font("Terminus 3", " "))
local spr       = wibox.widget.textbox(' ')
local small_spr = wibox.widget.textbox(markup.font("Terminus 4", " "))
local bar_spr   = wibox.widget.textbox(markup.font("Terminus 3", " ") .. markup.fontfg(theme.font, "#777777", "|") .. markup.font("Terminus 5", " "))

-- Eminent-like task filtering

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))


    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
    -- Create a tasklist widget

    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = awful.util.tasklist_buttons,
        layout   = {
            spacing = 5,
            layout  = wibox.layout.flex.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }


-- Create the wibox
    s.mywibox = awful.wibar({
        position = "top", screen = s, 
        height = dpi(18), 
        bg = theme.bg_normal, 
        fg = theme.fg_normal    
    })
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            small_spr,
            layout = wibox.layout.fixed.horizontal,
            small_spr,
            first,
            s.mytaglist,
            small_spr,
            wibox.widget.textbox('<span>[ </span>'),
            s.mylayoutbox,
            wibox.widget.textbox('<span> ]</span>'),
            small_spr,
            first,
            s.mypromptbox,
            bar_spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            small_spr,
            --theme.mail.widget,
            bar_spr,
            --fsicon,
            --fswidget,
            theme.volume.widget,
            mytextclock,
            small_spr,
            small_spr,
            wibox.widget.systray(),
            small_spr,
        },
    }
end

return theme

