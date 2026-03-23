#!/bin/sh
# Connect to a running desktop test container via VNC
# Usage: ./connect.sh [port]
PORT="${1:-5900}"
vncviewer "localhost:$PORT"
