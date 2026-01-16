SELECT 
    YEAR(b.`Issue_Date`) AS `BorrowYear`,
    COUNT(*) AS `Total_Borrowed`
FROM `Borrowing` AS b
GROUP BY `BorrowYear`
HAVING `Total_Borrowed` = (
    SELECT MAX(`counts`)
    FROM (
	SELECT COUNT(*) AS `counts`
	FROM `Borrowing` AS b2
	GROUP BY YEAR(b2.`Issue_Date`)
    ) AS x
);
