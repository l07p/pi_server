#!/usr/bin/python3.8
# This class treats with product and its table in database 'investment'

import psycopg2
import psycopg2.extras
import sys

class Product:
    def __init__(self):
        pass
    
    def list_products(self):
        try:
            conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
            print('connected to database')

            cur = conn.cursor()
            cur.execute("SELECT * FROM products ORDER BY id")
            
            rows = cur.fetchall()
            col_names = [desc[0] for desc in cur.description]

            for row in rows:
                self.wkn = row[1]
                self.name = row[4]
                print(f'{self.wkn} {self.name}')

        except psycopg2.DatabaseError as e:
            print (f'Error {e}')
            sys.exit(1)

        finally:
            if conn:
                conn.close()        

    def insert_product(self, _wkn, _isin, _name, _google_symbol):
        """ insert a new into the products table """
        sql = """INSERT INTO products(wkn, isin, google_symbol, name)
                VALUES(%s, %s, %s, %s) RETURNING id;"""
        conn = None
        product_id = None
        try:
            # connect to the PostgreSQL database
            conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
            # create a new cursor
            cur = conn.cursor()
            # execute the INSERT statement
            cur.execute(sql, (_wkn, _isin, _name, _google_symbol))
            # get the generated id back
            product_id = cur.fetchone()[0]
            # commit the changes to the database
            conn.commit()
            # close communication with the database
            cur.close()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
        finally:
            if conn is not None:
                conn.close()

        return product_id

def main(_readonly, _wkn, _isin, _name, _google_symbol):

    p = Product()
    if _readonly:
        p.list_products()
    else:
        print(p.insert_product(_wkn, _isin, _name, _google_symbol))



if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='insert, update or list only the product datasets')
    
    parser.add_argument('--readonly', default=False, action='store_true')
    
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

    main(_readonly=args.readonly, _wkn=args.wkn, _isin=args.isin, _name=args.name, _google_symbol=args.google_symbol)
