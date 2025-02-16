import mysql.connector
import datetime

# Manager login function
def manager_login(cursor, username, password):
    cursor.execute("SELECT man_id FROM manager WHERE username = %s AND password = %s", (username, password))
    manager = cursor.fetchone()
    return manager[0] if manager else None

# Manager functionalities
def manager_actions(conn,cursor):
    while True:
        print("\nManager Actions:")
        print("1. View Inventory")
        print("2. Add New Product")
        print("3. Modify Product Details")
        print("4. Delete Product")
        print("5. View Orders")
        print("6. View Customers")
        print("7. Logout as Manager")
        choice = input("Enter your choice: ")

        if choice == "1":
            # Logic to view inventory
            cursor.execute("SELECT * FROM product")
            print("\nInventory:")
            for row in cursor.fetchall():
                print(row)
        elif choice == "2":
            # Logic to add new product
            prod_name = input("Enter product name: ")
            quantity = int(input("Enter quantity: "))
            brand = input("Enter brand: ")
            mrp = int(input("Enter MRP: "))
            discount = int(input("Enter discount: "))
            price = int(input("Enter price: "))
            model = input("Enter model: ")
            category_id = int(input("Enter category ID: "))  # Prompt the manager to enter the category ID
            try:
                cursor.execute("INSERT INTO product (prod_name, quantity, brand, mrp, discount, price, model, category_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", (prod_name, quantity, brand, mrp, discount, price, model, category_id))
                print("Product added successfully.")
                conn.commit()  # Commit the transaction
            except mysql.connector.Error as err:
                print("Error:", err)

        elif choice == "3":
            # Logic to modify product details
            prod_id = int(input("Enter product ID to modify: "))
            field = input("Enter field to modify (prod_name, quantity, brand, mrp, discount, price, model, category_id): ")
            new_value = input(f"Enter new value for {field}: ")
            try:
                cursor.execute(f"UPDATE product SET {field} = %s WHERE prod_id = %s", (new_value, prod_id))
                print("Product details modified successfully.")
            except mysql.connector.Error as err:
                print("Error:", err)
        elif choice == "4":
            # Logic to delete product
            prod_id = int(input("Enter product ID to delete: "))
            try:
                cursor.execute("DELETE FROM product WHERE prod_id = %s", (prod_id,))
                print("Product deleted successfully.")
            except mysql.connector.Error as err:
                print("Error:", err)
        elif choice == "5":
            # Logic to view orders
            cursor.execute("SELECT * FROM ord_invoice")
            print("\nOrders:")
            for row in cursor.fetchall():
                print(row)
            conn.commit()
        elif choice == "6":
            view_customers(cursor)
        elif choice == "7":
            print("Logging out as manager.")
            break
        else:
            print("Invalid choice. Please try again.")
            
def view_customers(cursor):
    cursor.execute("SELECT * FROM users")
    print("\nCustomers:")
    for row in cursor.fetchall():
        print(row)

def user_login(cursor, username, password):
    cursor.execute("SELECT user_id FROM users WHERE username = %s AND password = %s", (username, password))
    user = cursor.fetchone()
    return user[0] if user else None

def display_all_products(cursor):
    cursor.execute("SELECT * FROM product")
    print("\nAll Products:")
    for row in cursor.fetchall():
        print(row)

def display_products_category_wise(cursor):
    categories = {
        1: "TVs",
        2: "Mobiles",
        3: "Laptops",
        4: "Monitors",
        5: "Accessories"
    }
    while True:
        print("\nSelect a category:")
        for category_id, category_name in categories.items():
            print(f"{category_id}. {category_name}")
        print(f"{len(categories)+1}. Go Back")
        choice = input("Enter your choice: ")

        if choice.isdigit() and int(choice) in categories:
            display_category_products(cursor, int(choice))
        elif choice.isdigit() and int(choice) == len(categories)+1:
            break
        else:
            print("Invalid choice. Please try again.")

def display_category_products(cursor, category_id):
    category_name = get_category_name(category_id)
    cursor.execute("SELECT * FROM product WHERE category_id = %s", (category_id,))
    print(f"\n{category_name}:")
    for row in cursor.fetchall():
        print(row)

def get_category_name(category_id):
    categories = {
        1: "TVs",
        2: "Mobiles",
        3: "Laptops",
        4: "Monitors",
        5: "Accessories"
    }
    return categories.get(category_id, "Unknown")

def display_cart(cursor, user_id):
    try:
        # Fetch the cart items for the user
        cursor.execute("SELECT c.prod_id, p.prod_name, p.brand, p.price, c.quantity \
                        FROM cart c \
                        JOIN product p ON c.prod_id = p.prod_id \
                        WHERE c.user_id = %s", (user_id,))
        cart_items = cursor.fetchall()

        if not cart_items:
            print("Cart is empty.")
            return

        # Display the cart items
        print("Cart:")
        total_price = 0
        for item in cart_items:
            product_id, product_name, brand, price, quantity = item
            total_price += price * quantity

            print(f"Product: {product_name}, Brand: {brand}, Price: {price}, Quantity: {quantity}")

        # Display the total price
        print(f"Total Price: {total_price}")

    except mysql.connector.Error as err:
        print("Error:", err)


def add_to_cart(cursor, user_id, prod_id, quantity):
    cursor.execute("INSERT INTO cart (user_id, prod_id, quantity) VALUES (%s, %s, %s)", (user_id, prod_id, quantity))

def remove_from_cart(cursor, user_id, prod_id):
    try:
        cursor.execute("SELECT * FROM Cart WHERE user_id = %s AND prod_id = %s", (user_id, prod_id))
        cart_item = cursor.fetchone()
        
        if cart_item:
            quantity = cart_item[2]
            if quantity > 1:
                cursor.execute("UPDATE Cart SET quantity = %s WHERE user_id = %s AND prod_id = %s", (quantity - 1, user_id, prod_id))
            else:
                cursor.execute("DELETE FROM Cart WHERE user_id = %s AND prod_id = %s", (user_id, prod_id))
            print("Product removed from cart.")
        else:
            print("Product not found in cart.")

    except mysql.connector.Error as err:
        print("Error:", err)


def place_order(cursor, user_id, cart_items):
    try:
        purchase_time = datetime.datetime.now()  # Get current timestamp
        for item in cart_items:
            cursor.execute("INSERT INTO ord_invoice (user_id, prod_id, quantity, purchase_time) VALUES (%s, %s, %s, %s)",
                           (user_id, item[0], item[1], purchase_time))
        print("Order placed successfully.")

        # Remove cart items after placing the order
        cursor.execute("DELETE FROM cart WHERE user_id = %s", (user_id,))
        print("Cart cleared successfully.")

    except mysql.connector.Error as err:
        print("Error:", err)


def display_product_details(cursor, prod_id):
    cursor.execute("SELECT * FROM product WHERE prod_id = %s", (prod_id,))
    print("\nProduct Details:")
    print(cursor.fetchone())

def get_cart_items(cursor, user_id):
    try:
        cursor.execute("SELECT prod_id, quantity FROM cart WHERE user_id = %s", (user_id,))
        return cursor.fetchall()
    except mysql.connector.Error as err:
        print("Error:", err)
        return []


def main():
    # Connect to the MySQL database
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="db_schema"
    )
    cursor = conn.cursor()

    while True:
        print("\nSelect user type:")
        print("1. Login as User")
        print("2. Login as Manager")
        print("3. Exit")
        user_type = input("Enter your choice: ")

        if user_type == "1":
            # User login
            while True:
                username = input("Enter username: ")
                password = input("Enter password: ")
                user_id = user_login(cursor, username, password)
                if user_id:
                    print("Login successful.")
                    break
                else:
                    print("Invalid username or password. Please try again.")

            
            # Display user options
            while True:
                print("\nSelect an option:")
                print("1. View All Products")
                print("2. View Products Category-wise")
                print("3. Display Cart")
                print("4. Add to Cart")
                print("5. Remove from Cart")
                print("6. Place Order")
                print("7. Display Product Details")
                print("8. Logout")
                choice = input("Enter your choice: ")

                if choice == "1":
                    display_all_products(cursor)
                elif choice == "2":
                    display_products_category_wise(cursor)
                elif choice == "3":
                    display_cart(cursor, user_id)
                elif choice == "4":
                    prod_id = input("Enter product ID: ")
                    quantity = input("Enter quantity: ")
                    add_to_cart(cursor, user_id, prod_id, quantity)
                    conn.commit()
                    print("Product added to cart.")
                elif choice == "5":
                    prod_id = input("Enter product ID to remove: ")
                    remove_from_cart(cursor, user_id, prod_id)
                    conn.commit()
                    print("Product removed from cart.")
                elif choice == "6":
                    cart_items = get_cart_items(cursor, user_id)
                    if cart_items:  # Checking if cart_items is not empty
                        place_order(cursor, user_id, cart_items)
                        conn.commit()
                    else:
                        print("Cart is empty. Please add items before placing an order.")

                elif choice == "7":
                    prod_id = input("Enter product ID: ")
                    display_product_details(cursor, prod_id)
                elif choice == "8":
                    print("Logging out.")
                    break
                else:
                    print("Invalid choice. Please try again.")
        elif user_type == "2":
            # Manager login
            while True:
                username = input("Enter manager username: ")
                password = input("Enter manager password: ")
                manager_id = manager_login(cursor, username, password)
                if manager_id:
                    print("Manager login successful.")
                    manager_actions(conn,cursor)
                    break
                else:
                    print("Invalid manager username or password. Please try again.")
        elif user_type == "3":
            print("Exiting program.")
            break
        else:
            print("Invalid choice. Please try again.")

    # To Close connection
    conn.close()

if __name__ == "__main__":
    main()


