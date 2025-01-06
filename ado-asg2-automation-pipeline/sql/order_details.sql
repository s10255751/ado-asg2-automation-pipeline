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