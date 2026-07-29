# Machine Learning for Trading Instructions

## Purpose

Own the third-edition *Machine Learning for Trading* notebook corpus, case
studies, package metadata, tests, and reproducible runtime used inside the
parent `quant-ai-devcontainer` workspace.

## Ownership

- Chapter and case-study notebooks, paired Python files, and local README files.
- Source-owned fixtures and metadata already tracked under `data/`.
- `pyproject.toml`, `uv.lock`, `docker-compose.yml`, `envs/`, `scripts/`, and
  `tests/`.
- The independent Git history and `masonpitts6/machine-learning-for-trading`
  remote.

## Local Contracts

- Run the main third-edition environment through the parent Docker Compose
  service `machine-learning-for-trading`. Do not install project dependencies
  on Windows, in WSL, or into the parent `workspace` environment.
- The main image is `ml4t/ml4t:latest`, uses Python 3.14, mounts this repository
  at `/app`, and mounts the protected
  `quant-ai-devcontainer_machine-learning-for-trading-data` volume at `/data`.
- Keep `ML4T_DATA_PATH=/data` for downloads, caches, models, and other
  high-I/O generated state. Tracked source material remains visible under
  `/app/data`.
- Treat the child `docker-compose.yml` and specialized profiles as upstream
  project assets. The parent Compose project owns the normal IDE, verification,
  source-mount, and durable-volume path.
- Keep this repository independently versioned. Publish child changes before
  advancing its gitlink in the parent repository.

## Work Guidance

- Preserve paired notebooks and Python files according to the project's own
  synchronization rules.
- Avoid bulk notebook reformatting or re-execution unless a task explicitly
  targets it.
- Use the child lockfile and image as the dependency sources of truth.
- Keep credentials out of tracked files and do not run data-download, broker,
  or external-service workflows without explicit authorization.

## Verification

From the parent WSL checkout, run:

```bash
docker compose pull machine-learning-for-trading
docker compose run --rm machine-learning-for-trading \
  python scripts/verify_installation.py
```

Use the child project's focused tests for source changes. Do not claim that the
installation check executes every notebook or validates specialized Compose
profiles.

## Child DOX Index

| Child | Scope |
|---|---|
| _None_ | No child AGENTS.md files. |
