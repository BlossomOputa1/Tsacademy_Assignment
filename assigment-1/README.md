Here is an updated `README.md` that expands your draft into a complete guide for the entire toolkit, covering all four sections required by the assignment rubric: **Installation/Setup**, **Usage**, **Testing**, and **Assumptions**.

Notice one important fix included below: according to the assignment brief, `disk-check.sh` takes `<threshold>` first, followed by the optional `[path]` (`./disk-check.sh <threshold> [path]`).

---

```markdown
# Linux Diagnostic Toolkit (Assignment 1)

A diagnostic toolkit built with Bash to collect system information, monitor disk usage, and conduct network health checks[cite: 1].

---

## Project Structure

```text
assignment-1/
├── README.md
├── system-info.sh
├── disk-check.sh
├── network-check.sh
├── grade.sh
└── logs/
    └── .gitkeep
```[cite: 1]

---

## Installation & Setup

1. Clone the repository and navigate into the project root directory[cite: 1]:
   ```bash
   git clone <your-repository-url>
   cd assignment-1
   ```[cite: 1]

2. Grant execute permissions to all shell scripts[cite: 1]:
   ```bash
   chmod +x grade.sh *.sh
   ```[cite: 1]

3. Ensure the `logs/` directory exists for operation logging[cite: 1]:
   ```bash
   mkdir -p logs

```

---

## Usage

### 1. System Information (`system-info.sh`)

Collects and displays runtime system metrics including hostname, current user, date/time, operating system, kernel version, uptime, CPU information, memory information, and current working directory.

```bash
./system-info.sh

```

### 2. Disk Usage Check (`disk-check.sh`)

Checks filesystem disk usage against an integer threshold.

* **Syntax:** `./disk-check.sh <threshold> [path]`

* **Default Path:** `/`

* **Threshold Range:** `1` to `100`


```bash
# Check root filesystem with an 80% threshold
./disk-check.sh 80

# Check a custom mount point with a 50% threshold
./disk-check.sh 50 /home

```

### 3. Network Check (`network-check.sh`)

Resolves hosts, verifies ICMP reachability, displays interface details, and optionally tests TCP ports.

* **Syntax:** `./network-check.sh <hostname-or-ip> [port]`

* **Port Range:** `1` to `65535`


```bash
# Basic host check and interface report
./network-check.sh google.com

# Host check with TCP port verification
./network-check.sh google.com 443

```

---

## Exit Codes

All scripts follow standard exit status conventions:

* `0`: Success / Normal condition (e.g., disk usage below threshold, network check passed).


* `1`: Warning or operational failure (e.g., disk threshold exceeded, host resolution failure).


* `2`: Invalid argument or syntax error (e.g., missing host, out-of-range port or threshold).



---

## Logging

Operations and timestamps are recorded in the `logs/` directory:

* `logs/disk-check.log`
* `logs/network-check.log`

---

## Testing

Run the automated test runner to validate script syntax, permissions, and behavior:

```bash
./grade.sh
```[cite: 1]

---

## Assumptions

- Scripts are executed in a standard Linux Bash environment (e.g., Ubuntu/Debian or WSL2)[cite: 1].
- Utilities such as `ping`, `ip`, `nc` (netcat), and `getent` are installed and available in the system `$PATH`.
- No root/sudo privileges are required for standard monitoring operations.

```

---

Review the **Assumptions** section at the bottom: are there any specific tools (like `netcat` or particular Linux distributions) or settings unique to your WSL setup that you'd like to adjust or add?