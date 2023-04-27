USE hw_1;

CREATE TABLE cars
(
	Id SERIAL,
    Name VARCHAR(30),
    Cost INT
);

INSERT INTO cars (Name, Cost)
VALUES
	('Audi', 52642),
	('Mercedes', 57127),
	('Skoda', 9000),
	('Volvo', 29000),
	('Bentley', 350000),
	('Citroen', 21000),
	('Hummer', 41400),
	('Volkswagen', 21600);

/*
1
Создайте представление, в которое попадут
автомобили стоимостью до 25 000 долларов
2
Изменить в существующем представлении
порог для стоимости: пусть цена будет до 30 000
долларов (используя оператор ALTER VIEW)
3
Создайте представление, в котором будут
только автомобили марки “Шкода” и “Ауди”
*/

-- 1
CREATE VIEW price AS
SELECT * 
FROM cars
WHERE Cost < 25000;

-- 2

ALTER VIEW price AS
SELECT *
FROM cars
WHERE Cost < 30000;

SELECT * FROM price;

-- 3 

CREATE OR REPLACE VIEW skoda_audi AS
SELECT *
FROM cars
WHERE Name IN ('Skoda', 'Audi');

SELECT * FROM skoda_audi;

/*
Вывести название и цену для всех анализов, которые продавались
5 февраля 2020 и всю следующую неделю.
*/

CREATE TABLE Analysis
(
	an_id SERIAL,
    an_name VARCHAR(50),
    an_cost FLOAT,
    an_price FLOAT,
    an_group INT
);

INSERT INTO Analysis(an_name, an_cost, an_price, an_group)
VALUES
	('Насыщение трансферрина расчет', 1250, 1700, 1),
    ('Билирубин непрямой', 999.99, 1500, 1),
    ('Альбумин', 799.99, 1299.99, 1),
    ('Общий белок белковые фракции', 1300, 1999.99, 1),
    ('Кальций общий', 999.99, 1500, 2),
    ('Кальций ионизированный', 799.99, 1299.99, 2),
    ('Фосфор неорганический', 1250, 1700, 2),
    ('Глюкоза', 500, 999.99, 3),
    ('Гликированный гемоглобин', 500, 1299.99, 3),
    ('Фруктозамин', 800, 1299.99, 3);

CREATE TABLE Groups_An
(
	gr_id SERIAL,
    gr_name VARCHAR(50),
    gr_temp FLOAT
);

INSERT INTO Groups_An(gr_name, gr_temp)
VALUES
	('Биохимия крови', 10),
    ('Витамины и минералы', 5),
    ('Кровь на сахар', 5);

CREATE TABLE Orders_An
(
	ord_id SERIAL,
    ord_datetime DATETIME,
    ord_an INT
);

INSERT INTO Orders_An(ord_datetime, ord_an)
VALUES
	('2020/02/05 13:20:00', 1),
	('2020/02/01 15:20:00', 2),
	('2020/02/05 9:25:00', 3),
	('2020/02/06 13:55:00', 4),
	('2020/02/03 10:10:00', 5),
	('2020/02/10 14:50:00', 6),
	('2020/02/09 17:22:00', 7),
	('2020/02/08 18:00:00', 8),
	('2020/02/05 9:40:00', 9),
	('2020/02/02 11:35:00', 5),
	('2020/02/08 12:45:00', 3),
	('2020/02/12 12:45:00', 3);

SELECT an_name, an_cost, an_price, ord_datetime
FROM analysis, orders_an
WHERE analysis.an_id = Orders_An.ord_an 
AND ord_datetime BETWEEN '2020-02-05' AND '2020-02-11'
ORDER BY ord_datetime;

-- Добавьте новый столбец под названием «время до следующей станции».
DROP TABLE train;
CREATE TABLE train
(
	train_id INT,
    station VARCHAR(20),
    station_time TIME(0)
);

INSERT INTO train(train_id, station, station_time)
VALUES
	(110, 'San Francisco', '10:00:00'),
	(110, 'Redwood City', '10:54:00'),
    (110, 'Palo Alto', '11:02:00'),
    (110, 'San Jose', '12:35:00'),
    (120, 'San Francisco', '11:00:00'),
    (120, 'Palo Alto', '12:49:00'),
    (120, 'San Jose', '13:30:00');

SELECT *,
TIMEDIFF(LEAD(station_time) OVER(PARTITION BY train_id), station_time) AS 'time_to_next_station'
FROM train;



