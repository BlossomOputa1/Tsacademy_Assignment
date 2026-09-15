#!/usr/bin/env bash
# tests/test.sh - Automated test suite for app/app.sh

cd "$(dirname "$0")/.." || exit 1

PASSED=0
FAILED=0
APP="./app/app.sh"

run_test() {
  local desc="$1"
  local expected_exit="$2"
  shift 2

  "$APP" "$@" >/dev/null 2>&1
  local actual_exit=$?

  if [ "$actual_exit" -eq "$expected_exit" ]; then
    echo "PASS: $desc (exit code $actual_exit)"
    PASSED=$((PASSED + 1))
  else
    echo "FAIL: $desc (expected $expected_exit, got $actual_exit)"
    FAILED=$((FAILED + 1))
  fi
}

echo "=== Running App Test Suite ==="

# 1. Help command succeeds (exit 0)
run_test "help command exits with 0" 0 help

# 2. system-info command succeeds (exit 0)
run_test "system-info command exits with 0" 0 system-info

# 3. Invalid command fails with exit 2
run_test "invalid command exits with 2" 2 nonexistent-command

# 4. Missing command argument fails with exit 2
run_test "missing command argument exits with 2" 2

# 5. check-host with missing host fails with exit 2
run_test "check-host missing host exits with 2" 2 check-host

# 6. check-host with valid localhost succeeds (exit 0)
run_test "check-host valid host (localhost) exits with 0" 0 check-host localhost

# 7. check-port with missing arguments fails with exit 2
run_test "check-port missing arguments exits with 2" 2 check-port localhost

# 8. check-port with non-numeric port fails with exit 2
run_test "check-port non-numeric port exits with 2" 2 check-port localhost abc

# 9. check-port with port 0 (out of range) fails with exit 2
run_test "check-port port 0 out of range exits with 2" 2 check-port localhost 0

# 10. check-port with port 65536 (out of range) fails with exit 2
run_test "check-port port 65536 out of range exits with 2" 2 check-port localhost 65536

echo "==============================="
echo "Passed: $PASSED"
echo "Failed: $FAILED"

if [ "$FAILED" -ne 0 ]; then
  exit 1
fi

exit 0