import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import System.IO
import Data.List

import XMonad.Actions.GridSelect

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

ws_gimp = "4:gimp"
ws_chat = "8:chat"
ws_web  = "1:web"
ws_code = "2:code"

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
                , borderWidth        = 1
                , normalBorderColor  = "#444444"
                , focusedBorderColor = "#ff3333"
                , workspaces         = ["1:web", "2:code", "3", "4:gimp", "5:fullscreen", "6", "7", "8:chat", "9"]
                , focusFollowsMouse  = True
                , terminal           = "urxvt"
                , logHook            = customLogHook xmproc
                , keys               = customKeys
                }



customLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }


customPP = defaultPP
    { ppHidden  = xmobarColor "#999" "" . wrap "" " "
    , ppVisible = xmobarColor "#999" "" . wrap "" "·"
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
    , bgColor  = "#000000"
    , bgHLight = "#000000"
    , fgHLight = "#FF0000"
    , position = Top
    }

customManageHook = (composeAll . concat $
    [
    [ isFullscreen                    --> doFullFloat
    , isDialog                          --> doCenterFloat
    , className =? "Xmessage"           --> doCenterFloat
    , className =? "Wine"               --> doCenterFloat
    , className =? "Gimp"               --> doShift ws_gimp
    , className =? "Pidgin"             --> doShift ws_chat
    , className =? "Skype"              --> doShift ws_chat
    , className =? "MPlayer"            --> doShift "5:fullscreen"
    , className =? "Smplayer"           --> doShift "5:fullscreen"
    --, className =? "xfce4-notifyd"      --> doIgnore
    , title =? "xfce4-notifyd"          --> doIgnore
    , title =? "kruler"                 --> doIgnore
    ]
    , [title    =? t                    --> doFloat | t <- titleFloats ]
    , [title    =? t                    --> doCenterFloat | t <- centerFloats ]
    ]
    ) <+> manageDocks <+> namedScratchpadManageHook scratchpads
    where titleFloats = [ "Downloads", "Send file", "Open", "File Transfers", "XChat: Network List", "Save screenshot as..."]
          centerFloats = [ "Caml graphics" ]


customLayoutHook
    = onWorkspace ws_chat imLayout
    $ onWorkspace ws_web webL
    $ onWorkspace ws_code codeL
    $ onWorkspace ws_gimp gimpL
    $ onWorkspace "5:fullscreen" fullL
    $ standardLayouts
   where
        standardLayouts = avoidStruts  $ (tabLayout ||| tiled |||  reflectTiled ||| Mirror tiled ||| Full)
        tiled           = smartBorders (ResizableTall 1 (2/100) (1/2) [])
        reflectTiled    = (reflectHoriz tiled)
        tabLayout       = (tabbed shrinkText defaultTheme)
        full            = smartBorders Full

        --imLayout        = tiled
        imLayout        = avoidStruts $
                            (withIM (0.2) isSkype (Mirror tiled))
        --imLayoutBork    = avoidStruts $
                            -- (withIM (0.2) isSkype (Mirror tiled))
                            -- *//*
                            -- (withIM (0.2) isPidgin (Mirror tiled))
        isSkype         = (Title "einars.lielmanis - Skype™ (Beta)")
        --isPidgin        = And (ClassName "Pidgin") (Role "buddy_list")

        -- gimpL = avoidStruts $ withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full
        gimpL = combineTwoP (TwoPane 0.03 0.15) (tabLayout) (reflectHoriz $ combineTwoP (TwoPane 0.03 0.2) tabLayout (tabLayout ||| Grid) (Role "gimp-dock")) (Role "gimp-toolbox")
        codeL = avoidStruts $ Full ||| reflectTiled
        webL  = avoidStruts $ Mirror reflectTiled |||  Full ||| reflectTiled
        fullL = avoidStruts $ full

scratchpads =
        [ NS "urxvt" "urxvt --title scratch" (title =? "scratch") xfloating
        , NS "python" "xterm -e python" (title =? "python") xfloating
        ]
        where xfloating = (customFloating $ W.RationalRect (1/3) (1/3) (1/3) (1/3))

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

    , ((modMask,               xK_n ),     refresh)

    , ((modMask,               xK_Tab ),   windows W.focusDown)
    , ((modMask .|. shiftMask, xK_Tab ),   windows W.focusUp)
    , ((modMask,               xK_j ),     windows W.focusDown)
    , ((modMask,               xK_k ),     windows W.focusUp)
 -- , ((modMask,               xK_m ),     windows W.focusMaster)

 -- , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_Return), spawn "urxvt-tmux")
    , ((modMask .|. shiftMask, xK_j ),     windows W.swapDown )
    , ((modMask .|. shiftMask, xK_k ),     windows W.swapUp )

    , ((modMask,               xK_comma),  sendMessage (IncMasterN 1))
    , ((modMask,               xK_period), sendMessage (IncMasterN (-1)))

    , ((modMask,               xK_h ),     sendMessage Shrink)
    , ((modMask,               xK_l ),     sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h ),     sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l ),     sendMessage MirrorExpand)

    , ((modMask .|. shiftMask, xK_p ),     io (exitWith ExitSuccess))
    , ((modMask,               xK_p ),     restart "xmonad" True)

    , ((modMask,               xK_m     ), spawn "run-inferior super-m")
    , ((modMask .|. shiftMask, xK_m     ), spawn "run-inferior super-M")
    , ((modMask,               xK_t     ), spawn "thunar torrents")
    , ((modMask,               xK_q     ), spawn "thunar stuff")
    , ((modMask,               xK_b     ), spawn "thunar /storage/books")
    , ((modMask,               xK_d     ), spawn "thunar Documents")

    -- xdotool script to help refresh opera after vim save, :w
    , ((modMask,               xK_w     ), spawn "xmonad-refresh-opera")
    --, ((modMask,               xK_grave ), scratchpadSpawnAction defaultConfig { terminal = "urxvt" } )
    --, ((modMask .|. shiftMask, xK_grave ), scratchpadSpawnAction defaultConfig { terminal = "xterm python" } )
    --, ((modMask,               xK_z ),     scratchpadSpawnAction defaultConfig { terminal = "urxvt" } )
    --, ((modMask .|. shiftMask, xK_z ),     scratchpadSpawnAction defaultConfig { terminal = "xterm python" } )
    , ((modMask,               xK_grave ), namedScratchpadAction scratchpads "urxvt" )
    , ((modMask,               xK_z ),     namedScratchpadAction scratchpads "urxvt" )
    , ((modMask .|. shiftMask, xK_grave ), namedScratchpadAction scratchpads "python" )
    , ((modMask .|. shiftMask, xK_z ),     namedScratchpadAction scratchpads "python" )

    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    -- mod-[a,s] %! switch to twinview screen 1/2
    -- mod-shift-[a,s] %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_a, xK_s] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

