import pandas as pd
from collections import OrderedDict, defaultdict

class Read_csv:
    def __init__(self, _filepath):
        self.filepath = _filepath 
        self.accounts = ["Consors_depot",          
                        "DKB_depot",              
                        "DKB_giro",               
                        "DKB_tages",              
                        "Targo_depot",            
                        "comdirect_depot",        
                        "targo_fest",             
                        "targo_giro",             
                        "targo_hoch_zins",        
                        "targo_tages"  ]

    def read_consors_depot(self):
        df = pd.read_csv(self.filepath, encoding='utf8', low_memory=False, sep=';', skiprows=6, nrows=7)   
        df = df.drop(columns=['Währung/Prozent', 'Währung/Prozent.1', 'Währung/Prozent.2', 'Währung/Prozent.3'])
        float_data = ['Stück/Nominal', 'Einstandskurs inkl. NK', 'Einstandswert','Veränderung Intraday', 'Kurs', 'Gesamtwert EUR', 'Entwicklung absolut', 'Entwicklung prozentual']
        for i in float_data:
            df[i] = df[i].str.replace('.', '')
            df[i] = df[i].str.replace(',', '.').astype(float)

        return df

    def read_dkb_depot(self):      
        df = pd.read_csv(self.filepath, encoding="ISO-8859-1", low_memory=False, delimiter=';', skiprows=5,nrows=14)
        df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True) 
        df.drop(columns="Dev. Kurs")
        float_data = ['Bestand', 'Kurs', 'Gewinn / Verlust','Einstandswert', 'Kurswert in Euro']
        for i in float_data:
            df[i] = df[i].str.replace('.', '')
            df[i] = df[i].str.replace(',', '.').astype(float)

        df['Einstandskurs'] = df['Einstandswert'] / df['Bestand']
        return df

    def read_account(self, _account):
        if _account == 'DKB_depot':
            return self.read_dkb_depot()

    def myfunc(self):
        print(r'{}'. format(self.filepath))

# f1 = Read_csv(r"C:\Users\saver\Downloads\502081722b.csv")
# f1.myfunc()



# dd = df.to_dict('records')

# for i in dd:
#     print(i)

def main(_filepath, _account):
    o1 = Read_csv(_filepath)
    #dd = o1.read_dkb_depot()
    dd = o1.read_account(_account)
    print(dd)
    # for i in dd:
    #     print(i)


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: filepath of input file, account name in list')
    
    parser.add_argument('--filepath',
                        help='input file and its folder together',
                        default=r"I:\going_on\finance\DKB\502081722 (8).csv")
    parser.add_argument('--account',
                        help='input account name',
                        default=r"DKB_depot")


    
    args = parser.parse_args()

    main(_filepath=args.filepath, _account=args.account)