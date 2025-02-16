-- Trigger to monitor inventory level
DELIMITER $$

CREATE TRIGGER check_inventory_level
AFTER INSERT ON ord_invoice
FOR EACH ROW
BEGIN
    DECLARE inventory_count INT;
    DECLARE product_name VARCHAR(100);
    
    -- Get the current inventory count for the product
    SELECT quantity INTO inventory_count
    FROM product
    WHERE prod_id = NEW.prod_id;
    
    -- Get the product name for notification
    SELECT prod_name INTO product_name
    FROM product
    WHERE prod_id = NEW.prod_id;
    
    -- Check if the inventory level is below threshold
    IF inventory_count < 10 THEN
        -- Send notification email to the manager
        INSERT INTO notification (message) 
        VALUES (CONCAT('Inventory level for product ', product_name, ' is below threshold.'));
    END IF;
END$$

DELIMITER ;

-- Trigger for customer analysis
DELIMITER $$

CREATE TRIGGER update_avg_rating
AFTER INSERT ON review
FOR EACH ROW
BEGIN
    DECLARE avg_rating DECIMAL(3,2);
    DECLARE category_id INT;
    
    -- Get the category ID of the reviewed product
    SELECT category_id INTO category_id
    FROM product
    WHERE prod_id = NEW.prod_id;
    
    -- Calculate the average rating for the category
    SELECT AVG(star) INTO avg_rating
    FROM review
    WHERE prod_id IN (SELECT prod_id FROM product WHERE category_id = category_id);
    
    -- Update the average rating for the category
    UPDATE category
    SET avg_rating = avg_rating
    WHERE category_id = category_id;
END$$

DELIMITER ;