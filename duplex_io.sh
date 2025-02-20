#!/bin/bash

# Path to the rpt.conf file
CONF_FILE="/etc/asterisk/rpt.conf"

# Node number to change
NODE="YOUR_NODE_NUMBER_HERE"

# Check if the rpt.conf file exists
if [[ ! -f "$CONF_FILE" ]]; then
  echo "Error: $CONF_FILE not found."
  exit 1
fi

# Check current duplex setting for node 58176
CURRENT_DUPLEX=$(grep -A 10 "^\[$NODE\]" "$CONF_FILE" | grep "^duplex" | awk -F'=' '{print $2}' | tr -d ' ')

# Toggle duplex setting
if [[ "$CURRENT_DUPLEX" == "1" ]]; then
  NEW_DUPLEX="0"
elif [[ "$CURRENT_DUPLEX" == "0" ]]; then
  NEW_DUPLEX="1"
else
  echo "Error: Unexpected duplex setting ($CURRENT_DUPLEX). Manual check required."
  exit 1
fi

# Backup the current rpt.conf file
cp "$CONF_FILE" "${CONF_FILE}.bak"

# Apply the new duplex setting
sed -i "/^\[$NODE\]/,/\[/{s/^duplex\s*=.*/duplex = $NEW_DUPLEX/}" "$CONF_FILE"

# Restart Asterisk to apply changes
systemctl restart asterisk

# Confirm the change
echo "Duplex setting for node $NODE has been toggled to $NEW_DUPLEX."
