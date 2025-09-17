from langchain_huggingface import HuggingFaceEmbeddings, HuggingFacePipeline
from langchain_community.vectorstores import Chroma
from transformers import pipeline
from .utils import embeddings
from langchain.prompts import ChatPromptTemplate
import transformers
import re
from .create_db import generate_data_store

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



def query(text: str, filename: str, db=db, score=0.7, model="microsoft/phi-1", model_type="text-generation"):
    generate_data_store()
    results = db._similarity_search_with_relevance_scores(
        text,
        k=3,
        filter={"source": filename}
    )
    # print(f'Matching : {len(results)}')
    print(f'Matching chunks: {len(results)}')
    
    for i, (doc, sim_score) in enumerate(results):
        print(f"Chunk {i}: similarity={sim_score}")
        print(f"Content preview: {doc.page_content[:200]}...\n")
    if len(results) == 0 or results[0][1] < score:
        print('Unable to find matching results.')
        return
    
    context_text = "\n\n -----=====----- \n\n".join(f"{doc.page_content}" for doc, score in results)

    # clean_text = clean_question(text)
    
    # promp_template = ChatPromptTemplate.from_template(PROMPT_TEMPLATE)
    prompt = PROMPT_TEMPLATE.format(context=context_text, question=text)

    generator = pipeline(
        model_type,
        model=model,
        max_new_tokens=200,
        # device_map='auto'
    )
    
    llm = HuggingFacePipeline(pipeline=generator, verbose=False)
    response = llm(prompt)
    # response = clean_question(llm(prompt))
    sources = [doc.metadata.get('source', None) for doc, _score in results]

    formateed_response = f"Response: {response}\n\nSources: {sources}"

    return formateed_response