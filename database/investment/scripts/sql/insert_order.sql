++++++ table products:
 id |                            name                             |  wkn   |     isin     | google_symbol | category_id 
----+-------------------------------------------------------------+--------+--------------+---------------+-------------
  2 | LYX.D.JON.IN.AV.U.ETF D                                     | 541779 | FR0007056841 | DJAM          | 
  3 | ISHARES TECDAX UCITS ETF DE                                 | 593397 | DE0005933972 | EXS2          | 
  4 | iShares EURO STOXX Banks 30-15 UCI                          | 628930 | DE0006289309 | EXX1          | 
  5 | iShares STOXX Europe 600 Oil & Gas UCITS ETF (DE)           | A0H08M | DE000A0H08M3 | EXH1          | 
  1 | iShares STOXX Europe 600 Automobiles & Parts UCITS ETF (DE) | A0Q4R2 | DE000A0Q4R28 | EXV5          | 
  7 | iShares NASDAQ 100 UCITS ETF                                | A0YEDL | IE00B53SZB19 | SXRV          | 
  8 | Xtrackers DAX® UCITS ETF 1                                  | DBX1DA | LU0274211480 | DBXD          | 
  9 | XTR.SWITZERLAND 1D                                          | DBX1SM | LU0274221281 | DBXS          | 
 10 | Lyxor S&P 500 UCITS ETF                                     | LYX0FS | LU0496786574 | LYPS          | 
(9 rows)

[pi_server] $ /bin/bash /tmp/jenkins16851021618294358262.sh
++++++ table accounts:
 id |      name       | bank_id | type_id 
----+-----------------+---------+---------
  2 | Consors_depot   |         | 
  1 | DKB_depot       |         | 
  4 | Targo_depot     |         | 
  3 | comdirect_depot |         | 
(4 rows)

[pi_server] $ /bin/bash /tmp/jenkins12611801226786207003.sh
++++++ table orders:
 id |   type    
----+-----------
  2 | Kauf
  4 | Kauf_plan
  1 | Plan
  3 | Verkauf
(4 rows)

INSERT INTO public.orders(
	date,kurs, stueck, provision, type_id, product_id, account_id)
	VALUES (
	'2020-11-16', 253.15,     1.975, 0.0,       4,       2,        4
	);

  -- 3 | ISHARES TECDAX UCITS ETF DE                                 | 593397 | DE0005933972 | EXS2          | 
'2020-10-5', 28.305, 17.6647, 1.5,       4,       3,        1
'2020-09-21', 27.465, 18.205, 1.5,       4,       3,        1

--   4 | iShares EURO STOXX Banks 30-15 UCI                          | 628930 | DE0006289309 | EXX1          | 
'2020-10-20', 5.54, 90.2527, 1.5,       4,       4,        1
'2020-09-24', 5.153, 193,  10.83,       2,       4,        1
'2020-09-21', 5.427, 184,  10.83,       2,       4,        1
'2020-09-20', 5.34, 93.633, 1.5,       4,       4,        1
'2020-09-16', 5.94,     168, 10,       2,       4,        1
'2020-09-18', 5.73,     174, 10.83,       2,       4,        1

--   5 | iShares STOXX Europe 600 Oil & Gas UCITS ETF (DE)           | A0H08M | DE000A0H08M3 | EXH1          | 
'2020-10-20', 19.102, 26.1753, 1.5, 4, 5, 1
'2020-09-07', 20.875, 23.9521, 1.5, 4, 5, 1
'2020-11-05', 18.88, 26.4831,   1.5, 4, 5, 1

  -- 7 | iShares NASDAQ 100 UCITS ETF                                | A0YEDL | IE00B53SZB19 | SXRV          | 
'2020-11-05', 577.6, 0.8657, 1.5, 4, 7, 1
'2020-10-05', 544.5, 0.9183, 1.5, 4, 7, 1

  -- 1 | iShares STOXX Europe 600 Automobiles & Parts UCITS ETF (DE) | A0Q4R2 | DE000A0Q4R28 | EXV5          | 
'2020-10-20', 12.0019, 41.66, 1.5, 4, 1, 1
'2020-09-20', 39.135,  12.7763, 1.5, 4, 1, 1

'2020-10-20', 101.26, 4.9378, 1.5, 4, 9, 1
'2020-10-20', 29.928, 16.7068, 1.5, 4, 10, 1

-- 2,231 LYX.D.JON.IN.AV.U.ETF D , WKN / ISIN: 541779 / FR0007056841 
-- 2 | LYX.D.JON.IN.AV.U.ETF D                                     | 541779 | FR0007056841 | DJAM          |
'2020-11-16', 253.15,     1.975, 0.0,       4,       2,        3
'2020-10-15', 241.7,      2.068, 0.0,       4,       2,        3
'2020-09-15', 237.70,     2.103, 0.0,       4,       2,        3
'2020-06-15', 224.10,     2.231, 0.0,       4,       2,        3
