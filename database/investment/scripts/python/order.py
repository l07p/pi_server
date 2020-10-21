import datetime

class order:
    
    def __init__(self):
        pass

    def set_order(self, year, month, day, stueck, kurs):
        self.date = datetime.datetime(year,month,day)
        self.stueck = stueck
        self.kurs = kurs

    def build_order(self):
        return '{} {} {}'.format(self.date, self.stueck, self.kurs)

    def set_order_date(self):
        year = input('yyyy year of the order date\n')
        month = input('mm,  month of the order date\n')
        day = input('dd, day of the order date\n')
        self.date = datetime.datetime(int(year),int(month),int(day))

    def set_order_stueck(self):
        self.stueck = float(input('input order stueck\n'))

    def set_order_kurs(self):
        self.kurs = float(input('input order kurs\n'))




# o1=order(2020,10,1,4.007, 122.83)


if __name__ == '__main__':
    o1 = order()
    o1.set_order_date()
    o1.set_order_stueck()
    o1.set_order_kurs()

    print(o1.build_order())
    
