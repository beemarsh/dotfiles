-- Migrated HyDE keybindings
-- Put this file at: ~/.config/hypr/hyprland.lua
-- HyDE loads it after its defaults and does not overwrite it.

local MOD = hyde.config.modifiers.main
local apps = hyde.config.app

local function bind(keys, action, description, flags)
    flags = flags or {}
    flags.description = description
    hl.bind(keys, action, flags)
end

-- Reproduce the old "toggle floating, resize to 95%, then center" behavior.
local function toggle_floating_centered()
    hl.dsp.window.float({ action = "toggle" })()
    hl.dsp.window.resize({ width = "95%", height = "95%" })()
    hl.dsp.window.center()()
end

-- Move a floating window by pixels; move a tiled window in the given direction.
local function move_window(direction, pixels)
    local vectors = {
        l = { -1,  0 },
        r = {  1,  0 },
        u = {  0, -1 },
        d = {  0,  1 },
    }

    return function()
        local active = hl.get_active_window()
        if not active then
            return
        end

        local vector = vectors[direction]
        local args

        if active.floating then
            args = {
                x = vector[1] * pixels,
                y = vector[2] * pixels,
                relative = true,
            }
        else
            args = { direction = direction }
        end

        hl.dispatch(hl.dsp.window.move(args))
    end
end

-- ---------------------------------------------------------------------------
-- Remove HyDE defaults whose combinations are repurposed below.
-- ---------------------------------------------------------------------------

hl.unbind(MOD .. " + W")                 -- default toggle-float behavior
hl.unbind(MOD .. " + J")                 -- default toggle split
hl.unbind(MOD .. " + K")                 -- default keyboard-layout switch
hl.unbind(MOD .. " + L")                 -- default lock shortcut
hl.unbind(MOD .. " + SHIFT + K")         -- default calculator
hl.unbind(MOD .. " + CONTROL + S")       -- default OCR shortcut
hl.unbind(MOD .. " + F")                 -- repurposed as true fullscreen
hl.unbind(MOD .. " + E")                 -- launch Dolphin directly
hl.unbind(MOD .. " + LEFT")              -- default focus-left behavior
hl.unbind(MOD .. " + RIGHT")             -- default focus-right behavior
hl.unbind(MOD .. " + SHIFT + LEFT")      -- default resize-left behavior
hl.unbind(MOD .. " + SHIFT + RIGHT")     -- default resize-right behavior
hl.unbind(MOD .. " + ALT + LEFT")        -- default previous-wallpaper behavior
hl.unbind(MOD .. " + ALT + RIGHT")       -- default next-wallpaper behavior
hl.unbind(MOD .. " + ALT + SHIFT + LEFT")
hl.unbind(MOD .. " + ALT + SHIFT + RIGHT")

-- ---------------------------------------------------------------------------
-- Window management
-- ---------------------------------------------------------------------------

bind(
    MOD .. " + W",
    toggle_floating_centered,
    "[Window Management] toggle floating, resize and center"
)

bind(
    MOD .. " + F",
    hl.dsp.window.fullscreen({
        mode = "fullscreen",
        action = "toggle",
        layout_aware = false,
    }),
    "[Window Management] toggle fullscreen"
)

bind(
    MOD .. " + ESCAPE",
    hl.dsp.exec_cmd(hyde.sh.session.lock()),
    "[Window Management] lock screen"
)

-- Vim-style focus navigation.
bind(MOD .. " + H", hl.dsp.focus({ direction = "left"  }), "[Window Management|Change focus] focus left")
bind(MOD .. " + L", hl.dsp.focus({ direction = "right" }), "[Window Management|Change focus] focus right")
bind(MOD .. " + K", hl.dsp.focus({ direction = "up"    }), "[Window Management|Change focus] focus up")
bind(MOD .. " + J", hl.dsp.focus({ direction = "down"  }), "[Window Management|Change focus] focus down")

-- Vim-style resize navigation.
bind(
    MOD .. " + SHIFT + CONTROL + L",
    hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
    "[Window Management|Resize Active Window] resize right",
    { repeating = true }
)
bind(
    MOD .. " + SHIFT + CONTROL + H",
    hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
    "[Window Management|Resize Active Window] resize left",
    { repeating = true }
)
bind(
    MOD .. " + SHIFT + CONTROL + K",
    hl.dsp.window.resize({ x = 0, y = -30, relative = true }),
    "[Window Management|Resize Active Window] resize up",
    { repeating = true }
)
bind(
    MOD .. " + SHIFT + CONTROL + J",
    hl.dsp.window.resize({ x = 0, y = 30, relative = true }),
    "[Window Management|Resize Active Window] resize down",
    { repeating = true }
)

-- Vim-style window movement.
bind(
    MOD .. " + SHIFT + H",
    move_window("l", 30),
    "[Window Management|Move active window] move left",
    { repeating = true }
)
bind(
    MOD .. " + SHIFT + L",
    move_window("r", 30),
    "[Window Management|Move active window] move right",
    { repeating = true }
)
bind(
    MOD .. " + SHIFT + K",
    move_window("u", 30),
    "[Window Management|Move active window] move up",
    { repeating = true }
)
bind(
    MOD .. " + SHIFT + J",
    move_window("d", 30),
    "[Window Management|Move active window] move down",
    { repeating = true }
)

bind(
    MOD .. " + CONTROL + S",
    hl.dsp.layout("togglesplit"),
    "[Layout Management|Dwindle] toggle split"
)

-- ---------------------------------------------------------------------------
-- Workspace and monitor navigation
-- ---------------------------------------------------------------------------

bind(
    MOD .. " + RIGHT",
    hl.dsp.focus({ workspace = "r+1" }),
    "[Workspaces|Navigation] next workspace"
)

bind(
    MOD .. " + LEFT",
    hl.dsp.focus({ workspace = "r-1" }),
    "[Workspaces|Navigation] previous workspace"
)

bind(
    MOD .. " + SHIFT + RIGHT",
    hl.dsp.window.move({ workspace = "r+1", follow = true }),
    "[Workspaces|Move window] move window to next workspace"
)

bind(
    MOD .. " + SHIFT + LEFT",
    hl.dsp.window.move({ workspace = "r-1", follow = true }),
    "[Workspaces|Move window] move window to previous workspace"
)

bind(
    MOD .. " + ALT + RIGHT",
    hl.dsp.focus({ monitor = "r" }),
    "[Monitors|Navigation] focus monitor to the right"
)

bind(
    MOD .. " + ALT + LEFT",
    hl.dsp.focus({ monitor = "l" }),
    "[Monitors|Navigation] focus monitor to the left"
)

bind(
    MOD .. " + ALT + SHIFT + RIGHT",
    hl.dsp.window.move({ monitor = "r", follow = true }),
    "[Monitors|Move window] move window to monitor on the right"
)

bind(
    MOD .. " + ALT + SHIFT + LEFT",
    hl.dsp.window.move({ monitor = "l", follow = true }),
    "[Monitors|Move window] move window to monitor on the left"
)

-- Add a smooth 3-finger workspace swipe. Setting invert=false makes the
-- swipe direction direct: left goes left and right goes right.
hl.config({
    gestures = {
        workspace_swipe_invert = false,
        workspace_swipe_use_r = true,
    },
})
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Keep HyDE's OCR feature, moved away from SUPER + CONTROL + S.
bind(
    MOD .. " + CONTROL + SHIFT + S",
    hl.dsp.exec_cmd(hyde.sh.screenshot.ocr()),
    "[Utilities|Screen Capture] OCR scanner",
    { locked = true }
)

-- ---------------------------------------------------------------------------
-- Launchers and applications
-- ---------------------------------------------------------------------------

-- HyDE's default rule floats every Dolphin window. This later rule restores
-- normal Dolphin windows to tiled, true fullscreen mode while leaving its
-- file-operation dialogs alone.
hl.window_rule({
    name = "user_dolphin_fullscreen",
    match = {
        class = "org\\.kde\\.dolphin",
        title = "negative:(Progress Dialog — Dolphin|Copying — Dolphin|File Operation Progress)",
    },
    tile = true,
    fullscreen = true,
})

bind(
    MOD .. " + E",
    hl.dsp.exec_cmd("dolphin"),
    "[Launcher|Apps] Dolphin file manager (fullscreen)"
)

bind(
    MOD .. " + RETURN",
    hl.dsp.exec_cmd(apps.terminal),
    "[Launcher|Apps] terminal emulator"
)

bind(
    MOD .. " + SPACE",
    hl.dsp.exec_cmd("[float; move 20% 5%; size 60% 60%] " .. apps.terminal),
    "[Launcher|Apps] dropdown terminal"
)

bind(
    MOD .. " + M",
    hl.dsp.exec_cmd("hyde-shell system.monitor.sh"),
    "[Launcher|Apps] system monitor"
)

bind(
    MOD .. " + D",
    hl.dsp.exec_cmd(hyde.sh.menu.apps()),
    "[Launcher|Rofi menus] application finder"
)

bind(
    MOD .. " + SHIFT + D",
    hl.dsp.exec_cmd(hyde.sh.menu.launcher()),
    "[Launcher|Rofi menus] select launcher"
)

-- ---------------------------------------------------------------------------
-- Function-row audio controls
-- ---------------------------------------------------------------------------

bind(
    "F1",
    hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")),
    "[Hardware Controls|Audio] mute output",
    { locked = true }
)

bind(
    "F2",
    hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "d")),
    "[Hardware Controls|Audio] decrease volume",
    { locked = true, repeating = true }
)

bind(
    "F3",
    hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "i")),
    "[Hardware Controls|Audio] increase volume",
    { locked = true, repeating = true }
)

-- ---------------------------------------------------------------------------
-- Screenshots
-- ---------------------------------------------------------------------------

bind(
    MOD .. " + SHIFT + C",
    hl.dsp.exec_cmd("hyprpicker -an"),
    "[Utilities|Screen Capture] color picker"
)

bind(
    MOD .. " + Print",
    hl.dsp.exec_cmd(hyde.sh.screenshot.snip()),
    "[Utilities|Screen Capture] snip screen"
)

-- Everything else from the old file is already supplied by current HyDE:
-- SUPER+Q / ALT+F4, groups, mouse move/resize, media and brightness keys,
-- theming, workspaces 1-10, relative workspace movement, and scratchpad.
--
-- The old Right-Alt + Right-Control Waybar bind is intentionally not restored:
-- HyDE replaced it because those names are keysyms rather than usable modifiers.
-- Current Waybar toggle: SUPER + CONTROL + B.
