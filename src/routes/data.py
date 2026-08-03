

from fastapi import  APIRouter, Depends, UploadFile, File , status
from fastapi.responses import JSONResponse
import os
from helpers.config import get_settings
from controller import DataController
from controller import ProjectController
import aiofiles
from model import ResponeSignals

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
    # return {"user_id": project_id, "file_name": file.filename, "file_type": file.content_type, "file_size": file.size, "validation_result": is_vald, "validation_signal": resultSignal}



    project_dir_path = ProjectController().get_project_path(project_id=user_id)
    file_path = os.path.join(project_dir_path, file.filename)


    async with aiofiles.open(file_path, 'wb') as f:
        while chunk := await file.read(app_settings.FIILE_DEFAULT_CHUNK_SIZE):  # Read the file in chunks
            await f.write(chunk)

    return JSONResponse(
                
                content={"message": ResponeSignals.FILE_UPLOAD_SUCCSESS.value}
            )