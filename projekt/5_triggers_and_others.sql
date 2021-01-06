SET GLOBAL log_bin_trust_function_creators = 1;

DROP TRIGGER IF EXISTS `product_date_updated`;
DROP TRIGGER IF EXISTS `check_order_product_amount`;
DROP PROCEDURE IF EXISTS `add_product_to_basket`;
DROP FUNCTION IF EXISTS `get_register_user_count`;

# Zmiana daty aktualizacji produktu
DELIMITER $$
CREATE TRIGGER
`product_date_updated`
BEFORE UPDATE ON `product`
FOR EACH ROW
BEGIN
SET new.`date_updated` = CURRENT_DATE();
END$$;


# Sprawdzenie czy ilość produktu nie jest na minusie
DELIMITER $$
CREATE TRIGGER
`check_order_product_amount`
BEFORE INSERT ON `order_product`
FOR EACH ROW
BEGIN
IF new.`amount` < 0 THEN
signal sqlstate '45000'
SET message_text = 'Ilość nie może być na minusie.';
END IF;
END$$

# Procedura na dodanie produktu do koszyka użytkownika.
DELIMITER $$
CREATE PROCEDURE
add_product_to_basket(
	user_id int,
	product_id int,
    amount int
)
BEGIN
DECLARE CORRENT_AMOUNT bool;
DECLARE EXIST_USER_AND_PRODUCT bool;
SET CORRENT_AMOUNT = true;


IF amount < 0 THEN
	SET CORRENT_AMOUNT = false;
END IF;

SET EXIST_USER_AND_PRODUCT = (SELECT COUNT(*) FROM `user` WHERE `id` = user_id) AND (SELECT COUNT(*) FROM `product` WHERE `id` = product_id);

IF CORRENT_AMOUNT AND EXIST_USER_AND_PRODUCT THEN
	INSERT INTO `user_basket` VALUES (product_id, user_id, amount);
END IF;
END$$

# CALL add_product_to_basket(2, 2, 1);

# Funkcja na wyświetlenie ilości zarejestrowanych osób w danym roku. x - rok
DELIMITER $$
CREATE FUNCTION
get_register_user_count(x int)
RETURNS INT
BEGIN
SELECT
COUNT(*)
FROM `user`
WHERE YEAR(`date_created`) = x INTO x;
RETURN x;
END$$

# SELECT get_register_user_count(2020);