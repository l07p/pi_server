import psycopg2
from psycopg2 import sql

def insert_bank_data(bank_name, bank_address):
    try:
        # Establish the connection
        conn = psycopg2.connect(
            dbname="investment",
            user="postgres",
            password="root",
            host="192.168.178.79",
            port="5432"  # Default port is 5432
        )
        
        # Create a cursor object
        cur = conn.cursor()
        
        # Define the SQL INSERT query
        insert_query = sql.SQL("""
            INSERT INTO banks (bank_name, bank_code)
            VALUES (%s, %s)
            RETURNING bank_id;
        """)
        
        # Execute the query and fetch the new bank_id
        cur.execute(insert_query, (bank_name, bank_address))
        new_bank_id = cur.fetchone()[0]
        
        # Commit the transaction
        conn.commit()
        
        print(f"Data inserted successfully, new bank_id: {new_bank_id}")
        
    except Exception as e:
        print(f"An error occurred: {e}")
        
        # Rollback in case of error
        conn.rollback()
        
    finally:
        # Close the cursor and connection
        cur.close()
        conn.close()

# Example usage
insert_bank_data("Cash as Bank", "BAR100MIL")