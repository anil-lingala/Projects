SELECT
    x.`Cataloging_Manager_ID`,
    p.`FName`,
    p.`LName`
FROM (
    SELECT
        YEAR(c.`Date`) AS `dyear`,
	WEEK(c.`Date`) AS `wyear`,
	c.`Cataloging_Manager_ID`
    FROM `Catalogs` AS c
    WHERE c.`Date` >= DATE_SUB(CURDATE(), INTERVAL 4 WEEK)
    GROUP BY `dyear`, `wyear`, c.`Cataloging_Manager_ID`
    HAVING COUNT(DISTINCT Level) = 3
) AS x
JOIN `Employee` AS e ON e.`Person_ID` = x.`Cataloging_Manager_ID`
JOIN `Person` AS p ON p.`Person_ID` = e.`Person_ID`
GROUP BY x.`Cataloging_Manager_ID`
HAVING COUNT(*) >= 4;
