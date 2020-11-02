#!/usr/bin/python3.8
# This class treats with product and its table in database 'investment'

import psycopg2

try:
    conn = psycopg.connect("dbname='investment' user='pi' host='localhost' password='ueber500mal'")
except:
    print ('I am unable to connect to the database')
