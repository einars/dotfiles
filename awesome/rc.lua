-- vim: set fdm=marker :
--
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("scratch")

-- disable startup notification
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init(awful.util.getdir('config') .. "/zenburn.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "gvim"
-- editor_cmd = terminal .. " -e " .. editor
editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    --awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    -- awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle)
                    -- awful.button({ modkey }, 3, awful.client.toggletag),
                    -- awful.button({ }, 4, awful.tag.viewnext),
                    -- awful.button({ }, 5, awful.tag.viewprev)
                    )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end)
                     --awful.button({ }, 4, function ()
                     --                         awful.client.focus.byidx(1)
                     --                         if client.focus then client.focus:raise() end
                     --                     end),
                     --awful.button({ }, 5, function ()
                     --                         awful.client.focus.byidx(-1)
                     --                         if client.focus then client.focus:raise() end
                     --                     end)
                                          )

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    --awful.button({ }, 4, awful.tag.viewnext),
    --awful.button({ }, 5, awful.tag.viewprev),
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn("gvim /storage/dokumenti/passwords.txt") end),
    awful.key({ modkey,           }, "m",      function () awful.util.spawn("run-inferior super-m") end),
    awful.key({ "Mod1", "Control" }, "Delete", function () awful.util.spawn("/my-lock") end),
    awful.key({ modkey, "Shift"   }, "m",      function () awful.util.spawn("run-inferior super-M") end),
    awful.key({ modkey,           }, "n",      function () awful.util.spawn("run-inferior super-n") end),
    awful.key({ modkey, "Shift"   }, "n",      function () awful.util.spawn("run-inferior super-N") end),
    awful.key({ modkey,           }, "w",      function () awful.util.spawn("xmonad-refresh-opera") end),
    -- awful.key({ "",               }, "XF86Eject", function () awful.util.spawn("sudo chvt 3") end),
    -- awful.key({ "",     "Control" }, "XF86Eject", function () awful.util.spawn("sudo chvt 3") end),
    awful.key({ "",               }, "F8",     function () awful.util.spawn("mpc toggle") end),
    awful.key({ "",     "Control" }, "F8",     function () awful.util.spawn("mpc stop") end),
    --awful.key({ "",     "Control" }, "XF86AudioMute",           function () awful.util.spawn("sound 0") end),
    --awful.key({ "",               }, "XF86AudioMute",           function () awful.util.spawn("sound-1") end),
    --awful.key({ "",               }, "XF86AudioLowerVolume",    function () awful.util.spawn("sound-2") end),
    --awful.key({ "",               }, "XF86AudioRaiseVolume",    function () awful.util.spawn("sound-3") end),
    awful.key({ modkey, "Shift"   }, "/",      function () awful.util.spawn("notify-mpd-song") end), -- win-? pops up mpc song
    awful.key({ modkey,           }, "q",      function () awful.util.spawn("thunar /storage/studijas") end),
    awful.key({ modkey,           }, "t",      function () awful.util.spawn("thunar /storage/torenti") end),
    awful.key({ modkey,           }, "b",      function () awful.util.spawn("thunar /storage/studijas") end),
    awful.key({ modkey,           }, "d",      function () awful.util.spawn("thunar /storage/dokumenti") end),
    awful.key({ modkey,           }, "c",      function () awful.util.spawn("/usr/bin/chromium") end),
    awful.key({ modkey, "Shift"   }, "c",      function () awful.util.spawn("/usr/bin/chromium") end),
    awful.key({ modkey, "Shift"   }, "t",      awful.client.floating.toggle                     ),

    awful.key({ modkey,           }, "x",      function () awful.util.spawn("xsetroot -cursor_name left_ptr") end),

    awful.key({ modkey,           }, "z",      function ()
                                                 scratch.drop('urxvt', 'center', 'center', 0.8, 0.33, True)
                                               end),
    awful.key({ modkey,           }, "`",      function ()
                                                 scratch.drop('urxvt', 'center', 'center', 0.8, 0.33, True)
                                               end),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    -- Layout manipulation
    awful.key({ modkey,           }, "a", function () awful.screen.focus(  2)    end),
    awful.key({ modkey,           }, "s", function () awful.screen.focus(  1)    end),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    -- awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    -- awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey },            "r",     function ()
        awful.util.spawn("dmenu_run -f -b -i -p Run: -nb '" ..
            beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
            "' -sb '" .. beautiful.bg_focus ..
            --"' -sf '" .. beautiful.fg_focus .. "'")
            "' -sf '#ff9933'")
        end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "F1", function () mymainmenu:show({keygrabber=true}) end),


    --awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "p", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore)


)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    -- awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Shift"   }, "x",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey, "Shift"   }, "a",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, ",",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey, "Shift"   }, "Left", function (c)
        c.maximized_horizontal = false
        c.maximized_vertical = false
        c.fullscreen = false
        c.floating = true
        -- awful.client.moveresize(0, 0, 640, 1200, c)
    end),
    awful.key({ modkey, "Shift"   }, "Right", function (c)
        c.maximized_horizontal = false
        c.maximized_vertical = false
        c.fullscreen = false
        c.floating = true
        -- awful.client.moveresize(0, 0, 640, 1200, c)
    end),
    awful.key({ modkey, "Shift"   }, "Up", function (c) c.maximized_vertical = false end),
    awful.key({ modkey, "Shift"   }, "Down", function (c) c.maximized_vertical = true end),
    awful.key({ modkey,           }, "f",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}



naughty.config.default_preset.screen = 1

naughty.config.default_preset.font = 'Monaco 10'
naughty.config.default_preset.timeout = 10
naughty.config.default_preset.position = "top_right"
naughty.config.default_preset.gap = 1
naughty.config.default_preset.border_width = 3
-- naughty.config.default_preset.width = 300
--naughty.config.default_preset.height = 40
naughty.config.default_preset.fg = '#ff5800'
naughty.config.default_preset.fg = '#eeeeee'
naughty.config.default_preset.bg = '#333333'
naughty.config.default_preset.border_color = '#ff5800'


function run_once(prg)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

run_once('parcellite')
