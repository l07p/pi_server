from read_csv import Read_csv
from product import Product
import re
import datetime

class Product_values:
    def __init__(self, _filepath):
        self.date_str = '1970-07-01'
        self.csv = Read_csv(_filepath)
        pass

    # method reads date as string from csv file of account balance. This method must be called after
    def read_date_str(self, _account):
        ret = None

        # Account DKB_depot
        if _account == 'DKB_depot':
            pattern = re.compile(r'Bestand per:...([0-9][0-9].[0-9][0-9].[0-9][0-9][0-9][0-9])(.....*)')
            with open(self.csv.filepath, 'r', encoding='ISO-8859-1', errors='strict') as f:
                contents = f.read()
                vars = re.finditer(pattern, contents)
        else:
            return None

        for var in vars:
            ret = var.group(1)
        
        self.date_str = datetime.datetime.strptime(ret, '%d.%m.%Y').strftime('%Y-%m-%d')
        

    def from_csv(self, _account, _filepath):
        self.read_date_str(_fliepath)
        self.csv = Read_csv(_filepath)
        self.csv.read_account(_account)


def main(_filepath, _account):
    # o1 = Product_values(_filepath)
    # o1.read_date_str(_account)
    # o1.csv.read_account(_account)
    # print(o1.date_str)
    # print(o1.csv._df)
    # print(Product().get_product_id_with_isin('DE000628930'))
 
    
    # o1.from_csv(_account, _filepath)
    # print(o1.csv._df)
    pass


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: filepath of input file, account name in list')
    
    parser.add_argument('--filepath',
                        help='input file and its folder together',
                        # default=r"C:\Users\saver\Downloads\Depotübersicht_788267505 (4).csv")
                        #default=r"C:\Users\saver\Downloads\depotuebersicht_9787270226_20201217-1731.csv")
                        default=r"C:\Users\saver\Downloads\502081722 (9).csv")
                        # default=r"/media/lnmycloud/archives/banks/consors/Depotübersicht_788267505 (5).csv")
                        #default=r"/media/lnmycloud/archives/banks/dkb/502081722 (10).csv")

    parser.add_argument('--account',
                        help='input account name',
                        default=r"DKB_depot")
                        # default=r"comdirect_depot")

    args = parser.parse_args()

    main(_filepath=args.filepath, _account=args.account)
