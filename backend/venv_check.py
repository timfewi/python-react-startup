"""Virtual environment safety check.

This module ensures that critical operations only run within a virtual environment.
Import this at the beginning of any script that requires a virtual environment.
"""

import os
import sys
from pathlib import Path


def is_in_virtual_env() -> bool:
    """Check if we're running in a virtual environment."""
    return (
        hasattr(sys, "real_prefix")
        or (hasattr(sys, "base_prefix") and sys.base_prefix != sys.prefix)
        or os.environ.get("VIRTUAL_ENV") is not None
    )


def get_project_venv_path() -> Path:
    """Get the expected virtual environment path for this project."""
    return Path(__file__).parent / ".venv"


def ensure_virtual_env(auto_create: bool = False) -> None:
    """Ensure we're running in a virtual environment.

    Args:
        auto_create: If True, attempt to create a virtual environment if none exists.

    Raises:
        SystemExit: If not in virtual environment and auto_create is False.
    """
    if is_in_virtual_env():
        return

    venv_path = get_project_venv_path()

    if not venv_path.exists() and auto_create:
        print(f"🔧 Creating virtual environment at {venv_path}")
        import subprocess

        subprocess.run([sys.executable, "-m", "venv", str(venv_path)], check=True)
        print("✅ Virtual environment created")
        print(f"💡 Activate it with: {venv_path / 'Scripts' / 'Activate.ps1'}")
        print("Then run: pip install -r requirements.txt")
        sys.exit(0)

    print("❌ This script must be run in a virtual environment!")
    print()
    print("To fix this:")
    print("1. Create virtual environment: python -m venv .venv")
    print("2. Activate it:")
    if os.name == "nt":  # Windows
        print(f"   .venv\\Scripts\\Activate.ps1")
    else:  # Unix/Linux/macOS
        print(f"   source .venv/bin/activate")
    print("3. Install dependencies: pip install -r requirements.txt")
    print("4. Run this script again")
    print()
    print("Or use: make install-dev")
    sys.exit(1)


def get_venv_info() -> dict:
    """Get information about the current virtual environment."""
    return {
        "in_venv": is_in_virtual_env(),
        "python_executable": sys.executable,
        "python_prefix": sys.prefix,
        "virtual_env": os.environ.get("VIRTUAL_ENV"),
        "project_venv_exists": get_project_venv_path().exists(),
    }


if __name__ == "__main__":
    # When run directly, show virtual environment status
    info = get_venv_info()
    print("🐍 Python Virtual Environment Status")
    print("=" * 40)
    print(f"In virtual environment: {'✅ Yes' if info['in_venv'] else '❌ No'}")
    print(f"Python executable: {info['python_executable']}")
    print(f"Python prefix: {info['python_prefix']}")
    print(f"VIRTUAL_ENV: {info['virtual_env'] or 'Not set'}")
    print(f"Project .venv exists: {'✅ Yes' if info['project_venv_exists'] else '❌ No'}")

    if not info["in_venv"]:
        print("\n⚠️  You should activate a virtual environment!")
        ensure_virtual_env(auto_create=False)
