USE hw_1;

CREATE TABLE sales(
	id SERIAL PRIMARY KEY,
    order_date DATE,
	count_product INT
);

INSERT INTO sales(order_date, count_product)
VALUES
	('2022-01-01', '156'),
    ('2022-01-02', '180'),
    ('2022-01-03', '21'),
    ('2022-01-04', '124'),
    ('2022-01-05', '341');

SELECT id,
	CASE
		WHEN count_product < 100 THEN 'Маленький заказ'
        WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
        WHEN count_product > 300 THEN 'Большой заказ'
	END AS 'Тип заказа'
FROM sales;

CREATE TABLE orders(
	id SERIAL PRIMARY KEY,
    employee_id VARCHAR(10),
	amount FLOAT,
    order_status VARCHAR(15)
);

INSERT INTO orders(employee_id, amount, order_status)
VALUES
	('e03', '15.00', 'OPEN'),
    ('e01', '25.50', 'OPEN'),
    ('e05', '100.70', 'CLOSED'),
    ('e02', '22.18', 'OPEN'),
    ('e04', '9.50', 'CANCELLED');
    
SELECT * , IF(order_status = 'OPEN', 'Order is in open state',
				IF(order_status = 'CLOSED', 'Order is closed', 'Order is cancelled')
			)
		AS 'full_order_status'
FROM orders;   