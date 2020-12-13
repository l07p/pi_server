
# importing the required libraries
import gspread
import pandas as pd
from oauth2client.service_account import ServiceAccountCredentials

class Google_sheets:
    def __init__(self, json_path):
        gc = gspread.service_account(filename=json_path)
        self.gsheet = gc.open("Financial statements")
        self.isin = [
            'xxxxxxxxxx',
            'xxyyyyyyyy',
            'DE0006289309',
            'DE000A0Q4R28',
            'LU0274211217',
            'LU0274211480',
            'LU0496786574',
            'DE000A0H08M3',
            'FR0007056841',
            'DE0005933972',
            'IE00B53SZB19',
            'LU0274221281'
            ]

    def get_wsheet(self, _wsheet):
        wsheet = self.gsheet.worksheet(_wsheet)
        return wsheet

    def update_etf_cell(self, _isin, _stueck_value,_einstandskurs_value):
        wsheet = self.gsheet.worksheet('etf')
        _row = self.isin.index(_isin)
        _pos = 'F' + str(_row)
        wsheet.update(_pos,_stueck_value)
        _pos = 'G' + str(_row)
        wsheet.update(_pos,_einstandskurs_value)

def tests():
    # define the scope
    scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']

    # add credentials to the account
    creds = ServiceAccountCredentials.from_json_keyfile_name(_json_path, scope)

    # authorize the clientsheet 
    client = gspread.authorize(creds)

    # get the instance of the Spreadsheet
    sheet = client.open('Financial statements')

    # get the first sheet of the Spreadsheet
    sheet_instance = sheet.get_worksheet(0)

    # get the total number of columns
    sheet_instance.col_count

    # get the value at the specific cell
    sheet_instance.cell(col=3,row=2)
    pass

def main(_json_path):
    o1 = Google_sheets(_json_path)
    wsheet = o1.get_wsheet('etf')
    df = pd.DataFrame(wsheet.get_all_records())
    print(df[['Stueck', 'Einstandskurs', 'EinstandsWert', 'Kurs','Kurswert']])
    



if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='parameters: filepath of input file, account name in list')
    
    parser.add_argument('--json_path',
                        help='input json file path',
                        default=r"C:\Users\saver\AppData\gspread\SheetsPython-ea71b57285ec.json")

    
    args = parser.parse_args()

    main(_json_path = args.json_path)