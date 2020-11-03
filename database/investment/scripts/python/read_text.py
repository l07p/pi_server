# This class handles text in different formats


class read_text:
    def __init__(self):
        pass
        
    def text2order(self, _text):
        return _text


 
def main(_text):   
    r1 = read_text()
    print(r1.text2order(_text))

    
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser('give text')
    parser.add_argument('--input_text', 
                        help='input text to be worked out', 
                        default='you forgot inputting') 
    
    args = parser.parse_args()    
    main(_text=args.input_text)