# This class handles text in different formats
import order

class Read_text:
    def __init__(self):
        _rd_order = order.Order()
        pass
        
    def read_consors(self, _text):
        self.text = _text

    def extract_consors_text(self):
        pass


def main(_text):   
    r1 = Read_text()
    r1.read_consors(_text)
    print(r1.text)

    
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser('give text')
    parser.add_argument('--input_text', 
                        help='input text to be worked out', 
                        default='''Ihre Order mit der Ordernummer 177079739 wurde ausgeführt:
                        Ihr Depot: ******505
                        Orderart: Kauf
                        Name: XTR.EURO STOXX 50 1D
                        WKN: DBX1EU
                        Handelsplatz: Sparplan
                        Stück: 14,7776
                        Orderzusatz: Market Order
                        Ausführungskurs: 33,835 EUR
                        Wir wünschen Ihnen weiterhin viel Erfolg bei Ihren Finanzgeschäften!'''
                        ) 
    
    args = parser.parse_args()    
    main(_text=args.input_text)