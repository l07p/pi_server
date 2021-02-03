from read_csv import Read_csv
from product import Product
import access_database

# This is class of account
class Account:
    def __init__(self, _filepath, _account):
        self.names =  access_database.get_column_in_table('name', 'accounts')
        self.name = _account
        self.id = access_database.get_id_where_column('accounts', 'name', _account)
        self.csv = Read_csv(_filepath)
        pass

    def find_product_with_filter_df(self):
        my_product = Product()
        product_name_list = []
        vars = access_database.get_column_in_table('name', 'products')
        for var in vars:
            product_name_list.append(var[0])
        pass



def main(_filepath, _account):
    o1 = Account(_filepath, _account)
    print(o1.id)
    # o1.csv.read_giro(_account)
    # print(o1.csv._df)
    # o1.find_product_with_filter_df()
    pass


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: filepath of input file, account name in list')
    
    parser.add_argument('--filepath',
                        help='input file and its folder together',
                        # default=r"C:\Users\saver\Downloads\Depotübersicht_788267505 (4).csv")
                        # default=r"C:\Users\saver\Downloads\depotuebersicht_9787270226_20201217-1731.csv")
                        default=r"C:\Users\saver\Downloads\1057325985 (1).csv")
                        # default=r"/media/lnmycloud/archives/banks/consors/Depotübersicht_788267505 (5).csv")
                        #default=r"/media/lnmycloud/archives/banks/dkb/502081722 (10).csv")

    parser.add_argument('--account',
                        help='input account name',
                        default=r"DKB_giro")
                        # default=r"comdirect_depot")

    args = parser.parse_args()

    main(_filepath=args.filepath, _account=args.account)
