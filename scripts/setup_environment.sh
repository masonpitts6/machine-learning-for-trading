#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat <<'EOF'
Usage:
  bash scripts/setup_environment.sh [--verify]

Create the locked Python 3.11 core notebook environment. Run this script only
inside the parent quant-ai-devcontainer Docker Compose workspace service.
EOF
}

verify=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --verify)
            verify=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
    esac
done

if [[ ! -f /.dockerenv ]]; then
    echo "This setup must run inside the parent Docker Compose workspace." >&2
    exit 1
fi

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(cd -- "${script_dir}/.." && pwd)
project_environment=/home/developer/.local/share/uv-project-envs/machine-learning-for-trading
runtime_data_dir=${ML4T_DATA_DIR:-${repo_root}/data/runtime}

case "${project_environment}" in
    "${repo_root}"|"${repo_root}"/*)
        echo "UV_PROJECT_ENVIRONMENT must be outside the source checkout: ${project_environment}" >&2
        exit 1
        ;;
esac

export UV_PROJECT_ENVIRONMENT="${project_environment}"
export ML4T_DATA_DIR="${runtime_data_dir}"

mkdir -p "${project_environment}" "${runtime_data_dir}"
cd "${repo_root}"

echo "Project: ${repo_root}"
echo "Environment: ${UV_PROJECT_ENVIRONMENT}"
echo "Runtime data: ${ML4T_DATA_DIR}"

uv sync --frozen --python 3.11

if [[ "${verify}" == true ]]; then
    uv lock --check
    uv run pytest tests/test_environment.py
    uv run ruff check tests
    uv run jupyter lab --version
fi

uv run python -c 'import sys; print(sys.executable); print(sys.version.split()[0])'
