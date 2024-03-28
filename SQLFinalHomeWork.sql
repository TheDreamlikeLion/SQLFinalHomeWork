-- 1.Создайте функцию, которая принимает кол-во сек и далее переводит их в кол-во дней, часов, минут, секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

CREATE DATABASE sql_home_work;
USE sql_home_work;
DROP FUNCTION IF EXISTS TransformSeconds;

DELIMITER $$

CREATE FUNCTION TransformSeconds(time_input int unsigned) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
  DECLARE days_count int unsigned;
  DECLARE hours_count int unsigned;
  DECLARE mins_count int unsigned;
  DECLARE secs_count int unsigned;
  DECLARE result_string VARCHAR(255) default '';
      
  SET days_count = floor(time_input / (60*60*24));
  SET time_input = time_input % (60*60*24);
  SET hours_count = floor(time_input / (60*60));
  SET time_input = time_input % (60*60);
  SET mins_count = floor(time_input / 60);
  SET secs_count = time_input % 60;

  IF days_count > 0 THEN
		SET result_string = concat(days_count, ' days');
	END IF;
	IF hours_count > 0 THEN
		SET result_string = concat(result_string,' ',hours_count,' hours');
	END IF;
	IF mins_count > 0 THEN
		SET result_string = concat(result_string, ' ', mins_count, ' minutes');
	END IF;
	IF secs_count > 0 THEN
		SET result_string = concat(result_string,' ', secs_count, ' seconds');
	END IF;
	RETURN result_string;
END $$

DELIMITER ;

SELECT TransformSeconds(173647);



-- 2.Cоздайте процедуру, которая выведет только числа, делящиеся на 15 или 33 в промежутке от 1 до 1000.
-- Пример: 15,30,33,45...

DROP PROCEDURE IF EXISTS FilteredNumbers;
DROP TEMPORARY TABLE IF EXISTS filtered_numbers;
DELIMITER $$
CREATE PROCEDURE FilteredNumbers(IN N1 INT, IN N2 INT, IN lim1 INT, IN lim2 INT)
BEGIN
  DECLARE counter INT;
  SET counter = lim1;
	CREATE TEMPORARY TABLE IF NOT EXISTS filtered_numbers (num int);
  WHILE counter <= lim2 DO
		IF (counter % N1 = 0 OR counter % N2 = 0) THEN
			INSERT INTO filtered_numbers (num)
				VALUES (counter);
		END IF;
    SET counter = counter + 1;
  END WHILE;    
END $$
DELIMITER ;

CALL FilteredNumbers(15, 33, 1, 1000);
SELECT * FROM filtered_numbers;
