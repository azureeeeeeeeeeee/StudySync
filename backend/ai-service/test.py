from services import query_cpp

question = "what is biodiversity"
source = "1758094144123_1741-7007-8-145.pdf"

print(query_cpp.query(question, source, score=0))