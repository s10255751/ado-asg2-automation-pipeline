SELECT REGIONID, COUNT(*) 

FROM REGION 

GROUP BY REGIONID 

HAVING COUNT(*) > 1; 