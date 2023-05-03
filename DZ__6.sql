/*
Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру,  
с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно)
*/

DROP DATABASE IF EXISTS dz_6;
CREATE DATABASE dz_6;
USE dz_6;

-- создаем таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50),
  lastname VARCHAR(50) COMMENT 'Фамилия',
  email VARCHAR(120) UNIQUE
);

-- вставляем данные в таблицу пользователей
INSERT INTO users (firstname, lastname, email) VALUES 
('Reuben', 'Nienow', 'arlo50@example.org'),
('Frederik', 'Upton', 'terrence.cartwright@example.org'),
('Unique', 'Windler', 'rupert55@example.org'),
('Norene', 'West', 'rebekah29@example.net'),
('Frederick', 'Effertz', 'von.bridget@example.net');

-- создаем таблицу старых пользователей
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50),
  lastname VARCHAR(50),
  email VARCHAR(120)
);

-- вставляем данные в таблицу старых пользователей
INSERT INTO users_old (firstname, lastname, email) SELECT firstname, lastname, email FROM users WHERE id = 3;

-- удаляем пользователя из таблицы users
DELETE FROM users WHERE id = 3;

-- создаем процедуру перемещения пользователей
DROP PROCEDURE IF EXISTS move;
DELIMITER //
CREATE PROCEDURE move(IN searched INT)
  BEGIN
    START TRANSACTION;
    INSERT INTO users_old (firstname, lastname, email) 
      SELECT firstname, lastname, email 
      FROM users 
      WHERE users.id = searched;
    DELETE FROM users WHERE id = searched;
    IF ROW_COUNT() = 1 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END //
DELIMITER ;

-- вызываем процедуру перемещения пользователя
CALL move(3);

/*
Создайте функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 с 18:00 до 00:00 — "Добрый вечер", 
 с 00:00 до 6:00 — "Доброй ночи".
*/


DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello() RETURNS VARCHAR(50)
BEGIN
  DECLARE time_part TIME;
  SET time_part = TIME(NOW());
  IF time_part >= '06:00:00' AND time_part < '12:00:00' THEN
    RETURN 'Доброе утро';
  ELSEIF time_part >= '12:00:00' AND time_part < '18:00:00' THEN
    RETURN 'Добрый день';
  ELSEIF time_part >= '18:00:00' AND time_part < '00:00:00' THEN
    RETURN 'Добрый вечер';
  ELSE
    RETURN 'Доброй ночи';
  END IF;
END //
DELIMITER ;

-- вызываем функцию для вывода приветствия
SELECT hello();