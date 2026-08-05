SELECT 
    pu.`Publisher_Name`,
    bk.`Book_Title`
FROM `Publisher` AS pu
JOIN `Book` AS bk ON bk.`Publisher_ID` = pu.`Publisher_ID`
JOIN `Borrowing` AS b ON b.`Book_ID` = bk.`Book_ID`
GROUP BY pu.`Publisher_ID`, bk.`Book_ID`
HAVING COUNT(*) = (
    SELECT MAX(bs.`cnt`)
    FROM (
        SELECT 
            b2.Book_ID,
            COUNT(b2.Borrowing_ID) AS cnt
        FROM Borrowing AS b2
        JOIN Book AS bk2 
            ON bk2.Book_ID = b2.Book_ID
        WHERE bk2.Publisher_ID = pu.Publisher_ID
        GROUP BY b2.Book_ID
    ) AS bs
);
