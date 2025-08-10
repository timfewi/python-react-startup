from __future__ import annotations

from fastapi import APIRouter

router = APIRouter()


@router.get("/health", summary="Health check", tags=["system"])
async def health() -> dict[str, str]:
    return {"status": "ok"}
