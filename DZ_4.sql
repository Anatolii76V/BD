CREATE DATABASE IF NOT EXISTS less4;
USE less4;

CREATE TABLE IF NOT EXISTS `shops` (
  `id` INT NOT NULL,
  `shop_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `cats` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cats_shops_id` FOREIGN KEY (`shop_id`)
    REFERENCES `shops` (`id`)
);

INSERT INTO `shops` (`id`, `shop_name`)
VALUES 
  (1, "Четыре лапы"),
  (2, "Мистер Зоо"),
  (3, "МурзиЛЛа"),
  (4, "Кошки и собаки");

INSERT INTO `cats` (`id`, `name`, `shop_id`)
VALUES 
  (1, "Murzik", 1),
  (2, "Nemo", 2),
  (3, "Vicont", 1),
  (4, "Zuza", 3);

-- Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shop_id)
SELECT c.`name`, c.`shop_id`, s.`shop_name`
FROM `shops` s
JOIN `cats` c ON s.`id` = c.`shop_id`;

-- Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
SELECT c.`shop_id`, s.`shop_name`
FROM `shops` s
JOIN `cats` c ON s.`id` = c.`shop_id`
WHERE c.`name` = 'Murzik';

SELECT c.`shop_id`, s.`shop_name`
FROM `shops` s, `cats` c
WHERE s.`id` = c.`shop_id` AND c.`name` = 'Murzik';

-- Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
SELECT c.`name`, s.`shop_name`
FROM `shops` s
LEFT JOIN `cats` c ON s.`id` = c.`shop_id` AND c.`name` IN ('Murzik', 'Zuza')
WHERE c.`id` IS NULL;




------- Последнее задание, таблица:

DROP TABLE IF EXISTS Analysis;

CREATE TABLE Analysis
(
	an_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	an_name varchar(50),
	an_cost INT,
	an_price INT,
	an_group INT
);

INSERT INTO analysis (an_name, an_cost, an_price, an_group)
VALUES 
	('Общий анализ крови', 30, 50, 1),
	('Биохимия крови', 150, 210, 1),
	('Анализ крови на глюкозу', 110, 130, 1),
	('Общий анализ мочи', 25, 40, 2),
	('Общий анализ кала', 35, 50, 2),
	('Общий анализ мочи', 25, 40, 2),
	('Тест на COVID-19', 160, 210, 3);

DROP TABLE IF EXISTS GroupsAn;

CREATE TABLE GroupsAn
(
	gr_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	gr_name varchar(50),
	gr_temp FLOAT(5,1),
	FOREIGN KEY (gr_id) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO groupsan (gr_name, gr_temp)
VALUES 
	('Анализы крови', -12.2),
	('Общие анализы', -20.0),
	('ПЦР-диагностика', -20.5);

SELECT * FROM groupsan;

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
	ord_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ord_datetime DATETIME,	-- 'YYYY-MM-DD hh:mm:ss'
	ord_an INT,
	FOREIGN KEY (ord_an) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Orders (ord_datetime, ord_an)
VALUES 
	('2020-02-04 07:15:25', 1),
	('2020-02-04 07:20:50', 2),
	('2020-02-04 07:30:04', 1),
	('2020-02-04 07:40:57', 1),
	('2020-02-05 07:05:14', 1),
	('2020-02-05 07:15:15', 3),
	('2020-02-05 07:30:49', 3),
	('2020-02-06 07:10:10', 2),
	('2020-02-06 07:20:38', 2),
	('2020-02-07 07:05:09', 1),
	('2020-02-07 07:10:54', 1),
	('2020-02-07 07:15:25', 1),
	('2020-02-08 07:05:44', 1),
	('2020-02-08 07:10:39', 2),
	('2020-02-08 07:20:36', 1),
	('2020-02-08 07:25:26', 3),
	('2020-02-09 07:05:06', 1),
	('2020-02-09 07:10:34', 1),
	('2020-02-09 07:20:19', 2),
	('2020-02-10 07:05:55', 3),
	('2020-02-10 07:15:08', 3),
	('2020-02-10 07:25:07', 1),
	('2020-02-11 07:05:33', 1),
	('2020-02-11 07:10:32', 2),
	('2020-02-11 07:20:17', 3),
	('2020-02-12 07:05:36', 1),
	('2020-02-12 07:10:54', 2),
	('2020-02-12 07:20:19', 3),
	('2020-02-12 07:35:38', 1);

-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
SELECT a.an_name, a.an_price
FROM Analysis a
JOIN Orders o ON a.an_id = o.ord_an
WHERE o.ord_datetime >= '2020-02-05 00:00:00' AND o.ord_datetime < '2020-02-13 00:00:00';
