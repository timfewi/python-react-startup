"""Application configuration using Pydantic Settings.

Central place for configuration. Avoid importing other application modules here to
prevent circular imports. Keep only settings definitions and related helpers.
"""

from __future__ import annotations

from functools import lru_cache
from typing import List

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = "python-react-startup"
    env: str = "dev"
    api_v1_prefix: str = "/api/v1"
    backend_cors_origins: List[str] = ["http://localhost:3000"]
    log_level: str = "info"

    class Config:
        env_file = ".env"
        case_sensitive = False


@lru_cache(maxsize=1)
def get_settings() -> Settings:
    """Return a cached singleton of settings to avoid re-parsing env vars."""
    return Settings()
