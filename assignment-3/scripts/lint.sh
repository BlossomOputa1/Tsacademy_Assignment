Required_files=(
    "README.md"
    "Dockerfile"
    "compose.yaml"
    ".dockerignore"
    ".github/workflows/ci.yml"
    "app/app.sh"
    "scripts/lint.sh"
    "scripts/build.sh"
    "tests/test.sh"
)
# so first we check if the file exists

# So we check if the bash scripts are executable 