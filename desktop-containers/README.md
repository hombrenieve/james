# Desktop Environment Testing with Podman

Disposable desktop environments running in Podman containers, accessible via VNC.

## Pre-requisites

On the host (Ubuntu/Debian):

```sh
sudo apt-get install -y tigervnc-viewer
```

Podman must be installed and working (rootless mode is fine).

## Project structure

```
desktop-containers/
├── connect.sh          # Shared VNC connect script
├── README.md
├── sway/               # Sway tiling WM test
│   ├── Containerfile
│   ├── entrypoint.sh
│   └── sway-config
└── niri/               # Niri scrollable-tiling compositor test
    ├── Containerfile
    ├── entrypoint.sh
    └── niri-config.kdl
```

Each subfolder contains a self-contained desktop test with its own `Containerfile`.

## Running a test

### Sway

```sh
cd sway
podman build -t arch-sway-test .
podman run -d --name sway-test -p 5900:5900 --security-opt label=disable arch-sway-test
```

Open a terminal remotely:

```sh
podman exec sway-test swaymsg exec foot
```

### Niri

Niri uses Smithay (not wlroots), so it runs nested inside cage as a headless Wayland compositor.

```sh
cd niri
podman build -t arch-niri-test .
podman run -d --name niri-test -p 5900:5900 --security-opt label=disable arch-niri-test
```

Open a terminal remotely:

```sh
podman exec niri-test sh -c 'NIRI_SOCKET=$(ls /tmp/runtime-testuser/niri.*.sock) niri msg action spawn -- foot'
```

### Connect

From the project root:

```sh
./connect.sh
# or with a custom port:
./connect.sh 5901
```

### Dispose

```sh
podman stop <name> && podman rm <name>
```

Remove the image too if no longer needed:

```sh
podman rmi <image-name>
```

## Shortcuts

The modifier key is `Alt` for all tests (to avoid conflicts with the host GNOME desktop).

### Sway

| Shortcut              | Action              |
|-----------------------|---------------------|
| Alt + Enter           | Open terminal       |
| Alt + Shift + Q       | Close window        |
| Alt + H/J/K/L         | Focus left/down/up/right |
| Alt + Shift + H/J/K/L | Move window         |
| Alt + 1-5             | Switch workspace    |
| Alt + B / V           | Split horizontal/vertical |
| Alt + W               | Tabbed layout       |
| Alt + S               | Stacking layout     |
| Alt + E               | Toggle split        |
| Alt + F               | Fullscreen          |
| Alt + Shift + Space   | Toggle floating     |
| Alt + Shift + C       | Reload config       |
| Alt + Shift + E       | Exit sway           |

### Niri

| Shortcut              | Action              |
|-----------------------|---------------------|
| Alt + Enter           | Open terminal       |
| Alt + D               | App launcher (fuzzel) |
| Alt + Shift + Q       | Close window        |
| Alt + H/L             | Focus column left/right |
| Alt + J/K             | Focus window/workspace down/up |
| Alt + Shift + H/L     | Move column left/right |
| Alt + Shift + J/K     | Move window down/up |
| Alt + 1-5             | Switch workspace    |
| Alt + Shift + 1-5     | Move window to workspace |
| Alt + F               | Maximize column     |
| Alt + Shift + Space   | Toggle floating     |
| Alt + Shift + E       | Quit niri           |

## Adding a new desktop test

1. Create a new subfolder (e.g. `hyprland/`)
2. Add a `Containerfile` based on Arch Linux
3. Key points for headless Wayland in a container:
   - Set `WLR_BACKENDS=headless` and `WLR_LIBINPUT_NO_DEVICES=1`
   - Strip file capabilities if needed: `setcap -r /usr/bin/<binary>`
   - Use `wayvnc` to expose the display over VNC (no auth by default)
   - Create `XDG_RUNTIME_DIR` before starting the compositor
   - For non-wlroots compositors (e.g. niri), run nested inside `cage`
4. Build and run following the same pattern above
