#!/bin/bash

if [ -z "$1" ]; then
echo "Usage: $0 <YouTube Playlist URL>"
exit 1
fi
PLAYLIST_URL="$1"
echo "Starting download for playlist: $PLAYLIST_URL"
yt-dlp -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" "$PLAYLIST_URL"
echo "Download completed."

