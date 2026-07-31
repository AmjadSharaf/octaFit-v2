from enum import Enum


class ResponeSignals(Enum):
    FILE_VALIDATION_FAILED = "file validation failed"
    FILE_VALIDATION_SUCSSES = "file validation succsess"
    FILE_TYPE_NOT_SUPPORTED = "file type not supported"
    FILE_SIZE_EXCEEDED = "file size exceeded"
    FILE_UPLOAD_SUCCSESS = "file upload succsess"
    FILE_UPLOAD_FALED = "file upload failed"