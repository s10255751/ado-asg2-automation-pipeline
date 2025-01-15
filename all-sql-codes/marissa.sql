--DATA CLEANING
-- CUSTOMER MEMBERSHIP
CREATE TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP (
    CUSTMEMID NUMBER(38,0) NOT NULL,
    CUSTOMERNUMBER NUMBER(38,0) NOT NULL,
    MEMBERSHIPID NUMBER(38,0) NOT NULL,
    STARTDATE VARCHAR(20) NOT NULL,
    ENDDATE VARCHAR(20) NOT NULL,
    EMPLOYEENUMBER NUMBER(38,0) NOT NULL,
    STATUS VARCHAR(20) NOT NULL
);

-- CUSTOMER MEMBERSHIP
ALTER TABLE COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP
ADD CONSTRAINT PK_CustMem PRIMARY KEY (custmemID);

-- CUSTOMER MEMBERSHIP
ALTER TABLE COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP  
ADD CONSTRAINT FK_customernumber FOREIGN KEY (customerNumber) 
REFERENCES COLLECTIBLE_DIECAST.CUSTOMERS(customerNumber);

ALTER TABLE COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP
ADD CONSTRAINT FK_membership FOREIGN KEY (membershipID) 
REFERENCES COLLECTIBLE_DIECAST.MEMBERSHIP(membershipID);

ALTER TABLE COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP
ADD CONSTRAINT FK_employee FOREIGN KEY (employeeNumber) 
REFERENCES COLLECTIBLE_DIECAST.EMPLOYEES(employeeNumber);

-- CUSTOMER MEMBERSHIP
CREATE OR REPLACE TABLE COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP AS
SELECT 
    CUSTMEMID,
    CUSTOMERNUMBER,
    MEMBERSHIPID,
    TO_DATE(STARTDATE, 'DD/MM/YYYY') AS STARTDATE,
    TO_DATE(ENDDATE, 'DD/MM/YYYY') AS ENDDATE,    
    EMPLOYEENUMBER,
    STATUS
FROM COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP;

-- MEMBERSHIP
CREATE TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.MEMBERSHIP(
    MEMBERSHIPID NUMBER(38,0) NOT NULL,
    MEMBERSHIPLEVEL VARCHAR(16777216) NOT NULL,
    MEMBERSHIPDESCRIPTION VARCHAR(16777216) NOT NULL,
    CREDITSPENDING NUMBER(38,0) NOT NULL
);

-- MEMBERSHIP
ALTER TABLE COLLECTIBLE_DIECAST.MEMBERSHIP
ADD CONSTRAINT PK_Membership PRIMARY KEY (membershipID);




-- ORDER DETAILS
CREATE TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDER_DETAILS (
	ORDERNUMBER NUMBER(38,0) NOT NULL,
	PRODUCTCODE VARCHAR(16777216) NOT NULL,
	QUANTITYORDERED NUMBER(38,0) NOT NULL,
	PRICEEACH FLOAT NOT NULL,
	ORDERTOTALAMT FLOAT NOT NULL,
	ORDERLINENUMBER NUMBER(38,0) NOT NULL
);

-- ORDER DETAILS
ALTER TABLE COLLECTIBLE_DIECAST.ORDER_DETAILS
ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (orderNumber, productCode);

-- ORDER DETAILS
ALTER TABLE COLLECTIBLE_DIECAST.ORDER_DETAILS  
ADD CONSTRAINT FK_orderDetails FOREIGN KEY (orderNumber) 
REFERENCES COLLECTIBLE_DIECAST.ORDERS(orderNumber);

ALTER TABLE COLLECTIBLE_DIECAST.ORDER_DETAILS
ADD CONSTRAINT FK_products FOREIGN KEY (productCode) 
REFERENCES COLLECTIBLE_DIECAST.PRODUCTS(productCode);

-- REMOVE DUPLICATES
--ORDER DETAILS
CREATE OR REPLACE TABLE COLLECTIBLE_DIECAST.ORDER_DETAILS AS 
SELECT * 
FROM ( 
      SELECT 
          *, 
          ROW_NUMBER() OVER (PARTITION BY ordernumber, productcode ORDER BY ordernumber ASC) AS RN 
      FROM COLLECTIBLE_DIECAST.ORDER_DETAILS
) 
WHERE RN = 1;

-- DROP COLUMN RN
ALTER TABLE COLLECTIBLE_DIECAST.ORDER_DETAILS DROP COLUMN RN;

-- REARRANGE THE TABLE
CREATE OR REPLACE TABLE COLLECTIBLE_DIECAST.ORDER_DETAILS AS 
SELECT * 
FROM COLLECTIBLE_DIECAST.ORDER_DETAILS
ORDER BY ordernumber, orderlinenumber ASC;

-- ORDERS
CREATE TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDERS (
	ORDERNUMBER NUMBER(38,0) NOT NULL,
	ORDERDATE VARCHAR (20) NOT NULL,
	REQUIREDDATE VARCHAR(20) NOT NULL,
	SHIPPEDDATE VARCHAR(20) NULL,
    ARRIVALDATE VARCHAR(20) NULL,
    MODEID NUMBER(38,0)NOT NULL,
	STATUS VARCHAR(16777216) NOT NULL,
	COMMENTS VARCHAR(16777216) NULL,
	CUSTOMERNUMBER NUMBER(38,0) NOT NULL,
	EMPLOYEENUMBER NUMBER(38,0) NOT NULL
);

-- ORDERS
ALTER TABLE COLLECTIBLE_DIECAST.ORDERS 
ADD CONSTRAINT PK_orderNumber PRIMARY KEY (orderNumber);

-- ORDERS
ALTER TABLE COLLECTIBLE_DIECAST.ORDERS  
ADD CONSTRAINT FK_customerNumber FOREIGN KEY (customerNumber) 
REFERENCES COLLECTIBLE_DIECAST.CUSTOMERS(customerNumber);

ALTER TABLE COLLECTIBLE_DIECAST.ORDERS  
ADD CONSTRAINT FK_employeeNumber FOREIGN KEY (employeeNumber) 
REFERENCES COLLECTIBLE_DIECAST.EMPLOYEES(employeeNumber);

ALTER TABLE COLLECTIBLE_DIECAST.ORDERS  
ADD CONSTRAINT FK_modeID FOREIGN KEY (modeID) 
REFERENCES COLLECTIBLE_DIECAST.SHIPMENT_MODE(modeID);

-- REMOVE DUPLICATE
-- ORDER 
CREATE OR REPLACE TABLE COLLECTIBLE_DIECAST.ORDERS AS 
SELECT * 
FROM ( 
      SELECT 
          *, 
          ROW_NUMBER() OVER (PARTITION BY ordernumber ORDER BY ordernumber ASC) AS RN 
      FROM COLLECTIBLE_DIECAST.ORDERS
) 
WHERE RN = 1;

-- DROP COLUMN RN
ALTER TABLE COLLECTIBLE_DIECAST.ORDERS DROP COLUMN RN;

-- REARRANGE THE TABLE
CREATE OR REPLACE TABLE COLLECTIBLE_DIECAST.ORDERS AS 
SELECT * 
FROM COLLECTIBLE_DIECAST.ORDERS
ORDER BY ordernumber ASC;

-- STANDARDIZE DATE FORMATS
-- ORDERS
CREATE OR REPLACE TABLE COLLECTIBLE_DIECAST.ORDERS AS  
SELECT  
    orderNumber,
    TO_DATE(orderDate, 'DD/MM/YYYY') AS orderDate,
    TO_DATE(requireddate, 'DD/MM/YYYY') AS requireddate,
    TO_DATE(shippedDate, 'DD/MM/YYYY') AS shippedDate,
    TO_DATE(arrivaldate, 'DD/MM/YYYY') AS arrivaldate,
    modeID,
    status, 
    comments, 
    customerNumber, 
    employeeNumber
FROM COLLECTIBLE_DIECAST.ORDERS;

--SHIPMENT MODE
CREATE TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.SHIPMENT_MODE(
    MODEID NUMBER(38,0) NOT NULL,
    MODE VARCHAR(16777216) NOT NULL,
    MODEDESCRIPTION VARCHAR(16777216) NOT NULL
);

-- SHIPMENT MODE
ALTER TABLE COLLECTIBLE_DIECAST.SHIPMENT_MODE
ADD CONSTRAINT PK_Mode PRIMARY KEY (modeID);

CREATE TABLE COLLECTIBLE_DIECAST.TIKTOK(
    CAMPAIGN_NAME VARCHAR(100) NOT NULL,
    PRIMARY_STATUS VARCHAR(20) NOT NULL,
    CAMPAIGN_BUDGET NUMBER (38,0) NOT NULL,
    COST NUMBER (38,0) NOT NULL,
    CPC NUMBER(38,0) NOT NULL,
    CPM NUMBER(38,0) NOT NULL,
    IMPRESSION NUMBER (38,0) NOT NULL,
    CLICK NUMBER (38,0) NOT NULL,
    CTR NUMBER(38,0) NOT NULL,
    CONVERSIONS NUMBER (38,0) NOT NULL,
    CPA NUMBER(38,0) NOT NULL,
    CVR NUMBER(38,0) NOT NULL,
    RESULTS NUMBER (38,0) NOT NULL,
    COST_PER_RESULTS NUMBER(38,0) NOT NULL, 
    RESULTS_RATE NUMBER(38,0) NOT NULL
);

-- UPDATE TIKTOK PERCENTAGE
UPDATE TIKTOK
SET CTR=CTR*100;

UPDATE TIKTOK
SET CVR=CVR*100;

UPDATE TIKTOK 
SET RESULTS_RATE = RESULTS_RATE*100;

SELECT * FROM TIKTOK

CREATE TABLE COLLECTIBLE_DIECAST.TARGET(
    REVENUE NUMBER(38,0), --500000
    MEMBERSHIP_SIGNUP NUMBER(38,0), --200
    QUANTITY_SOLD NUMBER(38,0), --150000
    ORDER_COUNT NUMBER(38,0) --500
);

INSERT INTO COLLECTIBLE_DIECAST.TARGET VALUES (500000, 200, 150000,500);
-- VENDORS
CREATE TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.VENDORS (
	VENDORID VARCHAR(16777216) NOT NULL,
	PRODUCTVENDOR VARCHAR(16777216) NOT NULL,
	CONTACTNAME VARCHAR(16777216) NOT NULL,
	ADDRESS1 VARCHAR(16777216) NOT NULL,
	ADDRESS2 VARCHAR(16777216),
	CITY VARCHAR(16777216) NOT NULL,
	STATE VARCHAR(16777216) NOT NULL,
	POSTALCODE VARCHAR(16777216) NOT NULL,
	COUNTRY VARCHAR(16777216) NOT NULL,
	PHONE VARCHAR(16777216) NOT NULL
);

-- VENDORS
ALTER TABLE COLLECTIBLE_DIECAST.VENDORS
ADD CONSTRAINT PK_Vendors PRIMARY KEY (vendorID);

-- STANDARDIZE PHONE NUMBERS
CREATE OR REPLACE TABLE COLLECTIBLE_DIECAST.VENDORS AS  
SELECT  
    	VENDORID,
    	PRODUCTVENDOR,
    	CONTACTNAME,
    	ADDRESS1,
    	ADDRESS2,
    	CITY,
    	STATE,
    	POSTALCODE,
    	COUNTRY,
        REGEXP_REPLACE(PHONE, '[^0-9]', '') AS PHONE
FROM COLLECTIBLE_DIECAST.VENDORS;
--CREATE ROLE
CREATE ROLE "Marketing";
CREATE ROLE "Sales";
CREATE ROLE "Human Resource";
CREATE ROLE "Operations";
CREATE ROLE "Research and Development";
CREATE ROLE "Finance";
CREATE ROLE "Customer Service";


--FALCON - Dexter 
--FERRET - Dylon 
--FINCH - Henry 
--FLAMINGO - Marissa 
--FOX - Jia Xuan 

--GRANT ROLE
GRANT ROLE "Marketing" TO USER FOX;
GRANT ROLE "Sales" TO USER FOX;

GRANT ROLE "Operations" TO USER FERRET;
GRANT ROLE "Research and Development" TO USER FERRET;

GRANT ROLE "Human Resource" TO USER FINCH;
GRANT ROLE "Finance" TO USER FINCH;

GRANT ROLE "Sales" TO USER FALCON;
GRANT ROLE "Customer Service" TO USER FALCON;

GRANT ROLE "Customer Service" TO USER FLAMINGO;
GRANT ROLE "Operations" TO USER FLAMINGO;

SHOW TABLE GRANTS ON USER FOX


-- GRANT TABLE TO ROLE
-- MARKETING
GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.FACEBOOK_ADS TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.FACEBOOK_INSIGHTS TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.FACEBOOK_POST TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.GOOGLE_ACQUISITION TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.GOOGLE_ADS TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.GOOGLE_AUDIENCE TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.GOOGLE_BEHAVIORAL TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.INSTAGRAM_POST TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.INSTAGRAM_STORY TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TIKTOK TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TARGET TO ROLE "Marketing";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.COMPETITORS TO ROLE "Marketing";


--SALES 
GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDERS TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDER_DETAILS TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.SHIPMENT_MODE TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCTS TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCT_LINES TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.VENDORS TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.COUNTRY TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.REGION TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMERS TO ROLE "Sales";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TARGET TO ROLE "Sales";


--OPERATIONS
GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDERS TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDER_DETAILS TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.COUNTRY TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PAYMENTS TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TARGET TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMERS TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.MEMBERSHIP TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCT_LINES TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCTS TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.REGION TO ROLE "Operations";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ECOMMERCE_PLATFORMS TO ROLE "Operations";


--R&D
GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDERS TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDER_DETAILS TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCTS TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCT_LINES TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCT_REVIEWS TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMERS TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.REGION TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TARGET TO ROLE "Research and Development";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.COMPETITORS TO ROLE "Research and Development";

--HR
GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMER_SEGMENTS TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMERS TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.EMPLOYEES TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.OFFICES TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.OFFICE_DETAILS TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TARGET TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.REGION TO ROLE "Human Resource";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.COUNTRY TO ROLE "Human Resource";

--FINANCE
GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.REGION TO ROLE "Finance";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TARGET TO ROLE "Finance";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCT_LINES TO ROLE "Finance";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDERS TO ROLE "Finance";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDER_DETAILS TO ROLE "Finance";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCTS TO ROLE "Finance";

--CS
GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCTS TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCT_LINES TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.PRODUCT_REVIEWS TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDERS TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.ORDER_DETAILS TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.SHIPMENT_MODE TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.TARGET TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMER_MEMBERSHIP TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMER_SEGMENTS TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.CUSTOMERS TO ROLE "Customer Service";

GRANT ALL PRIVILEGES ON TABLE ADO_GROUP3_DB.COLLECTIBLE_DIECAST.VENDORS TO ROLE "Customer Service";
 
--USER STORY 3.4
-- Popularity per Country based on memebrship
CREATE OR ALTER VIEW MARKETRATE
AS
    SELECT cm.membershipid, r.regiondescription,c.country, COUNT(o.ordernumber) AS "Count of Order per Country"
    FROM 
        COUNTRY c
    INNER JOIN CUSTOMERS cust ON cust.country = c.country
    INNER JOIN ORDERS o ON o.customernumber = cust.customernumber
    INNER JOIN CUSTOMER_MEMBERSHIP cm ON cm.customernumber = cust.customernumber
    INNER JOIN REGION r on r.regionid = c.regionid
    GROUP BY r.regiondescription, c.country, cm.membershipid;

SELECT * 
FROM MARKETRATE
WHERE MEMBERSHIPID = 3005
ORDER BY "Count of Order per Country" DESC;


-- Top Product Offering
CREATE OR ALTER VIEW ProductPopularity
AS
    SELECT od.productcode, cust_mem.membershipid, p.productline, SUM(od.QUANTITYORDERED) AS "Sum of Product Code"
    FROM ORDERS o
    INNER JOIN CUSTOMERS cust on cust.customernumber = o.customernumber
    INNER JOIN ORDER_DETAILS od on od.ordernumber = o.ordernumber
    INNER JOIN CUSTOMER_MEMBERSHIP cust_mem on cust_mem.customernumber = o.customernumber
    INNER JOIN PRODUCTS p on od.productcode = p.productcode
    GROUP BY cust_mem.membershipid, od.productcode, p.productline;

SELECT *
FROM PRODUCTPOPULARITY
WHERE MEMBERSHIPID = 3001

-- Rate of Purchase by Member
CREATE OR ALTER VIEW PurchaseRate
AS
    SELECT MONTH(o.ORDERDATE) AS "Month", cm.membershipid, COUNT(o.ORDERNUMBER) AS "Count of Order", SUM(od.ordertotalamt) AS "Gross Profit"
    FROM ORDERS o
    INNER JOIN CUSTOMERS c on c.customernumber = o.customernumber
    INNER JOIN CUSTOMER_MEMBERSHIP cm on cm.customernumber = cm.customernumber
    INNER JOIN ORDER_DETAILS od on od.ordernumber = o.ordernumber
    GROUP BY cm.membershipid, MONTH(o.orderdate);

SELECT *
FROM PurchaseRate
WHERE membershipid = 3001
ORDER BY "Month" ASC

-- Review Product Reviews
CREATE OR ALTER VIEW ProductReview
AS
    SELECT p.PRODUCTLINE, pr.PRODUCTCODE, MAX(pr.RATING) AS "Max Rating", MIN(pr.RATING) AS "Min Rating", AVG(pr.RATING) AS "Average Rating", COUNT(pr.RATING) AS "Count Rating"
    FROM PRODUCT_REVIEWS pr
    INNER JOIN PRODUCTS p on p.productcode = pr.productcode
    GROUP BY p.PRODUCTLINE, pr.PRODUCTCODE;

SELECT * 
FROM ProductReview
ORDER BY "Average Rating" DESC;

-- Inactive Members & their product review if there is
CREATE OR ALTER VIEW InactiveMember
AS
    SELECT cm.CUSTOMERNUMBER, 
           cust.CUSTOMERNAME, 
           cust.COUNTRY, 
           r.regiondescription, 
           cm.STATUS, 
           pr.PRODUCTCODE,
           pr.RATING, 
           pr.REVIEWTEXT
    FROM CUSTOMER_MEMBERSHIP cm
    INNER JOIN CUSTOMERS cust ON cust.customernumber = cm.customernumber
    INNER JOIN COUNTRY c ON c.country = cust.country
    INNER JOIN REGION r ON r.regionid = c.regionid
    INNER JOIN ORDERS o ON o.customernumber = cm.customernumber
    INNER JOIN ORDER_DETAILS od ON od.ordernumber = o.ordernumber
    INNER JOIN PRODUCT_REVIEWS pr ON pr.productcode = od.productcode
    WHERE cm.STATUS = 'Inactive';

SELECT *
FROM INACTIVEMEMBER
WHERE status = 'Inactive'

--USER STORY 3.5
-- Average Shipment Days
CREATE OR ALTER VIEW ShipmentDays
AS
    SELECT MODEID, AVG(od.quantityordered) AS "Average Quantity Ordered", c.country, AVG(arrivaldate-shippeddate) AS "Avg Number of Days", COUNT(MODEID) AS "Shipment Mode Frequency"
    FROM ORDERS o
    INNER JOIN ORDER_DETAILS od on od.ordernumber=o.ordernumber
    INNER JOIN CUSTOMERS c on c.customernumber=o.customernumber
    GROUP BY MODEid, od.ordernumber, c.country;

SELECT *
FROM ShipmentDays
ORDER BY "Avg Number of Days"


-- Processing Time
CREATE OR ALTER VIEW ProcessingTime
AS
    SELECT MODEID, c.country, od.productcode, AVG(SHIPPEDDATE-ORDERDATE) AS "Processing Time"
    FROM ORDERS o
    INNER JOIN CUSTOMERS c on c.customernumber=o.customernumber
    INNER JOIN ORDER_DETAILS od on od.ordernumber=o.ordernumber
    GROUP BY MODEID, c.country, od.productcode;

SELECT * 
FROM ProcessingTime
ORDER BY "Processing Time"

-- Orders that are not delivered before the required date
CREATE OR ALTER VIEW Undelivered
AS
    SELECT * 
    FROM ORDERS
    WHERE REQUIREDDATE < SHIPPEDDATE;

SELECT * FROM Undelivered


-- Vendors with the highest amount of products: see for variety
CREATE OR ALTER VIEW VendorProduct
AS
    SELECT 
        PRODUCTVENDOR, 
        COUNT(PRODUCTCODE) AS ProductCount, 
        COUNT(PRODUCTLINE) AS ProductLineCount, 
        COUNT(DISTINCT PRODUCTSCALE) AS UniqueProductScales
    FROM 
        PRODUCTS
    GROUP BY 
        PRODUCTVENDOR;

SELECT * FROM VendorProduct


