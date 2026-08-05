SELECT
    e.`Person_ID`,
    p.`FName`,
    p.`LName`
FROM `Employee` AS e
JOIN `Person` AS p ON p.`Person_ID` = e.`Person_ID`
JOIN `Member` AS m ON m.`Person_ID` = p.`Person_ID`
WHERE m.`Membership_Level` = 'Gold'
    AND m.`Issue_Date` >= e.`Start_Date`
    AND m.`Issue_Date` <= DATE_ADD(e.`Start_Date`, INTERVAL 1 MONTH);
