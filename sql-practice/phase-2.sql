-- Your code here
.print
.print =================    PHASE2      ========================
.print
.open coffee-shop.db
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS coffee_orders;
CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    phone NUMERIC(10,0) UNIQUE,
    email VARCHAR(255) UNIQUE,
    points INTEGER NOT NULL DEFAULT 5,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE coffee_orders (
    id INTEGER PRIMARY KEY,
    is_redeemmed BOOLEAN DEFAULT false,
    ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);
