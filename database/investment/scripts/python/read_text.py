# This class handles text in different formats
import re
from order import Order
from product import Product

class Read_text:
    def __init__(self):
        self.read_order = Order()
        self.read_product = Product()
        self.text = ''
        self.account_name = ''
        
    def text_from_account(self, _text, _account_name):
        self.text = _text
        self.account_name = _account_name
    
    def extract_depot_from_text(self):
        ret = ''
        for dp in self.text.splitlines():
            match = re.search(r'Ihr Depot:', dp)
            if match:
                ret = dp.split(':')[1]
                break
        return ret
        
    def extract_stueck_from_text(self):
        ret = 0.0
        s = ''
        for dp in self.text.splitlines():
            match = re.search(r'Stück:', dp)
            if match:
                s = dp.split(':')[1]
                s = s.replace('.', '').replace(',','.')
                ret = float(s)
                break
        return ret

    def extract_text_to_order(self):
        if self.text != '':
            self.read_order.set_order_stueck(self.extract_stueck_from_text())
        else:
            pass        


def main(_text, _account_name):   
    print('+++++++++++++++++++++++++\n')
    r1 = Read_text()
    r1.text_from_account(_text,_account_name)
    r1.extract_text_to_order()
    #ret = r1.read_product.get_product_id_with_wkn('DBX1SM')
    # r1.text_from_account(_text, _account_name)
    # print(r1.extract_depot_from_text())
    # r1.extract_text_to_order()
    # print('{} \n{}'.format(r1.account_name, r1.text))
    pass

    
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