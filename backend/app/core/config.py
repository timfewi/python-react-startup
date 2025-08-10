"""Application configuration using Pydantic Settings.

Central place for configuration. Avoid importing other application modules here
to prevent circular imports. Keep only settings definitions and related helpers.
"""

from __future__ import annotations

from functools import lru_cache

from pydantic import Field, computed_field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application runtime settings loaded from environment or .env.

    Field names map to environment variables (case-insensitive) automatically:
    APP_NAME, ENV, API_V1_PREFIX, LOG_LEVEL, BACKEND_CORS_ORIGINS.
    """

    model_config = SettingsConfigDict(
        env_file=(".env.development.local",),  # primary for local dev (untracked)
        case_sensitive=False,
    )

    # Core app settings (provide safe defaults so instantiation has no missing args)
    app_name: str = Field("python-react-startup", description="Human-friendly app name")
    env: str = Field("dev", description="Runtime environment identifier")
    api_v1_prefix: str = Field("/api/v1", description="Base prefix for v1 API routes")
    log_level: str = Field("info", description="Logging level")
    secret_key: str | None = Field(
        None,
        description="Application secret key (required in production for auth/session/security)",
    )

    # Comma separated list of CORS origins
    backend_cors_origins: str = Field(
        "http://localhost:3000,http://127.0.0.1:3000",
        description="Comma separated list of allowed CORS origins",
    )

    @computed_field  # type: ignore[misc]
    @property
    def backend_cors_origins_list(self) -> list[str]:
        """Return cleaned list of CORS origins parsed from BACKEND_CORS_ORIGINS.

        Strips whitespace, removes empties, de-duplicates while preserving order.
        """
        raw = self.backend_cors_origins
        if not raw:
            return []
        seen: set[str] = set()
        origins: list[str] = []
        for part in raw.split(","):
            origin = part.strip()
            if origin and origin not in seen:
                seen.add(origin)
                origins.append(origin)
        return origins


@lru_cache(maxsize=1)
def get_settings() -> Settings:
    """Return a cached singleton of settings to avoid re-parsing env vars."""
    return Settings()  # type: ignore[call-arg]
