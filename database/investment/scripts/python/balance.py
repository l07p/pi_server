# This is class balance of account
####################################################################
## read csv, text or pdf as html files update table_account_balances
####################################################################
import datetime

class balance:
    def __init__(self, value):
        self.date = datetime.date(2020,1,1)
        self.value = value
        self.id = 1 # first dataset could be overwitten that must set with oldest date

b1 = balance(10.0)
print(b1.value)