DROP DATABASE IF EXISTS `shop`;
CREATE DATABASE IF NOT EXISTS `shop`;

USE shop;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  `surname` VARCHAR(32) NOT NULL,
  `date_created` DATETIME NOT NULL,
  `date_last_login` DATETIME NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `admin` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`));
  
  INSERT INTO `user` (
  `name`,
  `surname`,
  `date_created`,
  `date_last_login`,
  `password`,
  `email`,
  `admin`) VALUES
  ('Bruno', 'Marciniak', '2020-11-19 16:48', '2020-11-20 20:00', 'bmarc153', 'bruno.marciniak@gmail.pl', 0),
  ('Eustachy', 'Kalinowski', '2000-05-12 08:21', '2020-09-14 18:23', 'wentoL2', 'estach@gmail.com', 1),
  ('Adrian', 'Andrzejewski', '2014-10-01 21:43', '2018-01-01 02:15', 'aapsik$42', 'aapsik@wp.pl', 0),
  ('Martin', 'Dąbrowski', '2004-02-21 11:35', '2019-06-24 22:43', 'fend42@', 'kolo28@wp.pl', 0),
  ('Radosław', 'Sikora', '2020-09-01 12:05', '2021-01-05 02:02', 'radsik25@', 'radsik@shop.pl', 1),
  ('Grzegorz', 'Sokołowski', '2019-01-22 15:04', '2020-05-12 15:23', 'gsok!.', 'gsikor@o2.pl', 0),
  ('Bruno', 'Zieliński', '2016-04-15 05:43', '2018-09-03 20:12', 'bziel2!.', 'bziel@gmail.com', 0),
  ('Jan', 'Pietrzak', '2006-12-24 21:32', '2020-11-11 11:55', 'janpiet5.a', 'jpiet@gmail.com', 0),
  ('Mariusz', 'Malinowski', '2014-02-16 04:42', '2021-01-04 13:51', 'mmali_2', 'mmali@gmail.com', 0),
  ('Bogumił', 'Andrzejewski', '2002-11-02 14:25', '2021-01-02 02:01', 'bog_and2;', 'band@gmail.com', 0);

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
    
INSERT INTO `category` (
  `id`,
  `name`) VALUES
  (1, 'Gry'),
  (2, 'Laptopy'),
  (3, 'Telewizory'),
  (4, 'Monitory'),
  (5, 'Smartfony');


CREATE TABLE IF NOT EXISTS `product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `amount` INT NOT NULL,
  `date_created` DATETIME NOT NULL,
  `date_updated` DATETIME NULL,
  `discount` FLOAT NOT NULL DEFAULT FALSE,
  `discount_price` DECIMAL NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`));
  
INSERT INTO `product` (
   `id`,
  `name`,
  `price`,
  `amount`,
  `date_created`,
  `discount`,
  `discount_price`,
  `category_id`) VALUES
  (1,
  'Cyberpunk 2077',
  '219.00',
  999,
  '2020-12-11 01:00',
  false,
  NULL,
  1),
  (2,
  'GRID 2',
  '145.00',
  824,
  '2018-04-25 21:35',
  true,
  '14.00',
  1),
  (3,
  'Dell Inspiron 5400 i5-1035G1',
  '3899.00',
  53,
  '2011-04-03 16:23',
  false,
  NULL,
  2),
  (4,
  'Xiaomi Redmi Note 8 PRO 6/64GB Mineral Grey',
  '1099.00',
  99,
  '2019-02-21 02:13',
  true,
  '352.00',
  5),
  (5,
  'Xiaomi Mi LED TV 4S 55"',
  '1799.00',
  99,
  '2019-02-21 02:13',
  false,
  NULL,
  3),
  (6,
  'Acer Nitro VG240YBMIIX',
  '599.00',
  99,
  '2019-02-21 02:14',
  false,
  NULL,
  4),
  (7,
  'Dell S2721DGF nanoIPS HDR',
  '1949.00',
  55,
  '2019-02-21 02:15',
  false,
  NULL,
  4),
  (8,
  'Microsoft Surface Pro 7 i5/8GB/128/Win10',
  '4799.00',
  66,
  '2018-11-11 02:15',
  false,
  NULL,
  2),
  (9,
  'PC GTA 5',
  '57.00',
  888,
  '2014-01-12 12:55',
  false,
  NULL,
  1),
  (10,
  'PC Assetto Corsa',
  '34.00',
  999,
  '2014-01-12 12:55',
  false,
  NULL,
  1);
  
CREATE TABLE IF NOT EXISTS `user_basket` (
  `product_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `amount` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`product_id`, `user_id`),
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`),
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`));

INSERT INTO `user_basket` (
  `product_id`,
  `user_id`,
  `amount`) VALUES
  (2, 4, 1),
  (3, 4, 2),
  (1, 4, 3),
  (7, 10, 1),
  (10, 6, 2),
  (8, 5, 1),
  (7, 2, 1),
  (4, 6, 2);

CREATE TABLE IF NOT EXISTS `order_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
  INSERT INTO `order_status` (
  `name`
  ) VALUES
  ('Nowe'),
  ('W realizacji'),
  ('Zakończone');

CREATE TABLE IF NOT EXISTS `delivery_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `price` DECIMAL NOT NULL,
  PRIMARY KEY (`id`));
  
INSERT INTO `delivery_type` (
  `id`,
  `name`,
  `price`) VALUES
  (1, "Odbiór osobisty", '0.00'),
  (2, "Kurier DPS", '18.00'),
  (3, "Paczkomat InPost", '9.00');

CREATE TABLE IF NOT EXISTS `order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `order_status_id` INT NOT NULL,
  `delivery_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`),
    FOREIGN KEY (`order_status_id`)
    REFERENCES `order_status` (`id`),
    FOREIGN KEY (`delivery_type_id`)
    REFERENCES `delivery_type` (`id`));
    
INSERT INTO `order` (
  `id`,
  `user_id`,
  `order_status_id`,
  `delivery_type_id`) VALUES
  (1, 3, 2, 1),
  (2, 2, 1, 2),
  (3, 2, 2, 3),
  (4, 5, 3, 2),
  (5, 8, 2, 3),
  (6, 4, 3, 1);

CREATE TABLE IF NOT EXISTS `order_product` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `amount` INT NOT NULL,
    FOREIGN KEY (`order_id`)
    REFERENCES `order` (`id`),
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`));
    
INSERT INTO `order_product` (
  `order_id`,
  `product_id`,
  `amount`) VALUES
  (1, 2, 5),
  (1, 3, 1),
  (2, 1, 4),
  (2, 3, 2),
  (3, 3, 1),
  (4, 5, 2),
  (5, 7, 1),
  (6, 9, 2),
  (4, 2, 1),
  (5, 2, 1),
  (6, 4, 2),
  (5, 6, 1),
  (1, 8, 2),
  (2, 10, 1);