#!/bin/bash

# Batch wget script
# One per line, end with a blank line
# By NMS-LemonTec

TMP_FILE=$(mktemp)   # Temp file to save the link(s).

echo "Please enter the link(s) you want to download (One per line, end with a blank line)"

# Loop to read user input
while true; do
    read -r url
    if [ -z "$url" ]; then
        break
    fi
    echo "$url" >> "$TMP_FILE"
done

# Check if there is an input link
if [ ! -s "$TMP_FILE" ]; then
    echo "No links detected... The script is now exited."
    rm -f "$TMP_FILE"
    exit 1
fi

echo "Here are the link(s) you are going to downloading"
cat "$TMP_FILE"

# Ask the user to confirm whether to start the download
read -p "If start downloading? type (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Cancel downloading"
    rm -f "$TMP_FILE"
    exit 0
fi

echo "Starting batching downloading..."

# Execute wget download, -c supports resuming downloads, --show-progress displays progress
wget -c -i "$TMP_FILE" --show-progress

# Cleaning up temporary files
rm -f "$TMP_FILE"

echo "Download finished."
