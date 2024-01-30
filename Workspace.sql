-- Create a procedure to insert a new donor
CREATE OR REPLACE PROCEDURE insert_new_donor(
    p_idDonor IN NUMBER,
    p_Firstname IN VARCHAR2,
    p_Lastname IN VARCHAR2,
    p_Typecode IN CHAR,
    p_Street IN VARCHAR2,
    p_City IN VARCHAR2,
    p_State IN CHAR,
    p_Zip IN VARCHAR2,
    p_Phone IN VARCHAR2,
    p_Fax IN VARCHAR2,
    p_Email IN VARCHAR2,
    p_News IN CHAR,
    p_dtentered IN VARCHAR2
) AS
BEGIN
    INSERT INTO dd_donor VALUES (
        p_idDonor, p_Firstname, p_Lastname, p_Typecode, p_Street,
        p_City, p_State, p_Zip, p_Phone, p_Fax, p_Email, p_News, p_dtentered
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Donor inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting donor: ' || SQLERRM);
END insert_new_donor;
/

-- Create a procedure to update donor information
CREATE OR REPLACE PROCEDURE update_donor_info(
    p_idDonor IN NUMBER,
    p_Phone IN VARCHAR2,
    p_Fax IN VARCHAR2,
    p_Email IN VARCHAR2
) AS
BEGIN
    UPDATE dd_donor
    SET Phone = p_Phone,
        Fax = p_Fax,
        Email = p_Email
    WHERE idDonor = p_idDonor;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Donor information updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating donor information: ' || SQLERRM);
END update_donor_info;
/

-- Create a function to display total pledged amount for a project
CREATE OR REPLACE FUNCTION get_total_pledged_amount(
    p_idProj IN NUMBER
) RETURN NUMBER IS
    total_amount NUMBER;
BEGIN
    SELECT SUM(Pledgeamt)
    INTO total_amount
    FROM dd_pledge
    WHERE idProj = p_idProj;

    RETURN total_amount;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error getting total pledged amount: ' || SQLERRM);
        RETURN NULL;
END get_total_pledged_amount;
/

-- Example usage:

-- Insert a new donor
EXEC insert_new_donor(311, 'John', 'Doe', 'I', '123 Main St.', 'City', 'VA', '12345', '1234567890', NULL, 'john.doe@email.com', 'Y', '01-JAN-2023');

-- Update donor information
EXEC update_donor_info(311, '0987654321', NULL, 'john.doe.updated@email.com');

-- Get total pledged amount for a project (replace 500 with the desired project ID)
DECLARE
    total_amount NUMBER;
BEGIN
    total_amount := get_total_pledged_amount(500);
    DBMS_OUTPUT.PUT_LINE('Total Pledged Amount: ' || total_amount);
END;
/
