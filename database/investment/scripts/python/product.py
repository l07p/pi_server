#!/usr/bin/python3.8
# This class treats with product and its table in database 'investment'

import psycopg2
import psycopg2.extras
import sys

class Product:
    def __init__(self):
        pass

def main():
    p = Product()
    try:
        conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
        print('connected to database')

        cur = conn.cursor()
        cur.execute("SELECT * FROM products ORDER BY id")
        
        rows = cur.fetchall()
        col_names = [desc[0] for desc in cur.description]

        for row in rows:
            p.wkn = row[1]
            p.name = row[4]
            print(f'{p.wkn} {p.name}')

    except psycopg2.DatabaseError as e:
        print (f'Error {e}')
        sys.exit(1)

    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    main()