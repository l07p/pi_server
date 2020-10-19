import datetime

class order:
    
    def __init__(self, year, month, day, stueck, kurs):
        self.date = datetime.datetime(year,month,day)
        self.stueck = stueck
        self.kurs = kurs

    def build_order(self):
        return '{} {} {}'.format(self.date, self.stueck, self.kurs)


o1=order(2020,10,1,4.007, 122.83)
print(o1.build_order())