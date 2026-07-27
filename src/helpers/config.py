from  pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    AppName: str
    AppVersion: str
    APP_ENV: str
    class Config:
        env_file = ".env"
        

def get_settings() :
    return Settings()