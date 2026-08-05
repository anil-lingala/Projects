SELECT 
    p.`FName`,
    p.`LName`,
    m.`Person_ID`
FROM `Member` AS m
JOIN `Person` AS p ON p.`Person_ID` = m.`Person_ID`
JOIN `Borrowing` AS b ON b.`Person_ID` = m.`Person_ID`
WHERE b.`Book_ID` IN (
    SELECT t1.`Book_ID`
    FROM `Authors` AS t1
    WHERE t1.`Author_ID` = (
        SELECT popAuth.`Author_ID`
        FROM `Authors` AS popAuth
        JOIN `Borrowing` AS bb ON bb.`Book_ID` = popAuth.`Book_ID`
        GROUP BY popAuth.`Author_ID`
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
)
GROUP BY m.`Person_ID`, p.`FName`, p.`LName`
HAVING COUNT(DISTINCT b.`Book_ID`) = (
    SELECT COUNT(DISTINCT au2.`Book_ID`)
    FROM `Authors` AS au2
    WHERE au2.`Author_ID` = (
        SELECT popAuth2.`Author_ID`
        FROM `Authors` AS popAuth2
        JOIN `Borrowing` AS bb2 ON bb2.`Book_ID` = popAuth2.`Book_ID`
        GROUP BY popAuth2.`Author_ID`
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
);
