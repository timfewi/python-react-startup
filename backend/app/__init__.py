"""App package initializer.

Makes `app` a regular package so tests and scripts can `import app.main`.
Optionally exposes the FastAPI instance as `app_instance`.
"""

from .main import app as app_instance  # noqa: F401
