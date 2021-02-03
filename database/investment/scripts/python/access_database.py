import psycopg2
from psycopg2 import sql, OperationalError, errorcodes,errors
import psycopg2.extras as extras
import pandas as pd
import sys
import numpy as np

conn_params_dic = {
    "host"  : "192.168.178.54",
    "database" : "investment",
    "user" : "pi",
    "password" : "ueber500mal"
}

# Define a function that handles and parses psycopg2 exceptions
def show_psycopg2_exception(err):
    # get details about the exception
    err_type, err_obj, traceback = sys.exc_info()    
    # get the line number when exception occured
    line_n = traceback.tb_lineno    
    # print the connect() error
    print ("\npsycopg2 ERROR:", err, "on line number:", line_n)
    print ("psycopg2 traceback:", traceback, "-- type:", err_type) 
    # psycopg2 extensions.Diagnostics object attribute
    print ("\nextensions.Diagnostics:", err.diag)    
    # print the pgcode and pgerror exceptions
    print ("pgerror:", err.pgerror)
    print ("pgcode:", err.pgcode, "\n")

# Define a connect function for PostgreSQL database server
def connect(conn_params_dic):
    conn = None
    try:
        print('Connecting to the PostgreSQL...........')
        conn = psycopg2.connect(**conn_params_dic)
        print("Connection successfully..................")
        
    except OperationalError as err:
        # passing exception to function
        show_psycopg2_exception(err)        
        # set the connection to 'None' in case of error
        conn = None
    return conn

# Define function using copy_from_dataFile to insert the dataframe.
# def copy_from_dataFile(conn, df, table):

def get_a_table(_columns, _table): #as pandas dataframe
    ret = None
    conn = connect(conn_params_dic)
    # conn.autocommit = True
    queries = sql.SQL("select * from {table} ").format(table=sql.Identifier(_table))

    try:
        # connect to the Postgrequeries database
        cur = conn.cursor()
        cur.execute(queries)
        rows = cur.fetchall()

        # # get the generated id back
        # column_names = ["id", "name"]
        ret = pd.DataFrame(rows, columns=_columns)

        # close communication with the database
        cur.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
        return ret # type is tuple, maybe need to convert to list

def _connection():
    return psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")

def get_id_where_column(_table, _column, _where_is): # select id from table where column = where is (value)
    ret = None
    conn = None

    queries = sql.SQL("select {pkey} from {table} where {field}=%s").format(pkey=sql.Identifier('id'), field=sql.Identifier(_column), table=sql.Identifier(_table)) 
    try:
        # connect to the Postgrequeries database
        conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
        cur = conn.cursor()
        cur.execute(queries, (_where_is,))

        # get the generated id back
        ret = cur.fetchone()[0]
        # close communication with the database
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
        return ret # type is tuple, maybe need to convert to list

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
        conn =  _connection()
        cur = conn.cursor()
        cur.execute(queries)

        # get the generated id back
        df = pd.DataFrame(cur.fetchall())
        dd = df.to_dict()[0]
        ret = dd.values()
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
