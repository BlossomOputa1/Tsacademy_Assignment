
```markdown
# Assignment 2 - Dockerized Diagnostic CLI

A Dockerized Linux diagnostic application that packages diagnostic scripts into a lightweight container managed via Docker CLI and Docker Compose.

---

## ⚙️ Installation & Setup

### Prerequisites
* Docker Engine
* Docker Compose

### Building the Image
Build the Docker image locally using the standard command:
```bash
docker build -t diagnostic-tool .

```

---

## 🚀 Usage

The application can be run directly using Docker or via Docker Compose.

### Running with Docker

```bash
# Display help and available commands
docker run --rm diagnostic-tool help

# Display system information
docker run --rm diagnostic-tool system

# Display disk usage information
docker run --rm diagnostic-tool disk

# Run network check against a host
docker run --rm diagnostic-tool network <hostname-or-ip>

```

### Running with Docker Compose

```bash
# Execute commands via compose
docker compose run --rm diagnostic help
docker compose run --rm diagnostic system
docker compose run --rm diagnostic disk

```

---

## 🔢 Exit Codes

* `0`: Success
* `1`: Operational or runtime failure
* `2`: Invalid command or missing input arguments

---

## 🧪 Testing & Grading

### Running Test Suite

Execute the local test script covering commands and exit code assertions:

```bash
chmod +x test.sh
./test.sh

```

### Running the Grader

Run the provided assignment evaluation script:

```bash
chmod +x grade.sh test.sh app/*.sh
./grade.sh

```

---

## 📝 Assumptions

* Scripts run in a Linux environment and rely on lightweight base utilities.
* The diagnostic tool executes as a one-shot CLI command inside ephemeral containers (`--rm`).
* Network connectivity is available for checks requiring external host resolution.

```

---