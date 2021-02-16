import pandas as pd
from collections import OrderedDict, defaultdict
from google_sheets import Google_sheets

import re
import datetime

##########################################################
## a function to convert , to . then string to float with .
##########################################################
def convert_decimal_from_comm_to_point(_df, _columns):
    try:
        for i in _columns:
            _df[i] = _df[i].str.replace('%', '')            
            _df[i] = _df[i].str.replace('.', '')
            _df[i] = _df[i].str.replace(',', '.').astype(float)
    except:
        print('no convert, maybe already decimal/float.')
        return _df
    return _df

class Read_csv:
    def __init__(self, _filepath):
        self.filepath = _filepath 
        self.date_str = '1970-07-01'
        self._df = None
        self.range_lines = 0
        self.dict = None
        self.wkn = None
        self.isin = None
        self.account = None
        self.accounts = ["DKB_depot",
                        "comdirect_depot",
                        "targo_giro",
                        "targo_tages",
                        "targo_fest",
                        "targo_hoch_zins",
                        "DKB_giro",
                        "DKB_tages",
                        "equateplus",
                        "comdirect_verrechnung",
                        "comdirect_giro",
                        "consors_giro",
                        "consors_fest",
                        "consors_verrechnung",
                        "consors_tages",
                        "targo_depot",
                        "consors_depot",
                        "ikb_usd" ]
                        

    def read_comdirect_depot(self):
        ret = None
        try:
            pattern = re.compile(r'Datum:...*([0-9][0-9].[0-9][0-9].[0-9][0-9][0-9][0-9])(.....*)')
            with open(self.filepath, 'r', encoding='ISO-8859-1', errors='strict') as f:
                contents = f.read()
                vars = re.findall(pattern, contents)
                ret = vars[0][0]
        
                self.date_str = datetime.datetime.strptime(ret, '%d.%m.%Y').strftime('%Y-%m-%d')
                self.range_lines = len(contents.splitlines()) - 16


            df = pd.read_csv(self.filepath, encoding="ISO-8859-1", low_memory=False, sep=';', skiprows=1, nrows=self.range_lines)  
            print('Opened file: {}'.format(self.filepath)) 
        except FileNotFoundError as e:
            print('file not found. or {}'.format(e.args))
            return None
        df = df.drop(columns=['Notizen', 'Währung', 'Datum', 'Zeit', 'Börse', 'Diff. %', 'Diff. %.1', 'Unnamed: 17'])

        float_data = ['Stück/Nom.', 'Akt. Kurs', 'Diff. abs','Kaufkurs in EUR', 'Kaufwert in EUR', 'Wert in EUR']
        self._df = convert_decimal_from_comm_to_point(df, float_data) # convert , to . then float decimal with .

        self.dict = self._df.to_dict('records')
        
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
        ret = None

        pattern = re.compile(r'Bestand per:...([0-9][0-9].[0-9][0-9].[0-9][0-9][0-9][0-9])(.....*)')
        with open(self.filepath, 'r', encoding='ISO-8859-1', errors='strict') as f:
            contents = f.read()
            vars = re.finditer(pattern, contents)

        for var in vars:
            ret = var.group(1)
        
        self.date_str = datetime.datetime.strptime(ret, '%d.%m.%Y').strftime('%Y-%m-%d')

        df = pd.read_csv(self.filepath, encoding="ISO-8859-1", low_memory=False, delimiter=';', skiprows=5,nrows=14)
        df.drop(df.columns[df.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True) 
        df.drop(columns="Dev. Kurs")
        float_data = ['Bestand', 'Kurs', 'Gewinn / Verlust','Einstandswert', 'Kurswert in Euro']
        for i in float_data:
            df[i] = df[i].str.replace('.', '')
            df[i] = df[i].str.replace(',', '.').astype(float)

        df['Einstandskurs'] = df['Einstandswert'] / df['Bestand']
        self._df = df
        self.dict = self._df.to_dict('records')

    def read_dkb_giro(self):        
        with open(self.filepath, 'r', encoding='ISO-8859-1', errors='strict') as f:
            contents = f.read()

            self.range_lines = len(contents.splitlines())


        df = pd.read_csv(self.filepath, encoding="ISO-8859-1", low_memory=False, delimiter=';', skiprows=6,nrows=self.range_lines)
        df.drop(df.columns[df.columns.str.contains('Unnamed',case = False)],axis = 1, inplace = True) 
        df.drop(columns=['Buchungstag', 'BLZ', 'Gläubiger-ID', 'Mandatsreferenz', 'Kundenreferenz'], axis = 1, inplace=True)
        float_data = ['Betrag (EUR)']
        for i in float_data:
            df[i] = df[i].str.replace('.', '')
            df[i] = df[i].str.replace(',', '.').astype(float)

        # df['Einstandskurs'] = df['Einstandswert'] / df['Bestand']
        self._df = df
        self.dict = self._df.to_dict('records')

    def update_sheet_values_dkb(self, _json_path):
        v1 = Google_sheets(_json_path)
        dd = self._df.to_dict('records')
        
        for i in dd:
            if i['ISIN / WKN'] in v1.isin:
                _stueck = i['Bestand']
                _isin = i['ISIN / WKN']
                _einstandskurs = i['Einstandskurs']
                print('{1}  {0}  {2}'.format(_stueck, _isin, _einstandskurs))
                v1.update_etf_cell_wi_isin(_isin, _stueck, _einstandskurs)
        pass


    def update_sheet_values(self, _json_path):
        if self.account == None:
            print('no account is given at all.')
            return None

        

        if self.account == 'comdirect_depot':
            self.update_sheet_values_comdirect(_json_path)
        elif self.account == 'consors_depot':
            self.update_sheet_values_consors(_json_path)
        elif self.account == 'DKB_depot':
            self.update_sheet_values_dkb(_json_path)
        else:
            print('------no correct account is selected.')
            pass
        pass

    def read_giro(self, _account):
        if _account in self.accounts:
            self.account = _account

        if _account == 'DKB_giro':
            self.read_dkb_giro()
        # elif _account == 'consors_depot':
        #     self.read_consors_depot()
        # elif _account == 'comdirect_depot':
        #     self.read_comdirect_depot()
        else:
            pass

    def read_depot(self, _account):
        if _account in self.accounts:
            self.account = _account
        if _account == 'DKB_depot':
            self.read_dkb_depot()
        elif _account == 'consors_depot':
            self.read_consors_depot()
        elif _account == 'comdirect_depot':
            self.read_comdirect_depot()
        else:
            pass

    def myfunc(self):
        print(r'{}'. format(self.filepath))

# dd = df.to_dict('records')

def main(_filepath, _account, _json_path):
    print(_filepath)
    print(_account)
    print(_json_path)
    o1 = Read_csv(_filepath)
    o1.read_depot(_account)
    o1.update_sheet_values(_json_path)
    pass


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: filepath of input file, account name in list')
    
    parser.add_argument('--filepath',
                        help='input file and its folder together',
                        # default=r"C:\Users\saver\Downloads\depotuebersicht_9787270226_20210208-1525.csv")
                        default=r"C:\Users\saver\Downloads\Depotübersicht_788267505 (10).csv")
                        # default=r"C:\Users\saver\Downloads\depotuebersicht_9787270226_20210112-1028.csv")
                        # default=r"C:\Users\saver\Downloads\502081722 (9).csv")
                        # default=r"/media/lnmycloud/archives/banks/consors/Depotübersicht_788267505 (5).csv")

    parser.add_argument('--account',
                        help='input account name',
                        default=r"consors_depot")
                        # default=r"comdirect_depot")

    parser.add_argument('--json_path',
                        help='input json file path',
                        default=r"C:\Users\saver\AppData\gspread\SheetsPython-ea71b57285ec.json")
                        # default=r"/media/lnmycloud/certificates/gspread/SheetsPython-ea71b57285ec.json")

    args = parser.parse_args()

    main(_filepath=args.filepath, _account=args.account, _json_path = args.json_path)
