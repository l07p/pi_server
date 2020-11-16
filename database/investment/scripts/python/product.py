#!/usr/bin/python3.8
# This class treats with product and its table in database 'investment'

import psycopg2
import psycopg2.extras
import pandas as pd
import sys

class Product:
    def __init__(self):
        self.id = 0
        pass

    def insert_product(self, _wkn, _isin, _name, _google_symbol):
        """ insert a new into the products table """
        sql = """INSERT INTO products(wkn, isin, name, google_symbol)
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
    
    def list_orders(self, _product_name):

        conn = None
        product_id = None
        s_var = None
        try:
            # connect to the PostgreSQL database
            conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
            # create a new cursor
            cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
            
            # execute the set product 
            sql = """SELECT * FROM products WHERE name LIKE %s;"""
            s_var = ''.join(('%', _product_name, '%'))
            cur.execute(sql, (s_var,))
           
            row = cur.fetchone()
            self.id = row['id']
            self.name = row['name']
            self.wkn = row['wkn']
            self.isin = row['isin']
            self.google_symbol = row['google_symbol']
            self.category_id = row['category_id']
            
            product_id = self.id
            
            # list orders
            sql = """SELECT date, kurs, stueck, provision, product_id FROM orders WHERE product_id = %s
                    ORDER BY date;"""
            cur.execute(sql, (product_id,))
            rows = cur.fetchall()
            column_names = ["date", "kurs", "stueck","provision", "product_id"]
            df = pd.DataFrame(rows, columns=column_names)
            print(df)
            
            # close communication with the database
            cur.close()
            
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
        finally:
            if conn is not None:
                conn.close()

        return product_id

def main(_wkn, _isin, _name, _google_symbol):

    p = Product()
    print(p.list_orders(_name))



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

    main(_wkn=args.wkn, _isin=args.isin, _name=args.name, _google_symbol=args.google_symbol)
