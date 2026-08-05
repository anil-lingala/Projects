SELECT
    r.`Person_ID`,
    p.`FName`,
    p.`LName`
FROM `Person` AS p
JOIN `Employee` AS e ON e.`Person_ID` = p.`Person_ID`
JOIN `Receptionist` AS r ON r.`Person_ID` = e.`Person_ID`
JOIN (
    SELECT r2.`Person_ID`
    FROM `Receptionist` AS r2
    JOIN `Inquiry` AS i ON r2.`Person_ID` = i.`Receptionist_ID`
    WHERE i.`Resolution_Status` = 'RESOLVED'
    GROUP BY r2.`Person_ID`
    HAVING AVG(i.`Rating`) = 4.0
) AS x ON x.`Person_ID` = r.`Person_ID`;
