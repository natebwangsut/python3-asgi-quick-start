from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def index():
    """
    Base route. Used for healthcheck.
    """
    return {}
