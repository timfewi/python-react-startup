"""Logging configuration helper.

Provides a get_logger function that configures structured logging once.
"""

from __future__ import annotations

import logging
from functools import lru_cache
from typing import Optional

from .config import get_settings


@lru_cache(maxsize=32)
def _build_logger(name: str) -> logging.Logger:
    settings = get_settings()
    level = getattr(logging, settings.log_level.upper(), logging.INFO)
    logger = logging.getLogger(name)
    if not logger.handlers:
        handler = logging.StreamHandler()
        formatter = logging.Formatter("%(asctime)s | %(levelname)s | %(name)s | %(message)s")
        handler.setFormatter(formatter)
        logger.addHandler(handler)
    logger.setLevel(level)
    logger.propagate = False
    return logger


def get_logger(name: Optional[str] = None) -> logging.Logger:
    """Get a configured logger. Defaults to root app logger name."""
    return _build_logger(name or get_settings().app_name)
