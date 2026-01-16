SELECT
    r.`Person_ID` AS `Receptionist_ID`,
    p.`FName` AS `Receptionist_FName`,
    p.`LName` AS `Receptionist_LName`,
    t.`Trainer_ID` AS `Trainer_ID`,
    p2.`FName` AS `Trainer_FName`,
    p2.`LName` AS `Trainer_LName`
FROM (
    SELECT x.`Receptionist_ID`
    FROM (
        SELECT
	    YEAR(i.`Inquiry_Time`) AS `ytime`,
	    MONTH(i.`Inquiry_Time`) AS `mtime`,
	    i.`Receptionist_ID`
        FROM `Inquiry` AS i
        WHERE i.`Inquiry_Time` >= DATE_SUB(NOW(), INTERVAL 3 MONTH)
	    AND i.`Resolution_Status` = 'RESOLVED'
        GROUP BY `ytime`, `mtime`, i.`Receptionist_ID`
        HAVING COUNT(*) >= 2
    ) AS x
    GROUP BY x.`Receptionist_ID`
    HAVING COUNT(*) >= 3
) AS y
JOIN `Receptionist` AS r ON r.`Person_ID` = y.`Receptionist_ID`
JOIN `Employee` AS e ON e.`Person_ID` = r.`Person_ID`
JOIN `Person` AS p ON p.`Person_ID` = e.`Person_ID`
LEFT JOIN `Trainer` AS t ON t.`Trainer_ID` =r.`Trainer_ID`
LEFT JOIN `Person` AS p2 ON p2.`Person_ID` = t.`Trainer_ID`;
