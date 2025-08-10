from __future__ import annotations

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .api.routes import root as root_route
from .core.config import get_settings
from .core.logging import get_logger

settings = get_settings()
logger = get_logger(__name__)

app = FastAPI(title=settings.app_name)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.backend_cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routers
app.include_router(root_route.router, prefix=settings.api_v1_prefix)


@app.get("/", tags=["system"], summary="Root")
async def root() -> dict[str, str]:
    logger.debug("Root endpoint called")
    return {"message": f"Welcome to {settings.app_name}"}
