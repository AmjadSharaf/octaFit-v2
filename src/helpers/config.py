from typing import List
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    APP_NAME: str
    APP_VERSION: str
    APP_ENV: str
    FILE_ALLOWED_TYPSE: List[str]
    FILE_MAX_SIZE_MB: int

    model_config = SettingsConfigDict(
        env_file="src/.env",
        extra="ignore"
    )

def get_settings():
    return Settings()