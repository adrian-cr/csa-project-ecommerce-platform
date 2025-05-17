DELIMITER $$

-- Automatically update the order status from "awaiting payment" to "processing" as soon as a payment for the order is inserted:
CREATE TRIGGER update_order_status
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE orders
    SET order_status = 'processing'
    WHERE id = NEW.order_id;
END$$

-- Log activity for Users, Products, and Orders:
/* USERS: */
CREATE TRIGGER log_activity_usr_create
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('user', NEW.user_id, 'create', CURRENT_DATE());
END$$

CREATE TRIGGER log_activity_usr_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('user', NEW.user_id, 'update', CURRENT_DATE());
END$$

CREATE TRIGGER log_activity_usr_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('user', NEW.user_id, 'delete', CURRENT_DATE());
END$$

/* PROUCTS: */
CREATE TRIGGER log_activity_prod_create
AFTER INSERT ON Product
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('product', NEW.product_id, 'create', CURRENT_DATE());
END$$

CREATE TRIGGER log_activity_prod_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('product', NEW.product_id, 'update', CURRENT_DATE());
END$$

CREATE TRIGGER log_activity_prod_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('product', NEW.product_id, 'delete', CURRENT_DATE());
END$$

/* ORDERS: */
CREATE TRIGGER log_activity_ord_create
AFTER INSERT ON Product
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('order', NEW.order_id, 'create', CURRENT_DATE());
END$$

CREATE TRIGGER log_activity_ord_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('order', NEW.order_id, 'update', CURRENT_DATE());
END$$

CREATE TRIGGER log_activity_ord_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO SiteActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('order', NEW.order_id, 'delete', CURRENT_DATE());
END$$

-- Create a materialized view with the most active users once there have been 1000 changes to users, products, or orders (uses SiteActivity table):
-- Procedure:
CREATE PROCEDURE generate_1000_interaction_report()
BEGIN
   IF (SELECT COUNT(*) FROM SiteActivity) >= 1000 THEN
       -- Generate a dynamic name for the report
       SET @report_name = CONCAT('most_active_users_', DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s'));
       -- Create the materialized view with the dynamic name
       SET @sql = CONCAT('CREATE OR REPLACE VIEW ', @report_name, 'CREATE MATERIALIZED VIEW MostActiveUsers AS SELECT entity_id AS "ID", COUNT(*) AS "Activity Count" FROM SiteActivity WHERE entity_type = ''user'' GROUP BY 1 ORDER BY 2 DESC');
       PREPARE stmt FROM @sql;
       EXECUTE stmt;
       DEALLOCATE PREPARE stmt;
   END IF;
END$$

-- Trigger:
CREATE TRIGGER report_most_active_users
AFTER INSERT ON SiteActivity
FOR EACH ROW
BEGIN
   CALL generate_1000_interaction_report();
END$$
