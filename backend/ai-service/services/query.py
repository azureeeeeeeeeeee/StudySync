from langchain_huggingface import HuggingFaceEmbeddings, HuggingFacePipeline
from langchain_community.vectorstores import Chroma
from transformers import pipeline, AutoModelForCausalLM, AutoTokenizer
from services.utils import embeddings
from langchain.prompts import ChatPromptTemplate
import transformers
import re
from services.create_db import generate_data_store
import torch

transformers.logging.set_verbosity_error()

CHROMA_PATH = 'chroma'
db = Chroma(persist_directory=CHROMA_PATH, embedding_function=embeddings)

PROMPT_TEMPLATE = """
You are a helpful assistant for question-answering tasks.
Answer the question using only the provided context.
Be concise, accurate, and use your own words.
Answer according to the language of the questions.
If it is in Bahasa Indonesia, answer in bahasa indonesia and answer in english if the questions is in english.
Use only and only the context, if its not in the context, answer with "There is no answer to that question in the sources".

Context:
{context}

User: {question}
Assistant:
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

    tokenizer = AutoTokenizer.from_pretrained(model)
    model = AutoModelForCausalLM.from_pretrained(
        model,
        device_map="auto",
        load_in_4bit=True,
    )

    generator = pipeline(
        model_type,
        model=model,
        tokenizer=tokenizer,
        max_new_tokens=200,
        # device=0 if torch.cuda.is_available() else -1  
    )
    
    llm = HuggingFacePipeline(pipeline=generator, verbose=False)
    response = llm(prompt)
    # response = clean_question(llm(prompt))
    sources = [doc.metadata.get('source', None) for doc, _score in results]


    return response.split("Assistant:")[-1].strip()