# This class reads pdf and extract text into values
from PyPDF2 import PdfFileReader


pdf_path = 'verkauf.pdf'
pdf = PdfFileReader(str(pdf_path), 'rb')

print(pdf)

pass