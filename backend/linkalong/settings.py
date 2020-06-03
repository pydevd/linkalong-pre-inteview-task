from pathlib import Path
from decouple import config


DEBUG = config("LL_DEBUG", default=False, cast=bool)
STATIC_DIR = Path(__file__).parent / "static"
TEMPLATES_DIR = Path(__file__).parent / "templates"
