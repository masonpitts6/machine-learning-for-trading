# Machine Learning for Trading Instructions

## Purpose

Own the educational notebook corpus for the second edition of *Machine Learning
for Algorithmic Trading* and its reproducible core notebook environment inside
the parent `quant-ai-devcontainer` workspace.

## Ownership

- Chapter and appendix notebooks plus their local README files.
- Source-owned sample files already tracked under `data/` and chapter folders.
- `pyproject.toml`, `uv.lock`, `scripts/setup_environment.sh`, and environment
  smoke tests.
- Historical environment references under `installation/`.

## Local Contracts

- Run Python, uv, Jupyter, tests, and notebook tooling through the parent Docker
  Compose `workspace` service. Do not install project dependencies on Windows or
  the WSL host.
- Keep the supported core environment at
  `/home/developer/.local/share/uv-project-envs/machine-learning-for-trading`.
  Do not create or use a repo-local `.venv`.
- The locked core environment uses Python 3.11. Historical Python 3.8 Conda and
  pip files remain reference material for the original examples, not the
  supported parent-workspace environment.
- The core lock covers Jupyter and common analytics dependencies. Treat
  backtesting, deep learning, NLP, reinforcement learning, and other
  chapter-specific stacks as separate compatibility work; do not add all legacy
  requirements to the core environment without independent verification.
- `data/` contains tracked source materials. Write new downloads, caches,
  models, and other high-I/O generated state under `data/runtime/`, which the
  parent Compose project mounts from a named Docker volume.
- Keep this repository independently versioned. Publish child changes before
  advancing its gitlink in the parent repository.

## Work Guidance

- Preserve the educational notebooks and their executed output unless a task
  explicitly targets them.
- Avoid bulk notebook reformatting or re-execution as part of environment work.
- Add a dependency only when a supported notebook or test consumes it.
- Keep environment setup non-interactive and safe to rerun.

## Verification

From the parent WSL checkout, run:

```bash
docker compose exec workspace bash /workspace/projects/machine-learning-for-trading/scripts/setup_environment.sh --verify
```

The setup must create the dedicated Docker-owned environment, pass the core
import tests, and report a working Jupyter Lab version.

## Child DOX Index

| Child | Scope |
|---|---|
| _None_ | No child AGENTS.md files. |
