import pandas as pd
from collections import OrderedDict, defaultdict

class Read_csv:
    def __init__(self, _filepath):
        self.filepath = _filepath 

    def myfunc(self):
        print(r'{}'. format(self.filepath))

f1 = Read_csv(r"C:\Users\saver\Downloads\502081722b.csv")
f1.myfunc()

df = pd.read_csv(r"C:\Users\saver\Downloads\502081722b.csv", encoding="ISO-8859-1", low_memory=False, delimiter=';')
df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True)

dd = df.to_dict('records')

for i in dd:
    print(i)

