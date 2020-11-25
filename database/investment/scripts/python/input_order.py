from order import *


class Input_order(Order):
    def __init__(self):
        pass

    def set_product(self, p_product_id):
        self.product = p_product_id
        
    def built(self):
        return '{} {} {} {}'.format(self.date, self.stueck, self.kurs, self.product)

def main(_orderday, _stueck, _kurs, _order_product):
    o1 = Input_order()
    o1.set_product(_order_product)
    
    print('product ID: {}'.format(o1.product))
    
    o1.orderday(_orderday)
    o1.set_order_stueck(_stueck)
    o1.set_order_kurs(_kurs)
    print(o1.build_order())
    #o1.insert_order()
    
if __name__ == '__main__':
    import argparse
    
    parser = argparse.ArgumentParser(description='give text')
    
    parser.add_argument('--order_product', 
                        help='input product ID',
                        default=9999)
    
    parser.add_argument('--orderday',
                        help='input date of the order',
                        default='2020-11-05')
    
    parser.add_argument('--stueck',
                        help='input stueck of the order',
                        default=0.8657)
    
    parser.add_argument('--kurs',
                        help='input kurs of the order',
                        default=577.6)
    
    args = parser.parse_args()

    main(_orderday=args.orderday, _stueck=args.stueck, _kurs=args.kurs, _order_product=args.order_product)  