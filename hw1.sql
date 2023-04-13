USE hw_1;
-- Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT product_name, manufacturer, price FROM mobile_phones WHERE product_count > 2;
-- Выведите весь ассортимент товаров марки “Samsung”
SELECT * FROM mobile_phones WHERE manufacturer = 'Samsung';
-- *
SELECT * FROM mobile_phones WHERE manufacturer OR product_name LIKE '%iphone%';
SELECT * FROM mobile_phones WHERE product_name OR manufacturer LIKE '%samsung%';
SELECT * FROM mobile_phones WHERE REGEXP_LIKE(product_name, '[[:digit:]]');