USE new_schema;

/*
Создайте функцию, которая принимает количество секунд 
и форматирует их в коилчество дней, часов, минут и секунд.
*/

DELIMITER //
CREATE FUNCTION converter(n INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
DECLARE day INT DEFAULT 0;
DECLARE hour INT DEFAULT 0;
DECLARE min INT DEFAULT 0;
DECLARE sec INT DEFAULT 0;
WHILE n > 0 DO
	CASE
		WHEN n >= 86400 THEN    
			SET day = n DIV 86400;
			SET n = n - 86400 * day;
		WHEN n >= 3600 THEN                      
			SET hour = n DIV 3600; 
            SET n = n - 3600 * hour;    
		WHEN n >= 60 THEN
			SET min = n DIV 60;  
            SET n = n - 60 * min; 
		WHEN n < 60 THEN
			SET sec = n;
            SET n = 0;
	END CASE;
END WHILE;
RETURN CONCAT(day, ' дней ', hour, ' часов ', min, ' минут ', sec, ' секунд');
END //
DELIMITER ;

SELECT converter(123456);

-- Выведите только четные числа от 1 до 10 включительно.

DELIMITER $$
CREATE PROCEDURE even_proc()
BEGIN
DECLARE n INT DEFAULT 2;
DECLARE res VARCHAR(15) DEFAULT '';

		REPEAT
		SET res = CONCAT(res, ' ', n);
		SET n = n + 2;
		UNTIL n > 10
		END REPEAT;
	SELECT res;
END $$
DELIMITER ;

CALL even_proc();