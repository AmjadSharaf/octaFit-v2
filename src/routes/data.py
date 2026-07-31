

from fastapi import  APIRouter, Depends, UploadFile, File
import os
from helpers.config import get_settings
from controller import DataController

data_router = APIRouter(
prefix="/api/v1/data",
tags=["api_v1" , "data"]
)


@data_router.post("/upload/{user_id}")
async def upload_data(user_id: str, file: UploadFile = File(...),
             app_settings = Depends(get_settings)):
    
    is_vald = DataController().vaildata_uploade_file(file=file)
    return is_vald