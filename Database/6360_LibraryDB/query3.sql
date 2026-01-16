SELECT
    AVG(x.`borrowed`) AS `Avg_Borrowed`
FROM (
    SELECT 
        gm.`Person_ID`,
        COUNT(*) AS `borrowed`
    FROM `Gold_Member` AS gm
    JOIN `Member` AS m ON m.`Person_ID` = gm.`Person_ID`
    JOIN `Person` AS p ON p.`Person_ID` = m.`Person_ID`
    JOIN `Borrowing` AS b ON b.`Person_ID` = p.`Person_ID`
    GROUP BY b.`Person_ID`
    ORDER BY `borrowed` DESC
    LIMIT 5
) AS x;
