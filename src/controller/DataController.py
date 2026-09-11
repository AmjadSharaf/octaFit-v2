from fastapi import UploadFile
from model import ResponeSignals
from helpers.config import get_settings
from .BaseController import BaseController
import os
from .projectController import ProjectController
import re
class DataController(BaseController):

    def __init__(self):
        super().__init__()
        self.app_settings = get_settings()
        self.size_scale = 1024 * 1024

    def vaildata_uploade_file(self, file: UploadFile):

        if file.content_type not in self.app_settings.FILE_ALLOWED_TYPSE:
            return False , ResponeSignals.FILE_TYPE_NOT_SUPPORTED.value

        if file.size > self.app_settings.FILE_MAX_SIZE_MB * self.size_scale:
            return False , ResponeSignals.FILE_SIZE_EXCEEDED.value

        return True , ResponeSignals.FILE_VALIDATION_SUCSSES.value

    def genrate_uniqe_filepath(self , origan_file_name : str , project_id:str):
        random_key = self.generate_random_string()
        project_path = ProjectController().get_project_path(project_id=project_id)


        cleand_file_name = self.get_clean_file_name(
            origan_file_name=origan_file_name
        )


        new_file_path = os.path.join(
            project_path , random_key + "_" + cleand_file_name
        )

        while os.path.exists(new_file_path):
            random_key = self.generate_random_string()
            new_file_path = os.path.join(
                project_path , random_key + "_"+cleand_file_name
            )
            return new_file_path, random_key + "_" +cleand_file_name

    def get_clean_file_name(self ,origan_file_name:str ):
        cleand_file_name = re.sub(r'[^\w]' , '' , origan_file_name.strip())
        cleand_file_name = cleand_file_name.replace("" , "_")
        return cleand_file_name


        