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
    p1.called()
    print('report products')



if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='insert, update or list only the product datasets')
    
    parser.add_argument('--wkn',
                        help='input wkn of the product',
                        default='A0Q4R2')
    
    parser.add_argument('--isin',
                        help='input isin of the product',
                        default='DE000A0Q4R28')
    
    parser.add_argument('--name',
                        help='input name of the product',
                        default='iShares STOXX Europe 600 Automobiles & Parts UCITS ETF (DE)')
        
    parser.add_argument('--google_symbol',
                        help='input google_symbol of the product',
                        default='EXV5')
    
    args = parser.parse_args()

    main()
