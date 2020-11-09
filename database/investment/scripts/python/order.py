import datetime

class order:
    
    def __init__(self):
        pass

    def set_order(self, year, month, day, stueck, kurs):
        self.date = datetime.datetime(year,month,day)
        self.stueck = stueck
        self.kurs = kurs
        return 
    
    def orderday(self, day_str):
        try:
            self.date = datetime.datetime.strptime(day_str, "%Y-%m-%d")
        except ValueError:
            msg = "Given Date ({0}) not valid! Expected format, YYYY-MM-DD!".format(arg_date_str)
            raise argparse.ArgumentTypeError(msg)   

    def build_order(self):
        return '{} {} {}'.format(self.date, self.stueck, self.kurs)

    def set_order_stueck(self, _stueck):
        self.stueck = float(_stueck)

    def set_order_kurs(self, _kurs):
        self.kurs = float(_kurs)

def main(_orderday, _stueck, _kurs, _order_product):
    o1 = order()
    
    if _order_product:
        print('function order ref product')
    
    else:
        o1.orderday(_orderday)
        o1.set_order_stueck(_stueck)
        o1.set_order_kurs(_kurs)
        print(o1.build_order())
    
if __name__ == '__main__':
    import argparse
    
    parser = argparse.ArgumentParser(description='give text')
    
    parser.add_argument('--order_product', default=False, action='store_true')
    
    parser.add_argument('--orderday',
                        help='input date of the order',
                        default='2020-10-3')
    
    parser.add_argument('--stueck',
                        help='input stueck of the order',
                        default=4.001)
    
    parser.add_argument('--kurs',
                        help='input kurs of the order',
                        default=122.3)
    
    args = parser.parse_args()

    main(_orderday=args.orderday, _stueck=args.stueck, _kurs=args.kurs, _order_product=args.order_product)  