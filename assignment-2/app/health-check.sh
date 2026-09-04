#! /bin/bash
# to check the health of the diagnostic script
if ./diagnostic.sh help; then
    echo "Health check script executed successfully."
    exit 0
else
    echo "Health check script failed. Please check the diagnostic script for errors." >&2
    exit 1
fi