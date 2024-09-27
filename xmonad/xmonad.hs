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

myWorkspaces=["1","2","3","4","5","6","7","8","9","10","11","12","13","14"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#d4ccb9"
myFocusedBorderColor = "#ffffff"


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- Recompile and Restart xmonad
    , ((modm,               xK_period ), spawn "xmonad --recompile && xmonad --restart")

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_y ), io (exitWith ExitSuccess))

    -- Launch qutebrowser
    , ((modm,               xK_f ), spawn "qutebrowser")

    -- Launch brave
    , ((modm,               xK_p ), spawn "brave")



    -- Simulate copy
    , ((modm,               xK_k ), spawn "sleep 0.2 && xdotool key ctrl+c")

    -- Simulate paste
    , ((modm,               xK_h ), spawn "sleep 0.2 && xdotool key ctrl+v")

    -- Simulate scape
    , ((modm,               xK_apostrophe ), spawn "sleep 0.2 && xdotool key Escape")

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


    -- Record video
    --, ((modm .|. shiftMask, xK_y ), spawn "toolbox record-screen")

    -- Record audio
    , ((modm .|. shiftMask, xK_a ), spawn "toolbox record-audio")

    -- Kill all current recordings
    , ((modm .|. shiftMask, xK_l ), spawn "killall ffmpeg")

    -- Capture screen
    , ((modm .|. shiftMask, xK_p ), spawn "toolbox capture-screen")

    -- Swap the focused window and the master window
    , ((modm,               xK_comma ), windows W.swapMaster)

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

-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted

myStartupHook = do
 --spawnOnce "xrandr --output DP-1 --off"
 --spawnOnce "xrandr --output HDMI-A-0 --off"
 --spawnOnce "xrandr --output HDMI-A-0 --mode 1920x1080"
 spawnOnce "picom --config .config/picom/picom.conf"
 spawn "xset r rate 250 80 &"
 spawn "xset s 18000 &"
 spawn "unclutter &"
 spawn "setxkbmap -option 'caps:super'"
 spawn "xwallpaper --stretch .config/wallpaper/wallpaper.png &"

------------------------------------------------------------------------

-- Now run xmonad with all the defaults we set up.

main = xmonad defaults

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

      -- hooks, layouts
        layoutHook         = myLayout,
        handleEventHook    = myHandleEventHook,
        startupHook        = myStartupHook
    }
