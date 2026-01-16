SELECT 
    bk.`Book_ID`,
    bk.`Book_Title`
FROM `Book` AS bk
LEFT JOIN `Borrowing` AS b ON (
    b.`Book_ID` = bk.`Book_ID`
    AND b.`Issue_Date` >= DATE_SUB(CURDATE(), INTERVAL 5 MONTH)
)
WHERE b.`Book_ID` IS NULL;
