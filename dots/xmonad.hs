import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import System.IO
import Data.List

import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.WindowProperties
import XMonad.Util.NamedScratchpad

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Prompt.Shell
import XMonad.Prompt

import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.ComboP
import XMonad.Layout.TwoPane
import XMonad.Layout.TrackFloating
import XMonad.Layout.StackTile
import XMonad.Hooks.SetWMName

import XMonad.Layout.LayoutCombinators hiding ((|||))

ws_gimp = "4"
ws_chat = "8"
ws_web  = "1"
ws_code = "2"

main = do
        xmproc <- spawnPipe "xmobar"
        xmonad
 --             $ withUrgencyHookC dzenUrgencyHook
 --             { args = ["-bg", "darkblue", "-xs", "1"]}
 --             UrgencyConfig { suppressWhen = Focused, remindWhen = Every 5 }

                $ defaultConfig
                { modMask            = mod4Mask
                , manageHook         = customManageHook
                , layoutHook         = customLayoutHook
                , borderWidth        = 2
                , normalBorderColor  = "#444444"
                , focusedBorderColor = "#ff3333"
                , workspaces         = ["1", "1´", "2", "2´", "3", "3´", "4", "4´", "5", "5´", "6", "6´", "7", "7´", "8", "8´", "9", "9´"]
                , focusFollowsMouse  = True
                , terminal           = "urxvt"
                , logHook            = customLogHook xmproc
                , startupHook        = setWMName "LG3D"
                , keys               = customKeys
                }



customLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }


customPP = defaultPP
    { ppHidden  = xmobarColor "#555" "" . wrap "" " "
    , ppVisible = xmobarColor "#999" "" . wrap "" " "
    , ppCurrent = xmobarColor "#6c6" "" . wrap "" " "
    , ppUrgent  = xmobarColor "#F00" "" . wrap "" "!"
    , ppLayout  = xmobarColor "#333" ""
    , ppTitle   = xmobarColor "#ccc" "" . shorten 200
    , ppSep = "<fc=#444> | </fc>"
    }

-- tab bar
customXPConfig = defaultXPConfig
    { font     = "-*-terminus-*-*-*-*-12-*-*-*-*-*-*-u"
    , fgColor  = "#ddddff"
    , bgColor  = "#111111"
    , bgHLight = "#222222"
    , fgHLight = "#FF0000"
    , position = Top
    }

customManageHook = (composeAll . concat $
    [
    [ isFullscreen                    --> doFullFloat
    , isDialog                          --> doRectFloat (W.RationalRect (1/6) (1/6) (2/3) (2/5))
    , className =? "Xmessage"           --> doCenterFloat
    , className =? "Wine"               --> doCenterFloat
    , className =? "Gimp"               --> doShift ws_gimp
    , className =? "Pidgin"             --> doShift ws_chat
    , className =? "Skype"              --> doShift ws_chat
    -- , className =? "MPlayer"            --> doShift "5"
    -- , className =? "Smplayer"           --> doShift "5"
    , title =? "xfce4-notifyd"          --> doIgnore
    , title =? "kruler"                 --> doIgnore
    ]
    , [title    =? t                    --> doFloat | t <- titleFloats ]
    , [title    =? t                    --> doCenterFloat | t <- centerFloats ]
    ]
    ) <+> manageDocks <+> namedScratchpadManageHook scratchpads
    where titleFloats = [ "XChat: Network List", "Save screenshot as...", "Screen Ruler"]
          centerFloats = [ "Caml graphics" ]


customLayoutHook
    = onWorkspace ws_chat imLayout
    $ onWorkspace ws_web webL
    $ onWorkspace ws_gimp gimpL
    $ onWorkspace "5" full
    $ standardLayouts
   where
        standardLayouts = avoidStruts  $ (stacktiled ||| tabLayout |||  Full)
        stacktiled      = smartBorders (StackTile 1 (3/100) (1/2))
        tiled           = smartBorders (ResizableTall 1 (2/100) (1/2) [])
        tabLayout       = (tabbed shrinkText defaultTheme)
        full            = smartBorders Full

        imLayout        = avoidStruts $
                            (withIM (0.2) isSkype (stacktiled))
        isSkype         = (Title "einars.lielmanis - Skype™ (Beta)")

        gimpL = combineTwoP (TwoPane 0.03 0.15) (tabLayout) (reflectHoriz $ combineTwoP (TwoPane 0.03 0.2) tabLayout (tabLayout ||| Grid) (Role "gimp-dock")) (Role "gimp-toolbox")
        webL  = avoidStruts $ stacktiled |||  Full

scratchpads =
        [ NS "urxvt1" "urxvt --title scratch-1" (title =? "scratch-1") xfloating
        , NS "urxvt2" "urxvt --title scratch-2" (title =? "scratch-2") xfloating
        ]
        where xfloating = (customFloating $ W.RationalRect (1/6) (2/5) (2/3) (1/3))

customKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask,               xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask, xK_c ),     kill)

    , ((modMask,               xK_p),      shellPrompt customXPConfig)
    , ((modMask,               xK_r),      shellPrompt customXPConfig)
    , ((modMask,               xK_g),      goToSelected defaultGSConfig)

    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask .|. shiftMask, xK_b ),     sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask .|. shiftMask, xK_t ),     withFocused $ windows . W.sink)

    , ((modMask .|. shiftMask, xK_r ),     refresh)

    , ((modMask,               xK_Tab ),   windows W.focusDown)
    , ((modMask .|. shiftMask, xK_Tab ),   windows W.focusUp)

    , ((modMask .|. shiftMask, xK_Return), spawn "urxvt-tmux")
    , ((modMask .|. shiftMask, xK_j ),     windows W.swapDown )
    , ((modMask .|. shiftMask, xK_k ),     windows W.swapUp )

    , ((modMask,               xK_j ),     sendMessage Shrink)
    , ((modMask,               xK_k ),     sendMessage Expand)

    , ((modMask .|. shiftMask, xK_p ),     io (exitWith ExitSuccess))
    , ((modMask,               xK_p ),     restart "xmonad" True)

    , ((modMask,               xK_m     ), spawn "run-inferior super-m")
    , ((modMask .|. shiftMask, xK_m     ), spawn "run-inferior super-M")
    , ((modMask,               xK_n     ), spawn "run-inferior super-n")
    , ((modMask .|. shiftMask, xK_n     ), spawn "run-inferior super-N")
    , ((modMask,               xK_t     ), spawn "thunar torrents")
    , ((modMask,               xK_q     ), spawn "thunar stuff")
    , ((modMask,               xK_b     ), spawn "thunar /storage/books")
    , ((modMask,               xK_d     ), spawn "thunar Documents")

    , ((modMask,               xK_i     ), (dynamicLogString defaultPP >> spawn "xmessage FOO"))
    , ((modMask,               xK_backslash ), swapNextScreen)

    -- xdotool script to help refresh opera after vim save, :w
    , ((modMask,               xK_w     ), spawn "xmonad-refresh-opera")
    , ((modMask,               xK_grave ), namedScratchpadAction scratchpads "urxvt1" )
    , ((modMask,               xK_z ),     namedScratchpadAction scratchpads "urxvt2" )

    , ((modMask,               xK_1), windows $ W.view "1")
    , ((modMask,               xK_2), windows $ W.view "2")
    , ((modMask,               xK_3), windows $ W.view "3")
    , ((modMask,               xK_4), windows $ W.view "4")
    , ((modMask,               xK_5), windows $ W.view "5")
    , ((modMask,               xK_6), windows $ W.view "6")
    , ((modMask,               xK_7), windows $ W.view "7")
    , ((modMask,               xK_8), windows $ W.view "8")
    , ((modMask,               xK_9), windows $ W.view "9")

    , ((modMask .|. shiftMask, xK_1), windows $ W.shift "1")
    , ((modMask .|. shiftMask, xK_2), windows $ W.shift "2")
    , ((modMask .|. shiftMask, xK_3), windows $ W.shift "3")
    , ((modMask .|. shiftMask, xK_4), windows $ W.shift "4")
    , ((modMask .|. shiftMask, xK_5), windows $ W.shift "5")
    , ((modMask .|. shiftMask, xK_6), windows $ W.shift "6")
    , ((modMask .|. shiftMask, xK_7), windows $ W.shift "7")
    , ((modMask .|. shiftMask, xK_8), windows $ W.shift "8")
    , ((modMask .|. shiftMask, xK_9), windows $ W.shift "9")

    , ((modMask .|. controlMask, xK_1), windows $ W.view "1´")
    , ((modMask .|. controlMask, xK_2), windows $ W.view "2´")
    , ((modMask .|. controlMask, xK_3), windows $ W.view "3´")
    , ((modMask .|. controlMask, xK_4), windows $ W.view "4´")
    , ((modMask .|. controlMask, xK_5), windows $ W.view "5´")
    , ((modMask .|. controlMask, xK_6), windows $ W.view "6´")
    , ((modMask .|. controlMask, xK_7), windows $ W.view "7´")
    , ((modMask .|. controlMask, xK_8), windows $ W.view "8´")
    , ((modMask .|. controlMask, xK_9), windows $ W.view "9´")

    , ((modMask .|. controlMask .|. shiftMask, xK_1), windows $ W.shift "1´")
    , ((modMask .|. controlMask .|. shiftMask, xK_2), windows $ W.shift "2´")
    , ((modMask .|. controlMask .|. shiftMask, xK_3), windows $ W.shift "3´")
    , ((modMask .|. controlMask .|. shiftMask, xK_4), windows $ W.shift "4´")
    , ((modMask .|. controlMask .|. shiftMask, xK_5), windows $ W.shift "5´")
    , ((modMask .|. controlMask .|. shiftMask, xK_6), windows $ W.shift "6´")
    , ((modMask .|. controlMask .|. shiftMask, xK_7), windows $ W.shift "7´")
    , ((modMask .|. controlMask .|. shiftMask, xK_8), windows $ W.shift "8´")
    , ((modMask .|. controlMask .|. shiftMask, xK_9), windows $ W.shift "9´")

    ]

    ++

    -- mod-[a,s] %! switch to twinview screen 1/2
    -- mod-shift-[a,s] %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_s, xK_a] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

