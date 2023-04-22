USE DZ_3;

CREATE TABLE IF NOT EXISTS worker
(
  id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(40),
    lastname VARCHAR(40),
    post  VARCHAR(40),
    senioriity INT,
    salary INT,
    age INT
);

INSERT INTO worker (firstname, lastname, post, senioriity, salary,age)
VALUES
  ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
  ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
  ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
  ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
  ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
  ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
  ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
  ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
  ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
  ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
  ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
  ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

-- 1. Отсортируйте данные по полю заработная плата (salary) в порядке убывания

SELECT *
FROM worker
ORDER BY salary DESC;

-- 2. Отсортируйте данные по полю заработная плата (salary) в порядке возрастания

SELECT *
FROM worker
ORDER BY salary;

-- 3. Выведите 5 максимальных заработных плат (saraly)

SELECT *
FROM worker
ORDER BY salary DESC
LIMIT 5;

-- 4. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)

SELECT 
  post,
  SUM(salary) AS "Суммарная ЗП сотрудников"
FROM worker
GROUP BY post;

-- 5. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.

SELECT 
  COUNT(*) AS "Количество сотрудников"
FROM worker
WHERE post = "Рабочий" AND age BETWEEN 24 AND 49;

-- 6. Найдите количество уникальных специальностей

SELECT COUNT(DISTINCT post) AS "Количество уникальных специальностей"
FROM worker;

-- 7. Выведите специальности, у которых средний возраст сотрудников меньше 40 лет 

SELECT post
FROM worker
GROUP BY post
HAVING AVG(age) < 40;
 