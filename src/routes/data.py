

from fastapi import  APIRouter, Depends, UploadFile, File , status
from fastapi.responses import JSONResponse
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
    
    is_vald , resultSignal = DataController().vaildata_uploade_file(file=file)

    if not is_vald :
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={"message": resultSignal}
        )
    return {"user_id": user_id, "file_name": file.filename, "file_type": file.content_type, "file_size": file.size, "validation_result": is_vald, "validation_signal": resultSignal}