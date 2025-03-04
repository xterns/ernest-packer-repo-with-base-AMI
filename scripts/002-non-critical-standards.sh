#!/bin/bash
echo "Applying non-critical security configurations..."
# Example: Set a banner message
echo "Unauthorized access prohibited" | sudo tee /etc/motd
