#!/usr/bin/python3.8
# This class treats with product and its table in database 'investment'

import sys
sys.path.append(".")

from product import Product

class report_products:
    def __init__(self):
        pass

def main():
    p1 = Product()
    p1.list_all_products_orders()



if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='report all product according to given period')
    
    parser.add_argument('--from_date',
                        help='input from date for duration',
                        default='2020-01-01')
    
    
    args = parser.parse_args()

    main()
