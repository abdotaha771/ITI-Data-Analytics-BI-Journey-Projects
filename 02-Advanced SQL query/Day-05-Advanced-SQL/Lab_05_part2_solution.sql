USE AdventureWorks2012; 
GO

-- 1
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2002-07-28' AND '2014-07-29';

-- 2
SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110.00;

-- 3
SELECT ProductID, Name
FROM Production.Product
WHERE Weight IS NULL;

-- 4
SELECT *
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');

-- 5
SELECT *
FROM Production.Product
WHERE Name LIKE 'B%';

-- 6
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

SELECT *
FROM Production.ProductDescription
WHERE Description LIKE '%[_]%';


-- 7
SELECT OrderDate, SUM(TotalDue) AS Total_Due_Sum
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2001-07-01' AND '2014-07-31'
GROUP BY OrderDate;

-- 8
SELECT DISTINCT HireDate
FROM HumanResources.Employee;

-- 9
SELECT AVG(DISTINCT ListPrice) AS Avg_Unique_ListPrice
FROM Production.Product;

-- 10
SELECT 'The ' + Name + ' is only! ' + CAST(ListPrice AS VARCHAR(30)) AS Product_Info
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;