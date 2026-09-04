# Disk Usage Monitoring Script (`disk-check.sh`)

A Bash utility to check filesystem disk usage against a user-defined threshold, intended for health checks, automated cron jobs, and monitoring pipelines.

---

## Features

- **Configurable Target:** Checks any valid directory or mount point (defaults to `/`).
- **Integer Validation:** Enforces thresholds between 1 and 100.
- **Predictable Exit Codes:** Adheres to standard monitoring plugin status conventions.

---

## Requirements & Permissions

Make the script executable before running:

```bash
chmod +x disk-check.sh
```
---

## Usage
```bash
./disk-check.sh [PATH] [THRESHOLD]
```
## Exit Codes
- **Exit Code 0:** This means the status is ok
- **Exit Code 1:** This means the status is alert
- **Exit Code 2:** This means the status is Error