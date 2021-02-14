from read_csv import Read_csv
from product import Product
from access_database import *

import re
import datetime

class Product_values:
    def __init__(self, _filepath):
        self.data_str = None
        self.account_id = None
        self.csv = Read_csv(_filepath)
        self.product = Product()
        pass
      

    def from_account(self, _account):
        self.csv.read_depot(_account)
        self.data_str = self.csv.date_str
        self.account_id = 1


    # this method 
    # reads ids of products with wkn/isin, set product_values with date, value, account_id
    def update_product_values(self):
        insert_product_value(self.data_str, 21.5, 518.63, 23.43, self.account_id, self.product.id)
        pass


def main(_filepath, _account):
    o1 = Product_values(_filepath)
    o1.from_account(_account)
    o1.product.get_id_from("""SELECT public.get_product_id_with_isin('{}');""", 'DE000A0H08M3')
    print(o1.product.id)
    # o1.update_product_values()

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
                        # default=r"C:\Users\saver\Downloads\depotuebersicht_9787270226_20201217-1731.csv")
                        default=r"C:\Users\saver\Downloads\502081722 (9).csv")
                        # default=r"/media/lnmycloud/archives/banks/consors/Depotübersicht_788267505 (5).csv")
                        #default=r"/media/lnmycloud/archives/banks/dkb/502081722 (10).csv")

    parser.add_argument('--account',
                        help='input account name',
                        default=r"DKB_depot")
                        # default=r"comdirect_depot")

    args = parser.parse_args()

    main(_filepath=args.filepath, _account=args.account)
