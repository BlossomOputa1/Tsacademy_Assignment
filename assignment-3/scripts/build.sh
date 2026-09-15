#!/usr/bin/env bash
# scripts/build.sh - Build Docker image and run smoke tests

cd "$(dirname "$0")/.." || exit 1

IMAGE_NAME="devops-tool"
ERRORS=0

echo "=== Building Docker image: $IMAGE_NAME ==="
if ! docker build -t "$IMAGE_NAME" .; then
  echo "Error: Docker build failed."
  exit 1
fi

echo "=== Running Docker Smoke Tests ==="

# 1. Smoke test: help command
echo "Testing 'help' command..."
if docker run --rm "$IMAGE_NAME" help >/dev/null 2>&1; then
  echo "PASS: help smoke test"
else
  echo "FAIL: help smoke test failed"
  ERRORS=$((ERRORS + 1))
fi

# 2. Smoke test: system-info command
echo "Testing 'system-info' command..."
if docker run --rm "$IMAGE_NAME" system-info >/dev/null 2>&1; then
  echo "PASS: system-info smoke test"
else
  echo "FAIL: system-info smoke test failed"
  ERRORS=$((ERRORS + 1))
fi

# 3. Smoke test: invalid command must fail (non-zero exit)
echo "Testing invalid command handling..."
if ! docker run --rm "$IMAGE_NAME" invalid-subcommand >/dev/null 2>&1; then
  echo "PASS: invalid command correctly failed"
else
  echo "FAIL: invalid command returned exit 0 unexpectedly"
  ERRORS=$((ERRORS + 1))
fi

echo "=================================="
if [ "$ERRORS" -ne 0 ]; then
  echo "Smoke tests failed with $ERRORS error(s)."
  exit 1
fi

echo "All Docker smoke tests passed!"
exit 0