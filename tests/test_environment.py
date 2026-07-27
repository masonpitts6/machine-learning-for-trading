import os
import sys
from importlib import import_module
from pathlib import Path

import pytest

from utils import MultipleTimeSeriesCV, format_time

CORE_IMPORTS = (
    "IPython",
    "jupyterlab",
    "matplotlib",
    "numpy",
    "openpyxl",
    "pandas",
    "pandas_datareader",
    "pyarrow",
    "requests",
    "scipy",
    "seaborn",
    "sklearn",
    "statsmodels",
    "tables",
    "yfinance",
)


@pytest.mark.parametrize("module_name", CORE_IMPORTS)
def test_core_notebook_dependency_imports(module_name: str) -> None:
    assert import_module(module_name) is not None


def test_supported_python_version() -> None:
    assert sys.version_info[:2] == (3, 11)


def test_project_utility_module_executes() -> None:
    assert format_time(3661) == "01:01:01"
    assert MultipleTimeSeriesCV().get_n_splits(None, None) == 3


def test_environment_is_outside_the_source_checkout() -> None:
    project_environment = os.environ.get("UV_PROJECT_ENVIRONMENT")
    assert project_environment

    repo_root = Path(__file__).resolve().parents[1]
    environment_path = Path(project_environment).resolve()
    expected_path = Path(
        "/home/developer/.local/share/uv-project-envs/machine-learning-for-trading"
    )

    assert environment_path == expected_path
    assert not environment_path.is_relative_to(repo_root)


def test_runtime_data_directory_is_writable() -> None:
    runtime_data_dir = os.environ.get("ML4T_DATA_DIR")
    assert runtime_data_dir

    data_path = Path(runtime_data_dir)
    data_path.mkdir(parents=True, exist_ok=True)
    probe = data_path / ".environment-write-test"
    probe.write_text("ok\n", encoding="utf-8")
    assert probe.read_text(encoding="utf-8") == "ok\n"
    probe.unlink()
