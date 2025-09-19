from langchain_huggingface import HuggingFaceEmbeddings, HuggingFacePipeline
from langchain_community.vectorstores import Chroma
from langchain_community.llms import CTransformers
from transformers import pipeline
from services.utils import embeddings
from langchain.prompts import ChatPromptTemplate
from huggingface_hub import hf_hub_download
import transformers
import torch
import re
from services.create_db import generate_data_store

transformers.logging.set_verbosity_error()

CHROMA_PATH = 'chroma'
db = Chroma(persist_directory=CHROMA_PATH, embedding_function=embeddings)

PROMPT_TEMPLATE = """
You are a helpful assistant for question-answering tasks.
Answer the question using only the provided context.
Be concise, accurate, and use your own words.

Context:
{context}

Question:
{question}

Answer:
"""

def query(
    text: str,
    filename: str,
    db=db,
    score=0.7,
    repo_id="TheBloke/Mistral-7B-Instruct-v0.2-GGUF",
    filename_gguf="mistral-7b-instruct-v0.2.Q4_K_M.gguf"
):
    generate_data_store()
    results = db._similarity_search_with_relevance_scores(
        text,
        k=3,
        filter={"source": filename}
    )
    
    print(f'Matching chunks: {len(results)}')
    for i, (doc, sim_score) in enumerate(results):
        print(f"Chunk {i}: similarity={sim_score}")
        print(f"Content preview: {doc.page_content[:200]}...\n")

    if len(results) == 0 or results[0][1] < score:
        print('Unable to find matching results.')
        return
    
    context_text = "\n\n -----=====----- \n\n".join(
        f"{doc.page_content}" for doc, score in results
    )

    prompt = PROMPT_TEMPLATE.format(context=context_text, question=text)

    model_path = hf_hub_download(
        repo_id=repo_id,
        filename=filename_gguf
    )

    llm = CTransformers(
        model=model_path,
        model_type="mistral",
        config={
            "max_new_tokens": 200,
            "temperature": 0.7,
            "gpu_layers": 50
        }
    )
    
    response = llm(prompt)
    sources = [doc.metadata.get('source', None) for doc, _score in results]

    return response.strip()