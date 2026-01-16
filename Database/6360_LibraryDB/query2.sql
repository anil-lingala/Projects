SELECT DISTINCT
    p.`FName`,
    p.`MInit`,
    p.`LName`,
    bk.`Book_Title`
FROM `Employee` AS e
JOIN `Person` AS p ON p.`Person_ID` = e.`Person_ID`
JOIN `Member` AS m ON m.`Person_ID` = p.`Person_ID`
LEFT JOIN `Borrowing` b ON b.`Person_ID` = p.`Person_ID`
LEFT JOIN `Book` AS bk ON bk.`Book_ID` = b.`Book_ID`
WHERE b.`Issue_Date` IS NULL OR b.`Issue_Date` >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
