# Welcome to my setup!

Hi! I have configured the code for Arch on a HiDPI display. You can configure it according to your needs.

### X not Wayland
>I chose X because I found it easy to configure with Nvidia drivers.

## Audio Setup
I setup my Sound System as described in the [Arch Wiki](https://wiki.archlinux.org/title/Sound_system). I installed [PulseAudio](https://wiki.archlinux.org/title/PulseAudio) sound server and other extra pulseaudio modules like [pulseaudio-alsa](https://archlinux.org/packages/?name=pulseaudio-alsa) and [pulseaudio-bluetooth](https://archlinux.org/packages/?name=pulseaudio-bluetooth).

## Bluetooth Setup

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

