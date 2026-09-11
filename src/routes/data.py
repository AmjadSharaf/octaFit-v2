

from fastapi import  APIRouter, Depends, UploadFile, File , status
from fastapi.responses import JSONResponse
import os
from helpers.config import get_settings
from controller import DataController
from controller import ProjectController
import aiofiles
from model import ResponeSignals
import logging


loggar = logging.getLogger("unicorn.error")
data_router = APIRouter(
prefix="/api/v1/data",
tags=["api_v1" , "data"]
)


@data_router.post("/upload/{user_id}")
async def upload_data(user_id: str, file: UploadFile = File(...),
             app_settings = Depends(get_settings)):
    data_comtroller = DataController()
    is_vald , resultSignal = data_comtroller.vaildata_uploade_file(file=file)

    if not is_vald :
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={"message": resultSignal}
        )
    # return {"user_id": project_id, "file_name": file.filename, "file_type": file.content_type, "file_size": file.size, "validation_result": is_vald, "validation_signal": resultSignal}



    project_dir_path = ProjectController().get_project_path(project_id=user_id)
    file_path  , file_id= data_comtroller.genrate_uniqe_filepath(
        origan_file_name=file.filename,
        project_id=user_id
    )

    try:
        async with aiofiles.open(file_path, 'wb') as f:
          while chunk := await file.read(app_settings.FIILE_DEFAULT_CHUNK_SIZE):  # Read the file in chunks
            await f.write(chunk)


    except Exception as e:
        loggar.error(f"Error occurred while uploading file: {e}")
        return JSONResponse(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    content={"message": ResponeSignals.FILE_UPLOAD_FALED.value}
                )

    return JSONResponse(
                
                content={"message": ResponeSignals.FILE_UPLOAD_SUCCSESS.value ,
                          "file_id" : file_id }
            )