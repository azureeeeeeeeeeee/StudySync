from ollama import Client
from langchain_community.vectorstores import Chroma
from services.utils import embeddings
from services.create_db import generate_data_store

PROMPT_TEMPLATE = """
You are a helpful assistant for question-answering tasks.
Answer using only the provided context.
Answer also based on the language of the question.
Answer concisely and accurately using your own words.
Use only and only the given context.

Context:
{context}

User: {question}
Assistant:
"""

client = Client(host='http://localhost:11434')

CHROMA_PATH = 'chroma'
db = Chroma(persist_directory=CHROMA_PATH, embedding_function=embeddings)

def query(text: str, filename: str, db=db, score=0.7, total_chunks=3):
    generate_data_store()
    results = db._similarity_search_with_relevance_scores(
        text,
        k=total_chunks,
        filter={"source": filename}
    )

    print(f"Matching chunks: {len(results)}")

    if len(results) == 0 or results[0][1] < score:
        return "There is no answer to that question in the sources."

    context_text = "\n\n-----\n\n".join(
        doc.page_content for doc, _ in results
    )

    prompt = PROMPT_TEMPLATE.format(context=context_text, question=text)

    response = client.chat(
        model="llama3.2:3b",
        messages=[{"role": "user", "content": prompt}]
    )

    return response["message"]["content"]