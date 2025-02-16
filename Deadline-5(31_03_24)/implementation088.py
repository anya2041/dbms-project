import mysql.connector

# Connect to the MySQL database
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="db_schema"
)
cursor = conn.cursor()

# Query to retrieve user information
cursor.execute("SELECT username, first_name, last_name FROM users")
print("Users:")
for row in cursor.fetchall():
    print(row)

# Query to retrieve product details for TVs
cursor.execute("SELECT product.prod_name, product.brand, tv.screen_size, tv.resolution FROM product INNER JOIN tv ON product.prod_id = tv.prod_id")
print("\nTVs:")
for row in cursor.fetchall():
    print(row)

# Close connection
conn.close()
