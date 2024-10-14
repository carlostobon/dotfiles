import XMonad
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Layout.Gaps
import XMonad.Layout.Dwindle
import XMonad.Util.SpawnOnce
import XMonad.Layout.Spacing
import XMonad.Hooks.WindowSwallowing


-------------------------------------------------------------
-- Basics

myTerminal            = "kitty"
myModMask             = mod4Mask
myFocusFollowsMouse   = True
myClickJustFocuses    = False
myBorderWidth         = 0
myNormalBorderColor   = "#ffffff"
myFocusedBorderColor  = "#ffffff"

myWorkspaces =
  [ "1", "2", "3", "4", "5"
  , "6", "7", "8", "9", "10"
  , "11", "12", "13", "14"
  ]


myHandleEventHook = swallowEventHook
    (className =? "kitty")
    (return True)

-------------------------------------------------------------
-- Keys:

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [
    -- Launch a window
    ((modm,  xK_Return), spawn $ XMonad.terminal conf),

    -- Close focused window
    ((modm,  xK_s),  kill),

    -- Focus next window
    ((modm,  xK_e),  windows W.focusDown),

    -- Move to prev workspace
    ((modm,  xK_n),  moveTo Prev (Not emptyWS)),

    -- Move to next workspace
    ((modm,  xK_i),  moveTo Next (Not emptyWS)),

    -- Find an empty workspace
    ((modm,  xK_t),  moveTo Next emptyWS),

    -- Shrink master area
    ((modm,  xK_m),  sendMessage Shrink),

    -- Expand master area
    ((modm,  xK_o),  sendMessage Expand),

    -- Rotate between layouts
    ((modm,  xK_space), sendMessage NextLayout),

    -- Swap to master window
    ((modm,  xK_comma ), windows W.swapMaster),


    -- Custom keys not related to XMonad
    --
    -- Launch qutebrowser
    ((modm,  xK_f), spawn "qutebrowser"),

    -- Launch brave
    ((modm,  xK_p), spawn "brave"),

    -- Emulate copy
    ((modm,  xK_k), spawn "sleep 0.2 && xdotool key ctrl+c"),

    -- Emulate paste
    ((modm,  xK_h), spawn "sleep 0.2 && xdotool key ctrl+v"),

    -- Simulate scape
    ((modm,  xK_apostrophe), spawn "sleep 0.2 && xdotool key Escape")

  ]


-------------------------------------------------------------
-- Layouts:

myLayout = spacing 10 $ gaps [(U, 10), (R, 30), (D, 10), (L, 30)]
     (tiled ||| Mirror tiled ||| Full ||| Dwindle L CW (3/2) (11/10))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


--------------------------------------------------------------
-- StartupHook

myStartupHook = do
 spawnOnce "picom --config .config/picom/picom.conf"
 spawn "xset r rate 250 80 &"
 spawn "xset s 18000 &"
 spawn "unclutter &"
 spawn "setxkbmap -option 'caps:super'"
 spawn "xwallpaper --stretch .config/wallpaper/wallpaper.png &"


--------------------------------------------------------------
-- Defaults

defaults = def {
    terminal           = myTerminal,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    focusFollowsMouse  = myFocusFollowsMouse,
    keys               = myKeys,
    layoutHook         = myLayout,
    startupHook        = myStartupHook,
    borderWidth        = myBorderWidth,
    normalBorderColor  = myNormalBorderColor,
    handleEventHook    = myHandleEventHook,
    focusedBorderColor = myFocusedBorderColor
}

main = xmonad defaults
