import pandas as pd
from collections import OrderedDict, defaultdict

df = pd.read_csv(r"C:\Users\saver\Downloads\502081722b.csv", encoding="ISO-8859-1", low_memory=False, delimiter=';')
df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True)

dd = df.to_dict('records')

for i in dd:
    print(i)

