CREATE TABLE `Person` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	`FName` VARCHAR(255),
	`MInit` VARCHAR(255),
	`LName` VARCHAR(255),
	`Address` VARCHAR(1023),
	`Gender` VARCHAR(31),
	`Date_of_Birth` DATE,
	CONSTRAINT `CK_Person_Person_ID` CHECK (`Person_ID` REGEXP 'P[0-9][0-9][0-9]')
);

CREATE TABLE `Phone_Num` (
	`Person_ID` CHAR(4),
	`Phone_Num` VARCHAR(15),
	PRIMARY KEY (`Person_ID`, `Phone_Num`),
	CONSTRAINT `FK_PhoneNum_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Person`(`Person_ID`),
	CONSTRAINT `CK_PhoneNum_PhoneNum` CHECK (`Phone_Num` REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$')
);

CREATE TABLE `Employee` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	`Start_Date` DATE,
	CONSTRAINT `FK_Employee_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Person`(`Person_ID`)
);

CREATE TABLE `Member` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	`Card_ID` INT UNIQUE NOT NULL,
	`Issue_Date` DATE,
	`Membership_Level` ENUM('Silver','Gold'),
	CONSTRAINT `FK_Member_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Person`(`Person_ID`)
);

CREATE TABLE `Trainer` (
	`Trainer_ID` CHAR(4) PRIMARY KEY,
	CONSTRAINT `FK_Trainer_Person` FOREIGN KEY (`Trainer_ID`) REFERENCES `Person`(`Person_ID`)
);

CREATE TABLE `Library_Supervisor` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	`Trainer_ID` CHAR(4),
	CONSTRAINT `FK_Library_Supervisor_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Employee`(`Person_ID`),
	CONSTRAINT `FK_Library_Supervisor_Trainer` FOREIGN KEY (`Trainer_ID`) REFERENCES `Trainer`(`Trainer_ID`)
);

CREATE TABLE `Receptionist` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	`Trainer_ID` CHAR(4) NOT NULL,
	CONSTRAINT `FK_Receptionist_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Employee`(`Person_ID`),
	CONSTRAINT `FK_Receptionist_Trainer` FOREIGN KEY (`Trainer_ID`) REFERENCES `Trainer`(`Trainer_ID`)
);

CREATE TABLE `Cataloging_Manager` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	`Trainer_ID` CHAR(4),
	CONSTRAINT `FK_Cataloging_Manager_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Employee`(`Person_ID`),
	CONSTRAINT `FK_Cataloging_Manager_Trainer` FOREIGN KEY (`Trainer_ID`) REFERENCES `Trainer`(`Trainer_ID`)
);

CREATE TABLE `Author` (
	`Author_ID` INT PRIMARY KEY,
	`Author_Name` VARCHAR(255)
);

CREATE TABLE `Publisher` (
	`Publisher_ID` INT PRIMARY KEY,
	`Publisher_Name` VARCHAR(255)
);

CREATE TABLE `Level` (
	`Level` VARCHAR(15) PRIMARY KEY,
	CONSTRAINT `CK_Level_Level` CHECK (`Level` REGEXP '^Cate. [0-9]+$')
);

CREATE TABLE `Book` (
	`Book_ID` INT PRIMARY KEY,
	`Book_Title` VARCHAR(255),
	`Publisher_ID` INT NOT NULL,
	`Level` VARCHAR(15) NOT NULL,
	CONSTRAINT `FK_Book_Publisher` FOREIGN KEY (`Publisher_ID`) REFERENCES `Publisher`(`Publisher_ID`),
	CONSTRAINT `FK_Book_Level` FOREIGN KEY (`Level`) REFERENCES `Level`(`Level`)
);

CREATE TABLE `Authors` (
	`Author_ID` INT,
	`Book_ID` INT,
	PRIMARY KEY (`Author_ID`, `Book_ID`),
	CONSTRAINT `FK_Authors_Author` FOREIGN KEY (`Author_ID`) REFERENCES `Author`(`Author_ID`),
	CONSTRAINT `FK_Authors_Book` FOREIGN KEY (`Book_ID`) REFERENCES `Book`(`Book_ID`)
);

CREATE TABLE `Payment` (
	`Payment_ID` INT PRIMARY KEY,
	`Payment_Method` VARCHAR(31),
	`Payment_Time` DATETIME,
	`Amount_Paid` DECIMAL(10, 2)
);

CREATE TABLE `Borrowing` (
	`Borrowing_ID` INT PRIMARY KEY,
	`Issue_Date` DATE,
	`Due_Date` DATE,
	`Payment_ID` INT UNIQUE,
	`Book_ID` INT NOT NULL,
	`Receptionist_ID` CHAR(4) NOT NULL,
	`Person_ID` CHAR(4) NOT NULL,
	CONSTRAINT `FK_Borrowing_Payment` FOREIGN KEY (`Payment_ID`) REFERENCES `Payment`(`Payment_ID`),
	CONSTRAINT `FK_Borrowing_Book` FOREIGN KEY (`Book_ID`) REFERENCES `Book`(`Book_ID`),
	CONSTRAINT `FK_Borrowing_Receptionist` FOREIGN KEY (`Receptionist_ID`) REFERENCES `Receptionist`(`Person_ID`),
	CONSTRAINT `FK_Borrowing_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Person`(`Person_ID`)
);

CREATE TABLE `Catalogs` (
	`Level` VARCHAR(15),
	`Cataloging_Manager_ID` CHAR(4),
	`Date` DATE,
	PRIMARY KEY (`Level`, `Cataloging_Manager_ID`, `Date`),
	CONSTRAINT `FK_Catalogs_Level` FOREIGN KEY (`Level`) REFERENCES `Level`(`Level`),
	CONSTRAINT `FK_Catalogs_Cataloging_Manager` FOREIGN KEY (`Cataloging_Manager_ID`) REFERENCES `Cataloging_Manager`(`Person_ID`)
);

CREATE TABLE `Comments` (
	`Person_ID` CHAR(4),
	`Book_ID` INT,
	`Comment_Time` DATETIME,
	`Comment_Rating` INT,
	`Comment_Content` VARCHAR(4095),
	PRIMARY KEY (`Person_ID`, `Book_ID`, `Comment_Time`),
	CONSTRAINT `CK_Comments_Comment_Rating` CHECK (`Comment_Rating` >= 1 AND `Comment_Rating` <= 5),
	CONSTRAINT `FK_Comments_Person` FOREIGN KEY (`Person_ID`) REFERENCES `Person`(`Person_ID`),
	CONSTRAINT `FK_Comments_Book` FOREIGN KEY (`Book_ID`) REFERENCES `Book`(`Book_ID`)
);

CREATE TABLE `Inquiry` (
	`Inquiry_ID` INT PRIMARY KEY,
	`Inquiry_Time` DATETIME,
	`Resolution_Status` ENUM('IN_PROGRESS', 'RESOLVED') DEFAULT 'IN_PROGRESS',
	`Rating` INT,
	`Receptionist_ID` CHAR(4) NOT NULL,
	`Member_ID` CHAR(4) NOT NULL,
	CONSTRAINT `FK_Inquiry_Receptionist` FOREIGN KEY (`Receptionist_ID`) REFERENCES `Receptionist`(`Person_ID`),
	CONSTRAINT `FK_Inquiry_Member` FOREIGN KEY (`Member_ID`) REFERENCES `Member`(`Person_ID`),
	CONSTRAINT `CK_Inquiry_Rating` CHECK (`Rating` >= 1 AND `Rating` <= 5)
);

CREATE TABLE `Promotion` (
	`Promotion_Code` INT PRIMARY KEY,
	`Description` VARCHAR(255),
	`Card_ID` INT,
	CONSTRAINT `FK_Promotion_Member` FOREIGN KEY (`Card_ID`) REFERENCES `Member`(`Card_ID`)
);

CREATE TABLE `Gold_Member` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	CONSTRAINT `FK_Gold_Member` FOREIGN KEY (`Person_ID`) REFERENCES `Member`(`Person_ID`)
);

CREATE TABLE `Silver_Member` (
	`Person_ID` CHAR(4) PRIMARY KEY,
	CONSTRAINT `FK_Silver_Member` FOREIGN KEY (`Person_ID`) REFERENCES `Member`(`Person_ID`)
);

CREATE TABLE `Guest_Log` (
	`Card_ID` INT,
	`Guest_ID` INT,
	`Guest_Name` VARCHAR(255),
	`Guest_Address` VARCHAR(255),
	`Guest_Contact_Info` VARCHAR(255),
	PRIMARY KEY (`Card_ID`, `Guest_ID`),
	CONSTRAINT `FK_Guest_Log_Member` FOREIGN KEY (`Card_ID`) REFERENCES `Member`(`Card_ID`)
); 

CREATE VIEW `TopGoldMember` AS
SELECT 
    p.`FName`,
    p.`LName`,
    m.`Issue_Date` AS `Membership_Enrollment_Date`
FROM `Gold_Member` gm
JOIN `Member` m ON gm.`Person_ID` = m.`Person_ID`
JOIN `Person` p ON p.`Person_ID` = m.`Person_ID`
JOIN `Borrowing` b ON b.`Person_ID` = gm.`Person_ID`
WHERE b.`Issue_Date` >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY gm.`Person_ID`, p.`FName`, p.`LName`, m.`Issue_Date`
HAVING COUNT(*) > 5;

CREATE VIEW `PopularBooks` AS
SELECT 
    bk.`Book_ID`,
    bk.`Book_Title`,
    bk.`Publisher_ID`,
    bk.`Level`,
    COUNT(b.`Borrowing_ID`) AS `Borrow_Count`
FROM `Book` bk
JOIN `Borrowing` b ON b.`Book_ID` = bk.`Book_ID`
WHERE b.`Issue_Date` >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY bk.`Book_ID`
ORDER BY `Borrow_Count` DESC;

CREATE VIEW `BestRatingPublisher` AS
SELECT pu.`Publisher_Name`
FROM `Publisher` pu
JOIN `Book` bk ON bk.`Publisher_ID` = pu.`Publisher_ID`
JOIN (
    SELECT
        `Book_ID`,
	AVG(`Comment_Rating`) AS `AvgRating`
    FROM `Comments`
    GROUP BY `Book_ID`
) r ON r.`Book_ID` = bk.`Book_ID`
GROUP BY pu.`Publisher_ID`
HAVING MIN(r.`AvgRating`) >= 4.0;

CREATE VIEW `PotentialGoldMember` AS
SELECT 
    p.`Person_ID`,
    p.`FName`,
    p.`LName`,
    MAX(ph.`Phone_Num`) AS `Phone_Num`
FROM `Silver_Member` sm
JOIN `Person` p ON p.`Person_ID` = sm.`Person_ID`
LEFT JOIN `Phone_Num` ph ON ph.`Person_ID` = sm.`Person_ID`
JOIN `Borrowing` b ON b.`Person_ID` = sm.`Person_ID`
WHERE b.`Issue_Date` >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.`Person_ID`
HAVING COUNT(DISTINCT DATE_FORMAT(b.`Issue_Date`, '%Y-%m')) = 12;

CREATE VIEW `ActiveReceptionist` AS
SELECT 
    p.`FName`,
    p.`LName`,
    r.`Person_ID` AS `Receptionist_ID`,
    COUNT(i.`Inquiry_ID`) AS `Resolved_Count`
FROM `Receptionist` r
JOIN `Person` p ON p.`Person_ID` = r.`Person_ID`
JOIN `Inquiry` i ON i.`Receptionist_ID` = r.`Person_ID`
WHERE i.`Inquiry_Time` >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
  AND i.`Resolution_Status` = 'RESOLVED'
GROUP BY r.`Person_ID`
HAVING COUNT(i.`Inquiry_ID`) > 5;
