# Welcome to my setup!

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

Make a file in /etc/systemd/system/lock@.service
Then, paste the following code.
```bash
[Unit]
Description=Lock before Sleep
Before=sleep.target

[Service]
User=%I
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/xsecurelock
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target
```

After making the file, enable and start the service.
```bash
sudo systemctl enable --now lock@username.service
```

> **Suspend on Lid Close**
Open logind.conf on /etc/systemd and edit the file
In the file, change HandleLidSwitch to suspend.


## Taking Screenshot
I used [maim](https://man.archlinux.org/man/extra/maim/maim.1.en) for screenshot. The screenshot script is written in [.local/bin/screenshot](https://github.com/beemarsh/dotfiles/tree/main/.local/bin).
The keybindings are available in the i3 config file.

## Vim and NeoVim


## Common Applications
- [GIMP](https://wiki.archlinux.org/title/GIMP) for Image Editing
- [Feh](https://wiki.archlinux.org/title/Feh) for image view.
- [Thunar](https://wiki.archlinux.org/title/Thunar) for file manager.
- [Neovim](https://wiki.archlinux.org/title/Neovim) for code editor
- [Picom](https://wiki.archlinux.org/title/Picom) for background blur and opacity.

## Some Issues
- ### Firefox cannot save files
> Change ownership of the directory. It might be set to root. Change ownership using chown to current user
