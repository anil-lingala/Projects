SELECT DISTINCT 
    p.`FName`,
    p.`LName`,
    m.`Person_ID`,
    b.`Book_ID`
FROM `Borrowing` AS b
JOIN `Member` AS m ON m.`Person_ID` = b.`Person_ID`
JOIN `Person` AS p ON p.`Person_ID` = m.`Person_ID`
WHERE b.`Book_ID` IN (
    SELECT b2.`Book_ID`
    FROM `Borrowing` AS b2
    GROUP BY b2.`Book_ID`
    HAVING COUNT(*) = (
	SELECT MAX(`counts`) AS `counts`
	FROM (
	    SELECT COUNT(*) as `counts`
	    FROM `Borrowing` AS b3
	    GROUP BY b3.`Book_ID`
	) as x
    )
);
