import argparse
import re
import sys

import os
from tabula import Wrapper

# from pdfminer.high_level import extract_text
# from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
# from pdfminer.converter import TextConverter, XMLConverter, HTMLConverter
# from pdfminer.layout import LAParams
# from pdfminer.pdfpage import PDFPage
# from io import BytesIO

# def convert_pdf(path, format='text', codec='utf-8', password=''):
#     rsrcmgr = PDFResourceManager()
#     retstr = BytesIO()
#     laparams = LAParams()
#     if format == 'text':
#         device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
#     elif format == 'html':
#         device = HTMLConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
#     elif format == 'xml':
#         device = XMLConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
#     else:
#         raise ValueError('provide format, either text, html or xml!')
#     fp = open(path, 'rb')
#     interpreter = PDFPageInterpreter(rsrcmgr, device)
#     maxpages = 0
#     caching = True
#     pagenos=set()
#     for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
#         interpreter.process_page(page)

#     text = retstr.getvalue().decode()
#     fp.close()
#     device.close()
#     retstr.close()
#     return text

def main(infile):
    print('============= no idea =================')
    tables = Wrapper.read_pdf(infile,multiple_tables=True,pages='all')

    for table in tables:
        print('any')

    pass

if __name__ == "__main__": 
    parser = argparse.ArgumentParser(
        prog='Read_pdf', 
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description='''   ++This function  read pdf file and extract text.''')
    parser.print_help()

    # parser.add_argument('--infile', nargs='?', type=argparse.FileType('r'),
     #                   default="test_dkb.pdf",
      #                  help='input')

    parser.add_argument('--infile', 
                        # default=r"/home/project/Projects/pi_server/database/investment/scripts/test_dkb.pdf",
                        default=r"I:\going_on\finance\DKB\DKB -20210114tecdax_verkauf.pdf",
                        help='input')

    args = parser.parse_args()
    main(args.infile)

##########################################################
# This class reads pdf and extract text into values
# or https://www.blog.pythonlibrary.org/2018/05/03/exporting-data-from-pdfs-with-python/

#from io import StringIO
#import json

#a = open('I:\\tmp\\temporary.txt','r').read()
#if re.findall('second line\nThis third line', a, re.MULTILINE):
#    print('found!')

#with open('I:\\tmp\\temporary.txt') as f:
#    count = 0
#    line1 = 'second line\nThis third line'
#    line1 = line1.split('\n')
#    found = 0
#    not_found = 0
#    for line_no, line in enumerate(f):
#        if line1[count] in line :
#            count += 1
#            if count == 1 :
#                found = line_no
#            if count == len(line1):
#                not_found = 1
#                print ('String found on line: ' + str(found))
#        elif count > 0 :
#            count = 0
#            if line1[count] in line :
#                count += 1
#                if count == 1 :
#                    found = line_no
#                if count == len(line1):
#                    not_found = 1
#                    print ('String found on line: ' + str(found))
#    if not_found == 0 : # for loop ended => line not found
#        line_no = -1
#        print ('\nString Not found')

#from pdfminer.converter import TextConverter
#from pdfminer.layout import LAParams
#from pdfminer.pdfdocument import PDFDocument
#from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
#from pdfminer.pdfpage import PDFPage
#from pdfminer.pdfparser import PDFParser


#output_string = StringIO()
#with open("I:\\tmp\\Kauf_-_WKN_593397.pdf", 'rb') as in_file:
#    parser = PDFParser(in_file)
#    doc = PDFDocument(parser)
#    rsrcmgr = PDFResourceManager()
#    device = TextConverter(rsrcmgr, output_string, laparams=LAParams())
#    interpreter = PDFPageInterpreter(rsrcmgr, device)
#    for page in PDFPage.create_pages(doc):
#        interpreter.process_page(page)

#print(output_string.getvalue())

#from pdfminer.high_level import extract_text
#text = extract_text("I:\\tmp\\Kauf_-_WKN_593397.pdf")
##print(repr(text))
##print(text)

##file1 = open("I:\\tmp\\temporary.txt", "w")
###file1.readlinke()
##file1.write(text)
##file1.close()

#lines = text.split('\n')
#print(text.find('Stück'))

#filter_object = filter(lambda a: 'Stück' in a, lines )
#stueck = list(filter_object)
#print(stueck)
#print(stueck[0])
