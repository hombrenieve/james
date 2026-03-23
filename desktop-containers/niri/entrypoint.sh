#!/bin/sh
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

# Background helper: set resolution and start wayvnc once cage is ready
(
    while [ ! -e "$XDG_RUNTIME_DIR/wayland-0" ]; do sleep 0.5; done
    sleep 2
    WAYLAND_DISPLAY=wayland-0 wlr-randr --output HEADLESS-1 --custom-mode 1280x720
    WAYLAND_DISPLAY=wayland-0 wayvnc 0.0.0.0 5900
) &

# cage runs niri as a nested Wayland client
exec cage -- niri
