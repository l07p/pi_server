# This is class balance of account
####################################################################
## read csv, text or pdf as html files update table_account_balances
####################################################################
class balance:
    def __init__(self, value):
        self.value = value

b1 = balance(10.0)
print(b1.value)