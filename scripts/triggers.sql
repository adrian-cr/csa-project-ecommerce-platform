--Automatically update the order status from "awaiting payment" to "processing" as soon as a payment for the order is inserted:
CREATE TRIGGER update_order_status
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE orders
    SET order_status = 'processing'
    WHERE id = NEW.order_id;
END;

--Trigger to generate a report on the most active users once there have been 1000 queries of any type:
CREATE TRIGGER generate_user_report
AFTER


CREATE TRIGGER generate_user_report
AFTER INSERT ON user_activity
FOR EACH ROW
BEGIN
    INSERT INTO user_reports (user_id, activity_type, activity_date)
    VALUES (NEW.user_id, NEW.activity_type, CURRENT_DATE());
END;
--Trigger to log changes to product prices
