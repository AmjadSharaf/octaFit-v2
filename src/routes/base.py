

from fastapi import FastAPI , APIRouter
import os
from helpers.config import get_settings


base_router = APIRouter(
prefix="/api/v1",
tags=["api_v1"]
)


@base_router.get("/")
async def welcome():
    app_settings = get_settings()
    app_name= app_settings.AppName
    app_version= app_settings.AppVersion
    return {"message": "Welcome to the API of " + app_name + " version " + app_version}