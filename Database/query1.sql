SELECT
    ls.`Person_ID`,
    ls.`Trainer_ID`,
    e.`Start_Date`,
    p.`FName`,
    p.`MInit`,
    p.`LName`,
    p.`Address`,
    p.`Gender`,
    p.`Date_of_Birth`
FROM `Library_Supervisor` ls
JOIN `Employee` AS e on e.`Person_ID` = ls.`Person_ID`
JOIN `Person` AS p on p.`Person_ID` = e.`Person_ID`
where e.`Start_Date` >= DATE_SUB(CURDATE(), INTERVAL 2 MONTH);
