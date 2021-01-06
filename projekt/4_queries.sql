DROP VIEW IF EXISTS `zapytanie1`;
DROP VIEW IF EXISTS `zapytanie2`;
DROP VIEW IF EXISTS `zapytanie3`;
DROP VIEW IF EXISTS `zapytanie4`;
DROP VIEW IF EXISTS `zapytanie5`;
DROP VIEW IF EXISTS `zapytanie6`;
DROP VIEW IF EXISTS `zapytanie7`;
DROP VIEW IF EXISTS `zapytanie8`;
DROP VIEW IF EXISTS `zapytanie9`;
DROP VIEW IF EXISTS `zapytanie10`;

# 1 Wyświetlenie produktów z koszyka użytkownika o id 4 zawierających nazwe, cenę za szt, ilość w koszyku oraz nazwe kategorii.
CREATE VIEW
`zapytanie1` AS
SELECT
p.`name` as "Nazwa",
p.`price` as "Cena za szt.",
ub.`amount` as "Ilość",
c.`name` as "Nazwa kategorii"
FROM `user_basket` as ub
LEFT OUTER JOIN `product` as p ON p.`id` = ub.`product_id`
INNER JOIN `category` as c ON c.`id` = p.`category_id`
WHERE ub.`user_id` = 4;
# SELECT * FROM zapytanie1;

# 2 Pobranie produktu z największą przeceną
CREATE VIEW
`zapytanie2` AS
SELECT 
*,
(`price` - `discount_price`) as `new_price`
FROM `product`
WHERE
`discount` = true
ORDER BY `discount_price` DESC
LIMIT 1;
# SELECT * FROM zapytanie2; 

#3 Wyświetlenie nazwy, ceny oraz ilości produktów z zamówienia o id 3
CREATE VIEW
`zapytanie3` AS
SELECT
p.`name` as "Nazwa produktu",
p.`price` as "Cena bez obniżki",
op.`amount` as "Ilość"
FROM `order_product` op
JOIN `product` p ON p.`id` = `product_id` 
WHERE `order_id` = 3;
# SELECT * FROM zapytanie3; 

#4 Wyszukanie produktów z kategorii Gry, których nazwa zawiera w sobie literę 'u', posortowane malejąco po "name"
CREATE VIEW
`zapytanie4` AS
SELECT
p.*
FROM `product` p
JOIN `category` c ON c.`id` = p.`category_id`
WHERE p.`name` LIKE '%u%' AND c.`name` = 'Gry' ORDER BY `name` DESC;
# SELECT * FROM zapytanie4; 

#5 Wypisać produkty których cena(nie wliczając obniżki) jest większa od średniej ceny wszystkich produktów
CREATE VIEW
`zapytanie5` AS
SELECT
*
FROM `product`
WHERE `price` > (SELECT AVG(`price`) FROM `product`);
# SELECT * FROM zapytanie5; 

#6 Obliczyć wydatki użytkowników w sklepie (uwzględniając obniżke ceny), nie wliczając statusu "Nowe"
CREATE VIEW
`zapytanie6` AS
SELECT
u.`name` AS "Imie",
u.`surname` AS "Nazwisko",
IFNULL(
CASE
	WHEN NOT discount THEN SUM(p.`price` * op.`amount`)
    ELSE SUM((p.`price` - p.`discount_price`) * op.`amount`)
END, 0) AS "Wydatki"
FROM `user` u
LEFT JOIN `order` o ON o.`user_id` = u.`id` AND o.`order_status_id` IN (SELECT `id` FROM `order_status` WHERE NOT (`name` = 'Nowe'))
LEFT JOIN `order_product` op ON op.`order_id` = o.`id`
LEFT JOIN `product` p ON p.`id` = op.`product_id`
GROUP BY u.`id`;
# SELECT * FROM zapytanie6; 

#7 Wyświetlić liczbę produktów, grupując po kategorii
CREATE VIEW
`zapytanie7` AS
SELECT
c.`name` as "Nazwa",
COUNT(p.`id`) as "Liczba produktów"
FROM `category` c
LEFT JOIN `product` p ON p.`category_id` = c.`id` GROUP BY c.`Name`;
# SELECT * FROM zapytanie7; 

#8 Wyświetlić użytkowników, których konto zostało utworzone pomiędzy 2018 a 2020 roku oraz nie są administratorami.
CREATE VIEW
`zapytanie8` AS
SELECT
*
FROM `user`
WHERE `admin` = false AND Year(`date_created`) BETWEEN 2018 AND 2020;
# SELECT * FROM zapytanie8; 

#9 Wyświetlić zamówienia użytkownika o imieniu i nazwisku Martin Dąbrowski, w których jako rodzaj dostawy został wybrany "Odbiór osobisty" - kolumna id zamówienia, status zamówienia oraz rodzaj dostawy
CREATE VIEW
`zapytanie9` AS
SELECT
o.`id` as "ID zamówienia",
os.`name` as "Status zamówienia",
dt.`name` as "Rodzaj dostawy"
FROM `order` o
LEFT JOIN `delivery_type` dt ON dt.`id` = o.`delivery_type_id`
LEFT JOIN `user` u ON u.`id` = o.`user_id`
LEFT JOIN `order_status` os ON os.`id` = o.`order_status_id`
WHERE u.`name` = "Martin" AND u.`surname` = "Dąbrowski" AND dt.`name` = "Odbiór osobisty";
# SELECT * FROM zapytanie9;

#10 Wyświetlić nazwy wszystkich możliwych typów dostaw w sklepie, posortowane po nazwie malejąco
CREATE VIEW
`zapytanie10` AS
SELECT
`name` as "Rodzaj dostawy"
FROM `delivery_type` ORDER BY `name` DESC;
# SELECT * FROM zapytanie10;