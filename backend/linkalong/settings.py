from decouple import config


DEBUG = config("LL_DEBUG", default=False, cast=bool)
