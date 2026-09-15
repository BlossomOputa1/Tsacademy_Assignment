# DevOps CI/CD & Automation Suite (Assignment 3)

A lightweight containerized command-line utility featuring an automated multi-stage GitHub Actions CI/CD pipeline, local test suites, and Docker health smoke testing.

---

## Installation & Setup

### Prerequisites
* **Bash** (v4.0 or higher)
* **Docker** & **Docker Compose**
* **Git**

### Setup
1. Clone the repository:
```bash
   git clone https://github.com/BlossomOputa1/Tsacademy_Assignment.git
   cd Tsacademy_Assignment
```

2. Ensure all scripts have executable permissions:
```bash
   chmod +x app/*.sh scripts/*.sh tests/*.sh grade.sh
```

---

## Usage Instructions

The application provides system diagnostic and networking utilities via `./app/app.sh`.

### Available Commands

* **Display Help / Usage:**
```bash
  ./app/app.sh help
```
  Exits with code `0`.

* **Display System Information:**
```bash
  ./app/app.sh system-info
```
  Outputs OS details, kernel version, hostname, and basic resource metrics.

* **Check Host Reachability:**
```bash
  ./app/app.sh check-host <hostname_or_ip>
```
  Pings or validates reachability of the target host.

* **Check Port Status:**
```bash
  ./app/app.sh check-port <hostname_or_ip> <port>
```
  Validates if a target port is open. Enforces port boundaries between `1` and `65535`. Rejects invalid inputs (e.g., non-numeric strings, `0`, or `65536`) with exit code `2`.

---

## Docker & Containerization

The project includes an optimized Alpine-based container image running as a non-root user.

### Build Image

```bash
./scripts/build.sh
```

### Run with Docker Directly

```bash
docker run --rm student-devops-ci-grader help
docker run --rm student-devops-ci-grader system-info
```

### Run with Docker Compose

```bash
docker compose up --build
```

---

## Testing & Local Validation

The repository includes complete static analysis, unit testing, and full grader automation.

1. **Linting and Syntax Checks:**
```bash
   ./scripts/lint.sh
```
   Validates repository structure and runs `bash -n` checks on all shell scripts.

2. **Automated Test Suite:**
```bash
   ./tests/test.sh
```
   Executes assertions against all commands, arguments, edge cases, and expected exit codes.

3. **Complete Assignment Grading Script:**
```bash
   ./grade.sh
```
   Executes the full evaluation rubric locally.

---

## CI/CD Pipeline Architecture

The automated GitHub Actions pipeline (`.github/workflows/ci.yml`) runs on all pushes and pull requests across three interdependent stages:

1. **`validate` Job**: Checks out the code and runs `./scripts/lint.sh`.
2. **`test` Job**: Depends on `validate` (`needs: validate`). Runs the full unit test suite via `./tests/test.sh`.
3. **`docker` Job**: Depends on `test` (`needs: test`). Sets up Docker Buildx, builds the container image, and runs automated container smoke tests via `./scripts/build.sh`.

---

## CI Failure Demonstration

To satisfy the rubric requirement for demonstrating automated CI failure handling:

1. **Branch Creation**: A dedicated branch named `ci-check` was created off `main`.
2. **Intentional Error Introduced**: In `tests/test.sh`, the expected exit code assertion for the `help` command was intentionally changed from `0` to `99`:
```bash
   # Intentional failure introduced:
   run_test "help command exits with 0" 99 help
```
3. **Pipeline Behavior Observed**:
   * The `validate` job succeeded (syntax check passed).
   * The `test` job failed with exit code `1` due to the assertion mismatch.
   * The `docker` job was automatically skipped/canceled because of the dependency constraint (`needs: test`).
4. **Resolution**: The assertion was reverted back to `0`, committed, and pushed. The subsequent pipeline run passed all three stages (`validate` → `test` → `docker`), after which the branch was merged into `main`.

---

## Assumptions & Design Considerations

* **Execution Environment**: Scripts are developed with POSIX-compliant syntax and Unix LF line endings for execution in Linux, macOS, and WSL 2 environments.
* **Non-Root Execution**: Docker containers default to a non-privileged user for enhanced security.
* **Strict Parameter Checking**: Missing subcommands, unparseable arguments, and out-of-range ports consistently yield exit code `2`.
