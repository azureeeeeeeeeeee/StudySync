from langchain_community.document_loaders import PyPDFDirectoryLoader
from langchain.schema import Document
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_community.vectorstores import Chroma
from .utils import embeddings
import shutil
import os

DATA_PATH = "../../uploads"
CHROMA_PATH = '../chroma'

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

def load_documents():
    document_loader = PyPDFDirectoryLoader(DATA_PATH)
    docs = document_loader.load()
    return docs

def split_documents(documents: list[Document]):
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=800,
        chunk_overlap=80,
        length_function=len,
        is_separator_regex=False
    )

    return text_splitter.split_documents(documents)


def calculate_chunk_ids(chunks):
    last_page_id = None
    current_chunk_index = 0

    for chunk in chunks:
        source = chunk.metadata.get("source")
        page = chunk.metadata.get("page")
        current_page_id = f"{source}:{page}"

        if current_page_id == last_page_id:
            current_chunk_index += 1
        else:
            current_chunk_index = 0

        chunk_id = f"{current_page_id}:{current_chunk_index}"
        last_page_id = current_page_id

        chunk.metadata["id"] = chunk_id

    return chunks

def save_to_chroma(chunks: list[Document]):
    db = Chroma.from_documents(
        chunks, embedding=embeddings, persist_directory=CHROMA_PATH
    )

    chunks_with_ids = calculate_chunk_ids(chunks)
    existing_items = db.get(include=[])
    existing_ids = set(existing_items['ids'])
    print(f'Number of existing documents in DB: {len(existing_items)}')

    new_chunks = []
    for chunk in chunks_with_ids:
        if chunk.metadata['id'] not in existing_ids:
            new_chunks.append(chunk)

    if len(new_chunks):
        print(f"👉 Adding new documents: {len(new_chunks)}")
        new_chunk_ids = [chunk.metadata["id"] for chunk in new_chunks]
        db.add_documents(new_chunks, ids=new_chunk_ids)
        db.persist()
    else:
        print("✅ No new documents to add")

    db.persist()
    print(f"Saved {len(chunks)} chunks to {CHROMA_PATH}")

def clear_database():
    if os.path.exists(CHROMA_PATH):
        shutil.rmtree(CHROMA_PATH)

def generate_data_store():
    documents = load_documents()
    chunks = split_documents(documents)
    save_to_chroma(chunks)

def main():
    documents = load_documents()
    for doc in documents:
        doc.metadata["source"] = os.path.basename(doc.metadata["source"])
    chunks = split_documents(documents)
    save_to_chroma(chunks=chunks)


print("Adding data to Chroma DB")
# clear_database()
main()
print('success')