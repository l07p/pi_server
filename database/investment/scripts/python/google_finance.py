import yfinance as yf

msft = yf.Ticker("SIEGY")

# get stock info
print(msft.info)

# get historical market data
hist = msft.history(period="5d")