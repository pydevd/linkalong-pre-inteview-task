import uvicorn
from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from linkalong import settings

app = FastAPI(debug=settings.DEBUG, version="0.1.0")
app.mount("/static", StaticFiles(directory="static"), name="static")
j2 = Jinja2Templates(directory="templates")


@app.get("/")
def index(request: Request):
    return j2.TemplateResponse("index.html", {"request": request})


@app.get("/api/hello")
def read_root():
    return {"Hello": "World"}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, debug=settings.DEBUG)
