#!/bin/bash

echo "Starting diagnostic tool tests..."

# 1. Test help command (expected exit code: 0)
echo "Testing: help"
docker run --rm diagnostic-tool help
if [ $? -eq 0 ]; then
    echo "PASS: help"
else
    echo "FAIL: help"
    exit 1
fi

# 2. Test system command (expected exit code: 0)
echo "Testing: system"
docker run --rm diagnostic-tool system
if [ $? -eq 0 ]; then
    echo "PASS: system"
else
    echo "FAIL: system"
    exit 1
fi

# 3. Test disk command (expected exit code: 0)
echo "Testing: disk"
docker run --rm diagnostic-tool disk
if [ $? -eq 0 ]; then
    echo "PASS: disk"
else
    echo "FAIL: disk"
    exit 1
fi

# 4. Test invalid command handling (expected exit code: 2)
echo "Testing: invalid command"
docker run --rm diagnostic-tool foobar
if [ $? -eq 2 ]; then
    echo "PASS: invalid command"
else
    echo "FAIL: invalid command"
    exit 1
fi

echo "All tests passed successfully!"