SELECT CUSTOMERNUMBER, CUSTOMERNAME, COUNT(*) 

FROM CUSTOMERS 

GROUP BY CUSTOMERNUMBER, CUSTOMERNAME 

HAVING COUNT(*) > 1; 

  

