# This class handles text in different formats
import re
from order import Order
from product import Product
import mailparser
import pandas as pd

class Read_text:
    def __init__(self):
        self.read_order = Order()
        self.read_product = Product()
        self.text = ''
        self.account_name = ''
        self.mail = None
        self.df = None

    def text_from_consors_email(self, _filepath):
        try:
            self.mail = mailparser.parse_from_file(_filepath)
            self.text = self.mail.body
        except:
            return None
        
    def dictionary_from_consors_email_text(self):
        if self.text != '':
            lines = self.text.splitlines()
            d = {'key':'value'}
            for i in lines:
                x = i.split(":")
                if len(x) == 2:
                    d[x[0]] = x[1]
            return d
        else:
            return None
    def convert_dict_to_dataframe(self, _dict):
        _df = pd.DataFrame.from_dict([_dict])
        _df = _df.drop(columns=['Gnral (Generaldirektor)', "Prsident du Conseil d'Administration (Prsident des Verwaltungsrates)", 'Standort Nrnberg', "Ihre Order mit der Ordernummer 183977051 wurde ausgefhrt"])
        float_data = ['Stck', 'Ausfhrungskurs']
        for i in float_data:
            _df[i] = _df[i].str.replace('EUR', '')
            _df[i] = _df[i].str.replace('.', '')
            _df[i] = _df[i].str.replace(',', '.').astype(float)
        self.df = _df

    def order_read_from_consors_email(self, _dict):
            _wkn = _dict['WKN']
            # convert_comma_decimal = lambda x : (
            #     x = x.str.replace('.', '')
            #     x = x.str.replace(',', '.').astype(float)
            # )



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


def main(_filepath):   
    print('+++++++++++++++++++++++++\n')
    r1 = Read_text()
    r1.text_from_consors_email(_filepath)
    dd = r1.dictionary_from_consors_email_text() 
    r1.convert_dict_to_dataframe(dd)      

    print(r1.df)
    # r1.text_from_account(_text,_account_name)
    # r1.extract_text_to_order()
    # #ret = r1.read_product.get_product_id_with_wkn('DBX1SM')
    # # r1.text_from_account(_text, _account_name)
    # # print(r1.extract_depot_from_text())
    # # r1.extract_text_to_order()
    # # print('{} \n{}'.format(r1.account_name, r1.text))
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

    parser.add_argument('--filepath',
                        help = 'mail in text file saved from outlook',
                        default = r"I:\going_on\finance\consors\Consorsbank.txt")

    args = parser.parse_args()    
    main(_filepath = args.filepath)