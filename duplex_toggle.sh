#!/bin/sh

# Created by:
# Jory A. Pratt - W5GLE
# Freddie "Freddie Mac" McGuire - KD5FMU (but only by my thoughts)


# Path to the rpt.conf file
CONF_FILE="/etc/asterisk/rpt.conf"

# Check if script is run by root
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run as root."
  exit 1
fi

# Check if node argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <node_number>"
  exit 1
fi

# Node number to change
NODE="$1"

# Check if the rpt.conf file exists
if [ ! -f "$CONF_FILE" ]; then
  echo "Error: $CONF_FILE not found."
  exit 1
fi

# Check current duplex setting for the node
CURRENT_DUPLEX=$(grep -A 10 "^\[$NODE\]" "$CONF_FILE" | \
  grep "^duplex" | sed 's/duplex *= *//' | tr -d ' ')

# Toggle duplex setting
if [ "$CURRENT_DUPLEX" = "1" ]; then
  NEW_DUPLEX="0"
elif [ "$CURRENT_DUPLEX" = "0" ]; then
  NEW_DUPLEX="1"
else
  echo "Error: Unexpected duplex setting ($CURRENT_DUPLEX). \
    Manual check required."
  exit 1
fi

# Apply the new duplex setting, creating a .bak backup
sed -i.bak "/^\[$NODE\]/,/\[/{s/^duplex *=.*/duplex = $NEW_DUPLEX/}" \
  "$CONF_FILE"

# Restart Asterisk to apply changes
if command -v systemctl >/dev/null 2>&1; then
  systemctl restart asterisk
else
  echo "Warning: Unable to restart Asterisk. Please restart manually."
fi

# Confirm the change
echo "Duplex setting for node $NODE has been toggled to $NEW_DUPLEX."
