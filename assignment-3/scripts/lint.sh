cd "$(dirname "$0")/.." || exit 1
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
errors=0
for file in "${Required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Error: Required file '$file' is missing."
        errors=$((errors + 1))
    fi
done

echo ""
echo "Checking bash scripts for syntax errors..."
for script in app/*.sh scripts/*.sh tests/*.sh; do
    [ -f "$script" ] || continue

    if bash -n "$script"; then
        echo "syntax check passed for $script"
    else
        echo "syntax check failed for $script"
        errors=$((errors + 1))
    fi
done
if [ $errors -ne 0 ]; then
    echo "lint check failed with $errors number of errors"
    exit 1
fi

echo "No errors found in required files and bash scripts......."
echo "lint passed!"
exit 0
# So we check if the bash scripts are executable 