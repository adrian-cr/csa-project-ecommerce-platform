-- Automatically update the order status from "awaiting payment" to "processing" as soon as a payment for the order is inserted:
CREATE TRIGGER update_order_status
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE orders
    SET order_status = 'processing'
    WHERE id = NEW.order_id;
END;

-- Triggers to generate a report on the most active users once there have been 1000 changes to users, products, or orders (uses UserActivity table):
/* USERS: */
CREATE TRIGGER log_activity_usr_create
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('user', NEW.user_id, 'create', CURRENT_DATE());
END;

CREATE TRIGGER log_activity_usr_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('user', NEW.user_id, 'update', CURRENT_DATE());
END;

CREATE TRIGGER log_activity_usr_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('user', NEW.user_id, 'delete', CURRENT_DATE());
END;

/* PROUCTS: */
CREATE TRIGGER log_activity_prod_create
AFTER INSERT ON Product
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('product', NEW.product_id, 'create', CURRENT_DATE());
END;

CREATE TRIGGER log_activity_prod_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('product', NEW.product_id, 'update', CURRENT_DATE());
END;

CREATE TRIGGER log_activity_prod_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('product', NEW.product_id, 'delete', CURRENT_DATE());
END;

/* ORDERS: */
CREATE TRIGGER log_activity_ord_create
AFTER INSERT ON Product
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('order', NEW.order_id, 'create', CURRENT_DATE());
END;

CREATE TRIGGER log_activity_ord_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('order', NEW.order_id, 'update', CURRENT_DATE());
END;

CREATE TRIGGER log_activity_ord_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO UserActivity (entity_type, entity_id, activity_type, activity_date)
    VALUES ('order', NEW.order_id, 'delete', CURRENT_DATE());
END;
