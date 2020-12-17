import pandas as pd
from collections import OrderedDict, defaultdict
from google_sheets import Google_sheets

class Read_csv:
    def __init__(self, _filepath):
        self.filepath = _filepath 
        self._df = None
        self.account = None
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

    def read_comdirect_depot(self):
        try:
            df = pd.read_csv(self.filepath, encoding="ISO-8859-1", low_memory=False, sep=';', skiprows=1, nrows=7)  
            print('Opened file: {}'.format(self.filepath)) 
        except FileNotFoundError as e:
            print('file not found. or {}'.format(e.args))
            return None
        df = df.drop(columns=['Notizen', 'Währung', 'Datum', 'Zeit', 'Börse', 'Unnamed: 17'])
        float_data = ['Stück/Nom.', 'Akt. Kurs', 'Diff. abs','Kaufkurs in EUR', 'Kaufwert in EUR']
        for i in float_data:
            df[i] = df[i].str.replace('.', '')
            df[i] = df[i].str.replace(',', '.').astype(float)
        self._df = df
        
    def update_sheet_values_comdirect(self, _json_path):
        v1 = Google_sheets(_json_path)
        dd = self._df.to_dict('records')
        
        for i in dd:
            if i['WKN'] in v1.wkn:
                _stueck = i['Stück/Nom.']
                _wkn = i['WKN']
                _einstandskurs = i['Kaufkurs in EUR']
                print('{1}  {0}  {2}'.format(_stueck, _wkn, _einstandskurs))
                v1.update_etf_cell_wi_wkn(_wkn, _stueck, _einstandskurs)
        pass

    def read_consors_depot(self):
        df = pd.read_csv(self.filepath, encoding='utf8', low_memory=False, sep=';', skiprows=6, nrows=7)   
        df = df.drop(columns=['Währung/Prozent', 'Währung/Prozent.1', 'Währung/Prozent.2', 'Währung/Prozent.3'])
        float_data = ['Stück/Nominal', 'Einstandskurs inkl. NK', 'Einstandswert','Veränderung Intraday', 'Kurs', 'Gesamtwert EUR', 'Entwicklung absolut', 'Entwicklung prozentual']
        for i in float_data:
            df[i] = df[i].str.replace('.', '')
            df[i] = df[i].str.replace(',', '.').astype(float)
        self._df = df

    def update_sheet_values_consors(self, _json_path):
        v1 = Google_sheets(_json_path)
        dd = self._df.to_dict('records')
        
        for i in dd:
            if i['WKN'] in v1.wkn:
                _stueck = i['Stück/Nominal']
                _wkn = i['WKN']
                _einstandskurs = i['Einstandskurs inkl. NK']
                print('{1}  {0}  {2}'.format(_stueck, _wkn, _einstandskurs))
                v1.update_etf_cell_wi_wkn(_wkn, _stueck, _einstandskurs)
        pass

    def read_dkb_depot(self):      
        df = pd.read_csv(self.filepath, encoding="ISO-8859-1", low_memory=False, delimiter=';', skiprows=5,nrows=14)
        df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True) 
        df.drop(columns="Dev. Kurs")
        float_data = ['Bestand', 'Kurs', 'Gewinn / Verlust','Einstandswert', 'Kurswert in Euro']
        for i in float_data:
            df[i] = df[i].str.replace('.', '')
            df[i] = df[i].str.replace(',', '.').astype(float)

        df['Einstandskurs'] = df['Einstandswert'] / df['Bestand']
        self._df = df


    def update_sheet_values(self, _json_path):
        v1 = Google_sheets(_json_path)
        dd = self._df.to_dict('records')
        
        for i in dd:
            if i['ISIN / WKN'] in v1.isin:
                _stueck = i['Bestand']
                _isin = i['ISIN / WKN']
                _einstandskurs = i['Einstandskurs']
                print('{1}  {0}  {2}'.format(_stueck, _isin, _einstandskurs))
                v1.update_etf_cell(_isin, _stueck, _einstandskurs)
        pass

    def read_account(self, _account):
        if _account in self.accounts:
            self.account = _account
        if _account == 'DKB_depot':
            self.read_dkb_depot()
        elif _account == 'Consors_depot':
            self.read_consors_depot()
        elif _account == 'comdirect_depot':
            self.read_comdirect_depot()
        else:
            pass

    def myfunc(self):
        print(r'{}'. format(self.filepath))

# dd = df.to_dict('records')

def main(_filepath, _account, _json_path):
    o1 = Read_csv(_filepath)
    o1.read_account(_account)
    # o1.update_sheet_values_comdirect(_json_path)
    o1.update_sheet_values_consors(_json_path)
    # o1.update_sheet_values(_json_path)
    pass


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: filepath of input file, account name in list')
    
    parser.add_argument('--filepath',
                        help='input file and its folder together',
                        default=r"C:\Users\saver\Downloads\Depotübersicht_788267505 (4).csv")
                        # default=r"C:\Users\saver\Downloads\depotuebersicht_9787270226_20201214-1801b.csv")
    parser.add_argument('--account',
                        help='input account name',
                        default=r"Consors_depot")
                        # default=r"comdirect_depot")

    parser.add_argument('--json_path',
                        help='input json file path',
                        default=r"C:\Users\saver\AppData\gspread\SheetsPython-ea71b57285ec.json")

    args = parser.parse_args()

    main(_filepath=args.filepath, _account=args.account, _json_path = args.json_path)