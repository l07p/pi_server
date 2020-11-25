# This class handles text in different formats

from order import Order

class Read_text:
    def __init__(self):
        read_order = Order()
        self.text = ''
        self.account_name = ''
        
    def text_from_account(self, _text, _account_name):
        self.text = _text
        self.account_name = _account_name
    
    def extract_text_to_order(self):
        if self.text != '':
            print(self.read_order.order_features)
        else:
            pass
        pass
        


def main(_text, _account_name):   
    print('+++++++++++++++++++++++++\n')
    r1 = Read_text()
    r1.text_from_account(_text, _account_name)
    r1.extract_text_to_order()
    print('{} \n{}'.format(r1.account_name, r1.text))

    
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

    parser.add_argument('--account_name',
                        help = 'text from mail or pdf depending on depot. e. g. consors_depot',
                        default = 'Consors_depot')

    args = parser.parse_args()    
    main(_text=args.input_text, _account_name = args.account_name)