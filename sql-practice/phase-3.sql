-- Your code here
.print
.print =================    PHASE3      ========================
.print
.read phase-2.sql
/*
Events:

1. A new customer joined the loyalty program with the following customer information:
NAME	PHONE
Rachel	111-111-1111
*/
INSERT INTO customers (name, phone)
    VALUES 
    ('Rachel', 1111111111);
SELECT * FROM customers;

/*
2.Rachel purchases a coffee. (When adding a coffee order, you must first check the current points of the customer, update the customer's points, then add the coffee order.)
*/
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE phone = 1111111111) + 1
    WHERE phone = 1111111111    
;
INSERT INTO coffee_orders DEFAULT VALUES;
SELECT * FROM coffee_orders;
/*
/* 3. Two new customers joined the loyalty program with the following customer information:
NAME	EMAIL	PHONE
Monica	monica@friends.show	222-222-2222
Phoebe	phoebe@friends.show	333-333-3333
*/
INSERT INTO customers (name, email, phone)
    VALUES 
    ('Monica',	'monica@friends.show',	2222222222),
    ('Phoebe',	'phoebe@friends.show',	3333333333)
;
SELECT * FROM customers;

--4. Phoebe purchases three coffees.
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE email = 'phoebe@friends.show') + 3
    WHERE email = 'phoebe@friends.show'
    
;
INSERT INTO coffee_orders (is_redeemmed)
    VALUES (false), (false), (false);
SELECT * FROM coffee_orders;

--5 Rachel and Monica each purchase four coffees.
.print ------------------ 5 ----------------------
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE email = 'monica@friends.show') + 4
    WHERE email = 'monica@friends.show' 
;
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE phone = 1111111111) + 4
    WHERE phone = 1111111111
;
INSERT INTO coffee_orders (is_redeemmed)
    VALUES 
    (false), (false), (false), (false),
    (false), (false), (false), (false)
;
-- 6. Monica wants to know her new point total.
SELECT * FROM  customers WHERE email = 'monica@friends.show';

-- 7. Rachel wants to check her total points. Redeem her points for a coffee if she has enough points. If she doesn't, she wants to purchase a coffee.
.print ------ 7. Rachel wants to check
SELECT * FROM  customers WHERE phone = 1111111111;
-- insert order first - keeps points
INSERT INTO coffee_orders (is_redeemmed)
    VALUES 
        (CASE ((SELECT points FROM customers WHERE phone = 1111111111) >=10)
            WHEN true THEN 
                true
            ELSE
                false
        END)
;
UPDATE customers
    SET points = 
        CASE ((SELECT points FROM customers WHERE phone = 1111111111) >=10)
            WHEN true THEN 
                (SELECT points FROM customers WHERE phone = 1111111111) - 10
            ELSE
                (SELECT points FROM customers WHERE phone = 1111111111) + 1
        END
    WHERE phone = 1111111111
;
SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 1;
SELECT * FROM  customers WHERE phone = 1111111111;

/*
8.Three new customers joined the loyalty program with the following customer information:
NAME	EMAIL
Joey	joey@friends.show
Chandler	chandler@friends.show
Ross	ross@friends.show
*/
.print -------- 8.Three new customers joined
INSERT INTO customers (name, email)
    VALUES 
    ('Joey',	'joey@friends.show'),
    ('Chandler',	'chandler@friends.show'),
    ('Ross',	'ross@friends.show');
SELECT * FROM customers ORDER BY id DESC LIMIT 3;


.print -------- --9.Ross purchases six coffees.

SELECT * FROM customers WHERE email = 'ross@friends.show';
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE email = 'ross@friends.show') + 6
    WHERE email = 'ross@friends.show'
;
INSERT INTO coffee_orders (is_redeemmed)
    VALUES (false), (false), (false),
           (false), (false), (false);

SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 6;
SELECT * FROM customers WHERE email = 'ross@friends.show';

.print ---  --10.Monica purchases three coffees.
SELECT * FROM customers WHERE email = 'monica@friends.show';
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE email = 'monica@friends.show') + 3    
    WHERE email = 'monica@friends.show'
;
INSERT INTO coffee_orders (is_redeemmed)
     VALUES (false), (false), (false);
SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 3;
SELECT * FROM customers WHERE email = 'monica@friends.show';

--11.Phoebe wants to check her total points. Redeem her points for a coffee if she has enough points. If she doesn't, she wants to purchase a coffee.
.print -------- 11. Phoebe wants to check/change her total points

SELECT * FROM  customers WHERE email = 'phoebe@friends.show';
-- insert order first - keeps points
INSERT INTO coffee_orders (is_redeemmed)
    VALUES 
        (CASE ((SELECT points FROM customers WHERE email = 'phoebe@friends.show') >=10)
            WHEN true THEN 
                true
            ELSE
                false
        END)    
;
UPDATE customers
    SET points = 
        CASE ((SELECT points FROM customers WHERE email = 'phoebe@friends.show') >=10)
            WHEN true THEN 
                (SELECT points FROM customers WHERE email = 'phoebe@friends.show') - 10
            ELSE
                (SELECT points FROM customers WHERE email = 'phoebe@friends.show') + 1
        END
    WHERE email = 'phoebe@friends.show'
;
SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 1;
SELECT * FROM  customers WHERE email = 'phoebe@friends.show';

/*
12.Ross demands a refund for the last two coffees that he ordered. 
(Make sure you delete Ross's coffee orders and not anyone else's. 
Update his points to reflect the returned purchases.)
*/
.print ----- 12 Ross demands a refund for the last two coffees

SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 8;
SELECT * FROM customers WHERE email = 'ross@friends.show';
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE email = 'ross@friends.show') - 2    
    WHERE email = 'ross@friends.show'
;
-- lasr coffe id = SELECT id FROM coffee_orders ORDER BY id DESC LIMIT 1;
DELETE FROM coffee_orders 
    WHERE id = (SELECT id FROM coffee_orders ORDER BY id DESC LIMIT 1) - 4 
        OR id = (SELECT id FROM coffee_orders ORDER BY id DESC LIMIT 1) - 5 
;

SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 8;
SELECT * FROM customers WHERE email = 'ross@friends.show';

.print ---------   13.Joey purchases two coffees.

SELECT * FROM customers WHERE email = 'joey@friends.show';
UPDATE customers
    SET points = 
        (SELECT points FROM customers WHERE email = 'joey@friends.show') + 2    
    WHERE email = 'joey@friends.show'
;
INSERT INTO coffee_orders (is_redeemmed)
     VALUES (false), (false);
SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 2;
SELECT * FROM customers WHERE email = 'joey@friends.show';

--14.Monica wants to check her total points. Redeem her points for a coffee if she has enough points. If she doesn't, she wants to purchase a coffee.

SELECT * FROM  customers WHERE email = 'monica@friends.show';
-- insert order first - keeps points
INSERT INTO coffee_orders (is_redeemmed)
    VALUES 
        (CASE ((SELECT points FROM customers WHERE email = 'monica@friends.show') >=10)
            WHEN true THEN 
                true
            ELSE
                false
        END)
;
UPDATE customers
    SET points = 
        CASE ((SELECT points FROM customers WHERE email = 'monica@friends.show') >=10)
            WHEN true THEN 
                (SELECT points FROM customers WHERE email = 'monica@friends.show') - 10
            ELSE
                (SELECT points FROM customers WHERE email = 'monica@friends.show') + 1
        END
    WHERE email = 'monica@friends.show'
;
SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 1;
SELECT * FROM  customers WHERE email = 'monica@friends.show';

--15.Chandler wants to delete his loyalty program account.
.print -------------- 15 ---------------------
SELECT * FROM customers WHERE email = 'chandler@friends.show';
DELETE FROM customers WHERE email = 'chandler@friends.show';
SELECT * FROM customers WHERE email = 'chandler@friends.show';
.print - if no second time Chandler,  Chandler line deleted


--16.Ross wants to check his total points. Redeem his points for a coffee if he has enough points. If he doesn't, he wants to purchase a coffee.
SELECT * FROM  customers WHERE email = 'ross@friends.show';
-- insert order first - keeps points
INSERT INTO coffee_orders (is_redeemmed)
    VALUES 
        (CASE ((SELECT points FROM customers WHERE email = 'ross@friends.show') >=10)
            WHEN true THEN 
                true
            ELSE
                false
        END)
;
UPDATE customers
    SET points = 
        CASE ((SELECT points FROM customers WHERE email = 'ross@friends.show') >=10)
            WHEN true THEN 
                (SELECT points FROM customers WHERE email = 'ross@friends.show') - 10
            ELSE
                (SELECT points FROM customers WHERE email = 'ross@friends.show') + 1
        END
    WHERE email = 'ross@friends.show'
;
SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 1;
SELECT * FROM  customers WHERE email = 'ross@friends.show';

--17.Joey wants to check his total points. Redeem his points for a coffee if he has enough points. If he doesn't, he wants to purchase a coffee.
SELECT * FROM  customers WHERE email = 'joey@friends.show';
-- insert order first - keeps points
INSERT INTO coffee_orders (is_redeemmed)
    VALUES 
        (CASE ((SELECT points FROM customers WHERE email = 'joey@friends.show') >=10)
            WHEN true THEN 
                true
            ELSE
                false
        END)
;
UPDATE customers
    SET points = 
        CASE ((SELECT points FROM customers WHERE email = 'joey@friends.show') >=10)
            WHEN true THEN 
                (SELECT points FROM customers WHERE email = 'joey@friends.show') - 10
            ELSE
                (SELECT points FROM customers WHERE email = 'joey@friends.show') + 1
        END
    WHERE email = 'joey@friends.show'
;
SELECT * FROM coffee_orders ORDER BY id DESC LIMIT 1;
SELECT * FROM  customers WHERE email = 'joey@friends.show';

--18.Phoebe wants to change her email to p_as_in_phoebe@friends.show
SELECT * FROM  customers WHERE email = 'phoebe@friends.show';
UPDATE customers 
    SET email = 'p_as_in_phoebe@friends.show'
    WHERE email = 'phoebe@friends.show'
;
SELECT * FROM  customers WHERE email = 'p_as_in_phoebe@friends.show';
.print --------------- final check phase 3 -----------------
SELECT * FROM  customers;
SELECT * FROM  coffee_orders;