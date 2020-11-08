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
        print(day_str)
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


def main(_text, _orderday, _stueck, _kurs):
    print(_text)
    o1 = order()
    o1.orderday(_orderday)
    o1.set_order_stueck(_stueck)
    o1.set_order_kurs(_kurs)
    print(o1.build_order())

        
def valid_datetime_type(arg_datetime_str):
    """custom argparse type for user datetime values given from the command line"""
    try:
        return datetime.datetime.strptime(arg_datetime_str, "%Y-%m-%d %H:%M")
    except ValueError:
        msg = "Given Datetime ({0}) not valid! Expected format, 'YYYY-MM-DD HH:mm'!".format(arg_datetime_str)
        raise argparse.ArgumentTypeError(msg)  

if __name__ == '__main__':
    import argparse
    
    parser = argparse.ArgumentParser(description='give text')
    
    parser.add_argument('-si', '--string_input' ,
                        dest='input_text',
                        help='input text to be worked out', 
                        default='you forgot inputting') 
    
    parser.add_argument('--orderday',
                        help='input date of the order',
                        default='2020-10-3')
    
    parser.add_argument('--stueck',
                        help='input date of the order',
                        default=4.001)
    
    parser.add_argument('--kurs',
                        help='input date of the order',
                        default=122.3)
    
    args = parser.parse_args()

    main(_text=args.input_text, _orderday=args.orderday, _stueck=args.stueck, _kurs=args.kurs)  