SELECT
    t.`Trainer_ID`,
    p.`FName`,
    p.`LName`,
    COUNT(*) as `Train_Count`
FROM `Trainer` AS t
JOIN `Person` AS p ON p.`Person_ID` = t.`Trainer_ID`
JOIN `Receptionist` AS r ON r.`Trainer_ID` = t.`Trainer_ID`
GROUP BY r.`Trainer_ID`
HAVING `Train_Count` = (
    SELECT MAX(`counts`)
    FROM (
	SELECT r.`Trainer_ID`, COUNT(*) AS `counts`
	FROM `Receptionist` AS r
	GROUP BY r.`Trainer_ID`
    ) AS x
);
