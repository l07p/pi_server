# This class handles files in different formats

import gzip

class file_working:
    def __init__(self):
        self.filepath = ''
        self.filename = ''
        self.flleend = ''
        
    def _set_filepath(self, _filepath):
        self.filepath = _filepath

class read_files:
    def __init__(self, thefile):
        self.file = thefile
 
    def read_zip_file(self):
        f = gzip.open(self.file.filepath, "r")
        f.close()
 
def main(filepath):   
    print('+++++calling class read_files.main\n')
    # wf = file_working()
    # wf._set_filepath(filepath)
    # rf = read_files(wf)
    # rf.read_zip_file()

    
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser('give filepath')
    parser.add_argument('--filepath', 
                        help='file path', 
                        default='I:\\tmp\\01112020111352.zip') 
    
    parser.add_argument('--filename',
                        help='file nameh', 
                        default='01112020111352.zip') 
    
    args = parser.parse_args()   
    print(args.filename) 
    main(filepath=args.filepath)