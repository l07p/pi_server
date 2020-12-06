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
        df = pd.read_csv(self.filepath, encoding='utf8', low_memory=False, delimiter=';', skiprows=6, nrows=7)   
        df = df.drop(columns=['Währung/Prozent', 'Währung/Prozent.1', 'Währung/Prozent.2', 'Währung/Prozent.3'])
        df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True)            
        return df.to_dict('records')    

    def read_dkb_depot(self):      
        df = pd.read_csv(self.filepath, encoding="ISO-8859-1", low_memory=False, delimiter=';', skiprows=5,nrows=14)
        df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True) 
        return df.to_dict('records')    

    def myfunc(self):
        print(r'{}'. format(self.filepath))

# f1 = Read_csv(r"C:\Users\saver\Downloads\502081722b.csv")
# f1.myfunc()



# dd = df.to_dict('records')

# for i in dd:
#     print(i)

def main(_filepath):
    o1 = Read_csv(_filepath)
    #dd = o1.read_dkb_depot()
    dd = o1.read_consors_depot()
    for i in dd:
        print(i)


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: filepath of input file, account name in list')
    
    parser.add_argument('--filepath',
                        help='input file and its folder together',
                        default=r"C:\Users\saver\Downloads\Depotübersicht_788267505 (2).csv")
    
    args = parser.parse_args()

    main(_filepath=args.filepath)