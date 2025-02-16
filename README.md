# Online Electronics Retail Store

## A Robust Database Management System for an E-commerce Platform Specializing in Electronics

This project is a comprehensive database management system designed for an online electronics retail store. It efficiently manages customer information, inventory, sales, financial data, and statistical insights.

## Features

### Users Can:
- Authenticate themselves on the application.
- Search for components and filter results based on preferences.
- Explore products compatible with their selected items.
- View purchase history.
- Provide product ratings and reviews.

### Store Manager(s) Can:
- Add or remove products.
- Manage offers and discounts.
- Specify product quantity and availability in warehouses.
- Access store statistics, including inventory, registered users, and revenue.

## Functional Requirements

1. **User Registration and Authentication**: Users can sign up and log in.
2. **Product Searching and Filtering**: Search by name, type, brand, and filter based on price, ratings, etc.
3. **Shopping Cart Management**: Add/remove products, view amount, delivery details.
4. **Inventory and Catalog Management**: Admin can update, add, delete, and modify products.
5. **Offer Management**: Admin can set discounts, with constraints like extra discount for online payments.
6. **Store Statistics**: Admin can access revenue, sales, and inventory insights.

## Technical Requirements

- **Web Application Interface**: User-friendly design with authentication and product recommendations.
- **User Experience**: Intuitive search, filtering, cart management, and checkout.
- **Database Management**: Efficiently track users, products, brands, prices, ratings, and warranty.

## Relational Model and ER Diagram
Refer to the `docs/` folder for detailed relational models and entity-relationship diagrams.

## Sample Queries

```sql
-- Select users by location and city
SELECT * FROM users WHERE add_pin = '30301' AND add_city = 'Atlanta';

-- Update the quantity of a specific product
UPDATE product SET quantity = 55 WHERE prod_id = 3;

-- Retrieve username and email of users with no purchases
SELECT username, email FROM users WHERE user_id NOT IN (SELECT DISTINCT user_id FROM ord_invoice);

-- Retrieve products priced above the average price
SELECT * FROM product WHERE price > (SELECT AVG(price) FROM product);
```

More queries available in `queries.sql`.

## Transactions

### Non-Conflicting Transactions:
- Viewing products (all or by category)
- Adding and removing products from the cart
- Placing orders
- Viewing inventory and orders

### Conflicting Transactions:
- **Concurrent Product Modification**: Two managers editing the same product simultaneously.
- **Concurrent Purchase Transaction**: Ensuring only one user successfully purchases a limited-stock item.

## Triggers

- **Inventory Monitoring Trigger**: Checks stock levels after new orders.
- **Customer Analysis Trigger**: Updates product category ratings based on reviews.

## Setup Guide

### 1. MySQL Database Setup
1. Import the `database.sql` file into MySQL.
2. Ensure necessary tables (`users`, `manager`, `category`, `product`, `ord_invoice`, `cart`, `review`, etc.) exist.
3. Pre-populated data available for testing.

### 2. Running the Python Program
1. Install dependencies:
   ```bash
   pip install mysql-connector-python
   ```
2. Run the Python script:
   ```bash
   python app.py
   ```

## Usage Guide

### Manager Operations
- Login as a manager.
- Manage inventory, modify product details, view orders and customers.

### User Operations
- Login as a user.
- Browse products, manage cart, and place orders.

## Future Enhancements
- Implement machine learning for personalized recommendations.
- Integrate payment gateways.
- Develop a REST API for external integrations.

## License
This project is licensed under the MIT License.

## Author
[Anya Hooda (2022088)](https://github.com/anya2041)

---
Feel free to contribute or raise issues!

