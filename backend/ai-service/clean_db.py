import os, shutil

CHROMA_PATH = "chroma"

if not os.path.exists(CHROMA_PATH):
    print("No chroma DB detected")
    exit()

print("Removing chroma DB !!!")


shutil.rmtree(CHROMA_PATH)

print("Successfully clearing current Chroma DB !!!")