SELECT 
    gm.`Person_ID`, 
    p.`FName`, 
    p.`LName`,
    COUNT(*) as `Guest_Count`
FROM `Gold_Member` AS gm
JOIN `Member` AS m ON m.`Person_ID` = gm.`Person_ID`
JOIN `Person` AS p ON p.`Person_ID` = m.`Person_ID`
JOIN `Guest_Log` AS gl ON gl.`Card_ID` = m.`Card_ID`
GROUP BY gm.`Person_ID`
HAVING `Guest_Count` = (
    SELECT MAX(`counts`)
    FROM (
	SELECT COUNT(*) AS `counts`
	FROM `Guest_Log` AS gl2
	GROUP BY gl2.`Card_ID`
    ) AS x
);
