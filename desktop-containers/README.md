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
└── sway/               # Sway tiling WM test
    ├── Containerfile
    ├── entrypoint.sh
    └── sway-config
```

Each subfolder contains a self-contained desktop test with its own `Containerfile`.

## Running a test

### Build

```sh
cd sway
podman build -t arch-sway-test .
```

### Start

```sh
podman run -d --name sway-test -p 5900:5900 --security-opt label=disable arch-sway-test
```

### Connect

From the project root:

```sh
./connect.sh
# or with a custom port:
./connect.sh 5901
```

### Interact remotely

Open a terminal inside the running session:

```sh
podman exec sway-test swaymsg exec foot
```

### Dispose

```sh
podman stop sway-test && podman rm sway-test
```

Remove the image too if no longer needed:

```sh
podman rmi arch-sway-test
```

## Sway shortcuts

The modifier key is `Alt` (to avoid conflicts with the host GNOME desktop).

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

## Adding a new desktop test

1. Create a new subfolder (e.g. `hyprland/`)
2. Add a `Containerfile` based on Arch Linux
3. Key points for headless Wayland in a container:
   - Set `WLR_BACKENDS=headless` and `WLR_LIBINPUT_NO_DEVICES=1`
   - Strip file capabilities if needed: `setcap -r /usr/bin/<binary>`
   - Use `wayvnc` to expose the display over VNC (no auth by default)
   - Create `XDG_RUNTIME_DIR` before starting the compositor
4. Build and run following the same pattern above
