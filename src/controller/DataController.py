from fastapi import UploadFile
from model import ResponeSignals
from helpers.config import get_settings
from .BaseController import BaseController


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