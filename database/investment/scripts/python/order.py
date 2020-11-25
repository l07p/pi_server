import sys
import datetime
import psycopg2
import psycopg2.extras

class Order:
    
    def __init__(self):
        self.order_features = ["Orderart", "WKN", "wkn", "Stück", "Ausführungskurs", "Kurs", "kurs"]
        self.stueck = 0.0
        pass

    """     
    calculate einstand-kurs !!!!!!!!!
 SELECT SUM(kurs * stueck + provision)/SUM(stueck)
    FROM public.orders
	WHERE product_id = 4;
 
    """

    def set_order_day(self, _date):
        self.date = _date

    def set_order_stueck(self, _stueck):
        self.stueck = float(_stueck)

    def set_order_kurs(self, _kurs):
        self.kurs = float(_kurs)
        
    def set_order_provision(self, _provision):
        self.provision = float(_provision)

    def set_order_type_id(self, _type_id):
        self.provision = int(_type_id)

    def set_order_product_id(self, _product_id):
        self.provision = int(_product_id)

    def set_order_account_id(self, _account_id):
        self.provision = int(_account_id)

    def insert_order(self):
        '''
        The stuff in side the function insert dataset to table orders
        '''
        conn = None
        order_id = None
        
        try:
            conn = psycopg2.connect("dbname='investment' user='pi' host='192.168.178.54' password='ueber500mal'")
            print('connected to database')

            cur = conn.cursor()
            
            cur.callproc('function_get_order',[self.kurs,])

            print("get order id from function_get_order")
            order_id = cur.fetchall()[0][0]


        except psycopg2.DatabaseError as e:
            print (f'Error {e}')
            sys.exit(1)

        finally:
            if conn:
                conn.close()   
            return order_id

def main(_orderday, _stueck, _kurs, _provision):
    o1 = Order()
    print(o1.order_features)
    
    #o1.orderday(_orderday)
    # o1.set_order_day(_orderday)
    # o1.set_order_stueck(_stueck)
    # o1.set_order_kurs(_kurs)
    # o1.set_order_provision(_provision)
    # print(o1.insert_order())
    
if __name__ == '__main__':
    import argparse
    
    parser = argparse.ArgumentParser()
    
    parser.add_argument('--orderday',
                        help='input date of the order',
                        default='2020-10-20')
    
    parser.add_argument('--stueck',
                        help='input stueck of the order',
                        default=90.2527)
    
    parser.add_argument('--kurs',
                        help='input kurs of the order',
                        default=5.54)

    parser.add_argument('--provision',
                        help='input provision of the order',
                        default=1.5)
    
    args = parser.parse_args()

    main(_orderday=args.orderday, _stueck=args.stueck, _kurs=args.kurs, _provision=args.provision)  