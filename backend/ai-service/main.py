from fastapi import FastAPI
from routes import rag_routes

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello World"}

app.include_router(rag_routes.router, prefix="/api")