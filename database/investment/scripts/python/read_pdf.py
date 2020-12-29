import argparse
import re
import sys

from pdfminer.high_level import extract_text

def main(infile):
    #print(infile.read())
    #infile.close()
    text = extract_text(r"/home/project/Projects/pi_server/database/investment/scripts/test_dkb.pdf")
    print(text)

if __name__ == "__main__": 
    parser = argparse.ArgumentParser(
        prog='Read_pdf', 
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description='''\
        ++This function 
            read pdf file and extract text.''')
    parser.print_help()

    # parser.add_argument('--infile', nargs='?', type=argparse.FileType('r'),
     #                   default="test_dkb.pdf",
      #                  help='input')

    parser.add_argument('--infile', 
                        default="test_dkb.pdf",
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
