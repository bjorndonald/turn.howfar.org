#!/bin/sh

# Simple health check for the STUN server
# Check if the server is listening on port 3478

if netstat -tuln | grep -q ":3478 "; then
    echo "STUN server is running on port 3478"
    exit 0
else
    echo "STUN server is not running on port 3478"
    exit 1
fi 