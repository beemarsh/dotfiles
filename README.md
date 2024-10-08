# Welcome to my setup!
![Desktop Preview](./Pictures/Preview/arch_preview.png "Desktop Preview")

Hi! I have configured the code for Arch on a HiDPI display. You can configure it according to your needs.

### X not Wayland
>I chose X because I found it easy to configure with Nvidia drivers.

## Window Manger

### Ly
I have used [Ly](https://github.com/fairyglade/ly) window manager. It is a lightweight window manager with console UI. You can install it using from the [repo](https://archlinux.org/packages/?name=ly).
> After installing Ly, enable it using systemctl.

```bash
sudo systemctl enable ly.service
```
> I am using Ly only for login.
> I am using **I3** tiling window manager for general purpose after login.

### I3
The setup for I3 is pretty simple. Install i3-wm package from the [repo](https://archlinux.org/packages/?name=i3-wm) and copy the files configuration files to .config/i3/config.
To use my I3 configuration, you will need following programs or modules.
- [JetBrainsMono Nerd Font](https://archlinux.org/packages/extra/any/ttf-jetbrains-mono-nerd/)
- [Brightnessctl](https://archlinux.org/packages/extra/x86_64/brightnessctl/) to change brightness of the screen
- [Alacritty](https://wiki.archlinux.org/title/Alacritty) terminal emulator
- [Rofi](https://wiki.archlinux.org/title/Rofi) for dialogs and menus
- [Polybar](https://wiki.archlinux.org/title/Polybar) for status bar.
- [playerctl](https://archlinux.org/packages/extra/x86_64/playerctl/) to control media buttons if you have one.
- [xsecurelock](https://archlinux.org/packages/extra/x86_64/xsecurelock/) to lock the screen
- [xss-lock](https://archlinux.org/packages/extra/x86_64/xss-lock/) to control screen locks
- [clipmenu](https://archlinux.org/packages/extra/any/clipmenu/) to maintain a clipboard history

### Enable Tap to Click on Touchpad
As described in the [Arch Wiki](https://wiki.archlinux.org/title/Touchpad_Synaptics), I had to use [libinput](https://wiki.archlinux.org/title/Libinput). X already has libinput by default. So, I installed [xf86-input-libinput](https://archlinux.org/packages/?name=xf86-input-libinput) and [xorg-xinput](https://archlinux.org/packages/?name=xorg-xinput). 
> After installing, restart the device.

Then type this in the terminal.
```bash
xinput list
```
It will print a list of devices like this.
```
Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ SYNA2BA6:00 06CB:CEC0 Mouse             	id=10	[slave  pointer  (2)]
⎜   ↳ SYNA2BA6:00 06CB:CEC0 Touchpad          	id=11	[slave  pointer  (2)]
⎜   ↳ GXTP7936:00 27C6:0123                   	id=12	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Video Bus                               	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
```
The ID of touch pad is **11**.
To view, the props type:
```bash
xinput list-props 11
```

It will output something like this:
```
Device 'SYNA2BA6:00 06CB:CEC0 Touchpad':
	Device Enabled (171):	1
	Coordinate Transformation Matrix (173):	1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
	libinput Tapping Enabled (327):	0
	libinput Tapping Enabled Default (328):	0
	libinput Tapping Drag Enabled (329):	1
```
> Here, the Tapping is disabled as it is set to 0.

To enable tapping, type:
```bash
xinput set-prop 11 327 1
```
> Note: Make sure you do this everytime you start the X server or put it somewhere in the window manager config. I have put it in i3 config.


## Audio Setup
I setup my Sound System as described in the [Arch Wiki](https://wiki.archlinux.org/title/Sound_system). I installed [PulseAudio](https://wiki.archlinux.org/title/PulseAudio) sound server and other extra pulseaudio modules like [pulseaudio-alsa](https://archlinux.org/packages/?name=pulseaudio-alsa) and [pulseaudio-bluetooth](https://archlinux.org/packages/?name=pulseaudio-bluetooth).

## Microphone setup
It is the same as audio setup. For a GUI based interface, I installed [PulseAudio Volume Control](https://archlinux.org/packages/?name=pavucontrol). 

## Bluetooth Setup
Follow the [Arch Wiki](https://wiki.archlinux.org/title/Bluetooth). I installed [bluez](https://archlinux.org/packages/?name=bluez) and [bluez-utils](https://archlinux.org/packages/?name=bluez-utils) packages. 
For GUI, I installed [blueman](https://archlinux.org/packages/?name=blueman).

## Notification Setup
Install [dunst](https://wiki.archlinux.org/title/Dunst) package. The configuration for dunst is in .config/dunst/dunstrc

## Charging Notification
Open the script in [.local/bin/chargingnotify](https://www.github.com/beemarsh/dotfiles/tree/main/.local/bin).
Change the parameters accordingly. The DBUS_SESSION_ADDRESS might be different.

To get the battery levels, you might have to change the device name. For me, its BAT0.
Check using the following command:
```bash
ls -a /sys/class/power_supply
```
Check the script and after it works properly, you have to setup [udev rules](https://wiki.archlinux.org/title/Udev).

In /etc/udev/rules.d/charging.rules, put the following code.
```bash
# Rule for when switching to battery
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/iambee/.Xauthority" RUN+="/usr/bin/su iambee -c '/home/iambee/.local/bin/chargingnotify 0'"

# Rule for when switching to AC
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/iambee/.Xauthority" RUN+="/usr/bin/su iambee -c '/home/iambee/.local/bin/chargingnotify 1'"
```

**Reload** udev rule using:
```bash
sudo udevadm control --reload-rules
```
>Remember to change the attributes and values based on your device. The attributes might be different. To check the attributes for a device use the following
```
sudo udevadm info -a /sys/class/power_supply/ADP0
```

## Low Battery and Full Battery Notification
The script for battery notification is in [.local/bin/batterynotify](https://www.github.com/beemarsh/iambee/dotfiles/tree/main/.local/bin).
Then, you have to make systemctl services and timers. They are available in [~/.config/systemd/user/](https://www.github.com/beemarsh/dotfiles/tree/main/.config/systemd/user). 
After putting the services and timers in place, load and start it.
```bash
systemctl --user daemon-reload
systemctl --user enable --now alert-battery.timer

# Optionally check that the timer is active
systemctl --user list-timers
```

## Screen Lock and Lid Close

I have used [xsecurelock](https://archlinux.org/packages/extra/x86_64/xsecurelock/) for screen locking.
I have made a systemd service to lock before the lid closes. However, it should also be done by xss-lock as already coded in i3 config.

I have added the following code in /usr/lib/systemd/system-sleep/xsecurelock and marked the file as executable.  This will ensure that it will lock before suspend/hibernate. The process is described in Github link: [xsecurelock](https://github.com/google/xsecurelock)

```bash
#!/bin/bash
if [[ "$1" = "post" ]] ; then
  pkill -x -USR2 xsecurelock
fi
exit 0
```

For automatic locking, I used xss-lock and added the following code to i3 config.
```bash
exec --no-startup-id xset s 300 5
exec --no-startup-id xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock
```

> Note: Make sure to disable secure boot on windows if dual boot. It caused problem during shutdown and recovery from suspend.


## Taking Screenshot
I used [maim](https://man.archlinux.org/man/extra/maim/maim.1.en) for screenshot. The screenshot script is written in [.local/bin/screenshot](https://github.com/beemarsh/dotfiles/tree/main/.local/bin).
The keybindings are available in the i3 config file.

## Vim and NeoVim
### Neovim
Plugin Manager: [lazy.nvim](https://github.com/folke/lazy.nvim)

Package to Install:
- [unzip](https://archlinux.org/packages/extra/x86_64/unzip/)
- [nodejs](https://wiki.archlinux.org/title/Node.js)
- [npm](https://archlinux.org/packages/extra/any/npm/)
- [python-pip](https://archlinux.org/packages/extra/any/python-pip/)
- [lua](https://archlinux.org/packages/?name=lua)
- [luarocks](https://archlinux.org/packages/extra/any/luarocks/)
- [stylua](https://archlinux.org/packages/extra/x86_64/stylua/), Lua Code formatter
- [eslint](https://archlinux.org/packages/extra/any/eslint/), linter for JS
- [flake8](https://archlinux.org/packages/extra/any/flake8/), linter for python
- [cpplint](https://archlinux.org/packages/extra/any/python-cpplint/), static code checker for C++
- [black](https://archlinux.org/packages/extra/any/python-black/), python code formatter
- [ripgrep](https://archlinux.org/packages/extra/x86_64/ripgrep/)
- [tree-sitter](https://archlinux.org/packages/extra/x86_64/tree-sitter/).
> There may be other requirements. Just install them if any error pops up


Plugins:
- [lazy.nvim](https://lazy.folke.io/installation) for plugin management
- [mason.nvim](https://github.com/williamboman/mason.nvim) for managing LSP servers
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) For mason.nvim and lspconfig
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) LSP
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) Tree Sitter and Highlighting
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) fuzzy finder
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) Dashboard
- [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file) Status Bar
- [nvim-colorizer](https://github.com/NvChad/nvim-colorizer.lua) Colors display for color code
- [twilight.nvim](https://github.com/folke/twilight.nvim) Dim inactive part of code
- [nvim-bufdel](https://github.com/ojroques/nvim-bufdel) Deleting buffers
- [catpuccin](https://github.com/catppuccin/nvim) Theme
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) For buffer tabs
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) For buffer autocompletions
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) Nvim Auto Completion
- [cmp-path](https://github.com/hrsh7th/cmp-path) Path Auto Completions
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) Command Line Auto Completions
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua) Lua Auto Completions
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) LSP Auto Completions
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) Snippet Engine
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) Bunch of snippets
- [comment.nvim](https://github.com/numToStr/Comment.nvim) Commenting
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) Git Decoration
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) Indentation
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) Code Formatting
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) Code Formatting
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) AutoPairing
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) File Explorer
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) Comment based on cursor location
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) For Icons
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) Lua Functions Library
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) Fuzzy Finder
- [telescope-media-files.nvim](https://github.com/nvim-telescope/telescope-media-files.nvim) Preview Media Files in Neovim
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) Terminal Integration
- [which-key.nvim](https://github.com/folke/which-key.nvim) Key Binding Help
- [trouble.nvim](https://github.com/folke/trouble.nvim) Diagnostics
- [cinnamon.nvim](https://github.com/declancm/cinnamon.nvim) For scrolling effect
- [project.nvim](https://github.com/ahmedkhalf/project.nvim) Project Management
- [compiler.nvim](https://github.com/Zeioth/compiler.nvim) Code Runner




## Common Applications
- [GIMP](https://wiki.archlinux.org/title/GIMP) for Image Editing
- [Feh](https://wiki.archlinux.org/title/Feh) for image view.
- [Thunar](https://wiki.archlinux.org/title/Thunar) for file manager.
- [Neovim](https://wiki.archlinux.org/title/Neovim) for code editor
- [Picom](https://wiki.archlinux.org/title/Picom) for background blur and opacity.
- [Firefox](https://wiki.archlinux.org/title/Firefox)  Browser

## Some Issues
- ### Firefox cannot save files
> Change ownership of the directory. It might be set to root. Change ownership using chown to current user
