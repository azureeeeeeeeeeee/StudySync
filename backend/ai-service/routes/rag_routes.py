from fastapi import APIRouter
from pydantic import BaseModel
from services import query

router = APIRouter()

class QuestionRequest(BaseModel):
    question: str
    source: str

@router.post("/query")
async def ask_question(payload: QuestionRequest):
    question = payload.question
    source = payload.source

    answer = query.query(question, source, score=0, model="tiiuae/falcon-7b-instruct")

    return {
        "answer": answer
    }
