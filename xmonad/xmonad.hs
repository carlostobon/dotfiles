import XMonad.Layout.Gaps
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.WindowSwallowing

import XMonad.Actions.CycleWS
import XMonad.Util.SpawnOnce
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Layout.Gaps



myTerminal      = "kitty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 0

myModMask       = mod4Mask

myWorkspaces    = ["1","2","3","4","5","6","7","8","9", "10", "11", "12"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#d4ccb9"
myFocusedBorderColor = "#ffffff"


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)


    -- Recompile and Restart xmonad
    , ((modm,               xK_h ), spawn "xmonad --recompile && xmonad --restart")

    -- Quit xmonad
    , ((modm,               xK_y ), io (exitWith ExitSuccess))



    -- Launch qutebrowser
    , ((modm,               xK_f ), spawn "qutebrowser")

    -- Launch brave
    , ((modm,               xK_p ), spawn "brave")



    -- Simulate copy
    , ((modm,               xK_v ), spawn "sleep 0.2 && xdotool key ctrl+c")

    -- Simulate paste
    , ((modm,               xK_k ), spawn "sleep 0.2 && xdotool key ctrl+v")

    -- Shrink the master area
    , ((modm,               xK_m ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_o ), sendMessage Expand)



    -- Move to prev workspace
    , ((modm,               xK_n ),  moveTo Prev (Not emptyWS))

    -- Move to prev workspace
    , ((modm,               xK_i ),  moveTo Next (Not emptyWS))


    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    -- Find an empty workspace
    , ((modm,               xK_t ), moveTo Next emptyWS)

    -- Close focused window
    , ((modm,               xK_s ), kill)

    -- Move focus to the next window
    , ((modm,               xK_e     ), windows W.focusDown)


    -- Start recording video
    , ((modm .|. shiftMask, xK_y ), spawn "toolbox.sh record-screen")

    -- Start recording audio
    , ((modm .|. shiftMask, xK_a ), spawn "toolbox.sh record-audio")

    -- Kill all recordings
    , ((modm .|. shiftMask, xK_l ), spawn "killall ffmpeg")

    -- Screen capture
    , ((modm .|. shiftMask, xK_p ), spawn "toolbox.sh capture-screen")

    -- Swap the focused window and the master window
    , ((modm,               xK_comma ), windows W.swapMaster)


    -- Reset the layouts on the current workspace to default
    --, ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    --, ((modm,             xK_n     ), refresh)

    -- Move focus to the master window
    --, ((modm,             xK_m     ), windows W.focusMaster  )

    -- Swap the focused window with the next window
    --, ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Push window back into tiling
    --, ((modm,             xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    --, ((modm,             xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    --, ((modm,               xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --, ((modm,               xK_b     ), sendMessage ToggleStruts)

    ]

-----------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

------------------------------------------------------------------------

-- Layouts:

myLayout = spacing 10 $ gaps [(U, 10), (R, 30), (D, 10), (L, 30)]
     tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------

-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- myEventHook = mempty

------------------------------------------------------------------------

-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------

-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted

myStartupHook = do
 --spawnOnce "xrandr --output DP-1 --off"
 --spawnOnce "xrandr --output HDMI-A-0 --off"
 --spawnOnce "xrandr --output HDMI-A-0 --mode 1920x1080"
 spawnOnce "picom --config .config/picom/picom.conf"
 spawn "xset r rate 500 60 &"
 spawn "xset s 18000 &"
 spawn "unclutter &"
 spawn "xwallpaper --stretch .config/wallpaper/wallpaper.png &"
 spawn "setxkbmap -option 'caps:super'"

------------------------------------------------------------------------

-- Now run xmonad with all the defaults we set up.

main = xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs

myHandleEventHook = swallowEventHook (className =? "kitty") (return True)

defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        handleEventHook    = myHandleEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
