import psycopg2
from psycopg2 import sql
import psycopg2.extras
import pandas as pd
import sys
import numpy as np

def get_column_in_table(_column, _table):
    ret = None
    conn = None

    #############################################
    # query = sql.SQL("select {field} from {table} where {pkey} = %s").format(
    # field=sql.Identifier('my_name'),
    # table=sql.Identifier('some_table'),
    # pkey=sql.Identifier('id'))
    #############################################
    queries = sql.SQL("select {field} from {table}").format( field=sql.Identifier(_column),   table=sql.Identifier(_table)) 
    try:
        # connect to the Postgrequeries database
        conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
        cur = conn.cursor()
        cur.execute(queries)

        # get the generated id back
        ret = cur.fetchall()
        # close communication with the database
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
        return ret # type is tuple, maybe need to convert to list

def get_id_from(_func, _param): # """SELECT id public.get_product_id_with_isin('DE000A0H08M3');""" or """SELECT public.get_product_id_with_wkn('{}');""", 'A0H08M'
    queries = _func.format(_param)
    ret = 0
    conn = None
    try:
        # connect to the Postgrequeries database
        conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
        cur = conn.cursor()
        cur.execute(queries)

        # get the generated id back
        ret = cur.fetchone()[0]
        # close communication with the database
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
        return ret

def insert_product_value(_date, _stueck, _einstandskurs, _kurs, _account_id, _product_id): # """SELECT public.get_product_id_with_isin('DE000A0H08M3');""" or """SELECT public.get_product_id_with_wkn('{}');""", 'A0H08M'
    function_name = """public.update_product_value""" #.format(_date,  _stueck, _einstandskurs, _kurs, _account_id, _product_id )
    ret = 0
    conn = None
    try:
        # connect to the Postgrequeries database
        conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
        cur = conn.cursor()
        ret = cur.callproc(function_name,[0, _date,  _stueck, _einstandskurs, _kurs, _account_id, _product_id, ])
        
        # close communication with the database
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.commit()
            # conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
            conn.close()
        return ret


class Access_database:
    def __init__(self):
        self.id = 0
        self.date = None
        self.value = 0.0
        self.df = None
        self.table = None


def main():
    #insert_product_value('2020-02-06', 21.5, 600.63, 23.43, 1, 5)
    ret = np.asarray(get_column_in_table('name', 'products'))
    for i in ret:
        print(i[0])
        
    pass

if __name__ == "__main__":

    main()
