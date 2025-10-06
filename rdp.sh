#!/bin/bash

# This tool is a wrapper for the xfreerdp utility to fasten rdp connections from linux -> windows systems as fast as possible. Because Remmina's current released version has issues on building RDP connections to machines.
# This script is adjustable for own purpose. Any improvement suggestions are welcome.
# Prerequisities: Installed freerdp2-x11 package on the system.

# Standard values
USER="your_user"
PASS="your_super_secret_password"
HOST=""
WIDTH=1920
HEIGHT=1000
FULLSCREEN=false
ENABLE_DRIVES=false
SMARTSIZING=false
REMOTEAPP=""
MULTIMON=false
EXTRA_ARGS=""
DRIVE=""

usage() {
    echo "Usage: $0 -u <username> -p <password> -h <host> [Options]"
    echo ""
    echo "Options:"
    echo "  -u USER        Username"
    echo "  -p PASS        Password"
    echo "  -h HOST        Target host/IP"
    echo "  -w WIDTH       Window width"
    echo "  -t HEIGHT      Window height"
    echo "  -f             Fullscreen"
    echo "  -g             ++drives "
    echo "  -s             Smart Sizing activation"
    echo "  -m             Multi-Monitor activation"
    echo "  -x EXTRA       More xfreerdp arguments (e.g. \"/cert-ignore /clipboard\")"
    echo "  --help         Show this help"
    exit 1
}

# Argument parsing
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -u) USER="$2"; shift ;;
        -p) PASS="$2"; shift ;;
        -h) HOST="$2"; shift ;;
        -w) WIDTH="$2"; shift ;;
        -t) HEIGHT="$2"; shift ;;
        -f) FULLSCREEN=true ;;
	-g) ENABLE_DRIVES=true ;;
        -s) SMARTSIZING=true ;;
        -m) MULTIMON=true ;;
        -x) EXTRA_ARGS="$2"; shift ;;
        --help) usage ;;
        *) echo "Unknown Option: $1"; usage ;;
    esac
    shift
done

if [[ -z "$USER" || -z "$PASS" || -z "$HOST" ]]; then
    echo "Error: Username, Password and Host are mandatory!"
    usage
fi

# Build command
CMD="xfreerdp /u:$USER /p:$PASS /v:$HOST"

if $FULLSCREEN; then
    CMD+=" /f"
else
    CMD+=" /size:${WIDTH}x${HEIGHT}"
fi

if $ENABLE_DRIVES; then
    CMD+=" +drives"
fi

if $SMARTSIZING; then
    CMD+=" /dynamic-resolution"
fi

if $MULTIMON; then
    CMD+=" /multimon"
fi


if [[ -n "$EXTRA_ARGS" ]]; then
    CMD+=" $EXTRA_ARGS"
fi

echo "Start: $CMD"
eval "$CMD"
