# This is class balance of account
####################################################################
## read csv, text or pdf as html files update table_account_balances
####################################################################

class Balance:
    def __init__(self, _id, _date, _value, _account_id):
        self.date = _date # date is formated in string, string can transfered to plpgsql function directly
        self.value = _value # fload
        self.id = _id #integer, first dataset could be overwitten that must set with oldest date
        self.account_id = _account_id # integer

def main(_id, _date, _value, _account_id):
    o1 = Balance(_id, _date, _value, _account_id)
    pass


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: _id, _date, _value, _account_id')
    
    parser.add_argument('--balance_id',
                        help='balance id deals with existing datasets of balances, data type is integer',
                        default=1)

    parser.add_argument('--balance_date',
                        help='data type is string, in format yyyy-MM-dd',
                        default=r"1997-07-02")

    parser.add_argument('--balance_value',
                        help='balance value in float data type',
                        default=1.0)

    parser.add_argument('--balance_account_id',
                        help='account id, data type integer',
                        default=1)

    args = parser.parse_args()

    main(_id=args.balance_id, _date=args.balance_date, _value=args.balance_value, _account_id= args.balance_account_id)