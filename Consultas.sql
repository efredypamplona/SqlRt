--muestra la tabla que quiero ver
select * from [Sales].[SalesOrderHeader]
-- muestra el nombre de las tablas 
SELECT name from sys.tables
--verifica el esquema de la tabla
SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'SalesOrderHeader';


SELECT name from sys.tables

SELECT 
    soh.SalesOrderID, 
    soh.OrderDate, 
    sod.ProductID, 
    sod.OrderQty, 
    sod.LineTotal
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID;


SELECT * from sales.SalesOrderHeader
SELECT * from sales.SalesOrderDetail

SELECT 
    soh.SalesOrderID, 
    soh.OrderDate, 
    sod.ProductID, 
    sod.OrderQty, 
    sod.LineTotal
FROM Sales.SalesOrderHeader AS soh
LEFT JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID;


SELECT 
    soh.SalesOrderID, 
    soh.OrderDate, 
    sod.ProductID, 
    sod.OrderQty, 
    sod.LineTotal
FROM Sales.SalesOrderHeader AS soh
FULL JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID;


SELECT CustomerID, COUNT(SalesOrderID) AS TotalPedidos
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 5;


-- Escribe una consulta para obtener los primeros 10 registros de una tabla llamada Sales.SalesOrderHeader.
SELECT * FROM Sales.SalesOrderHeader
WHERE SalesOrderID
BETWEEN 43659 AND 43668


-- ¿Cómo filtras los productos cuyo nombre comienza con "A" en la tabla Production.Product?
SELECT * FROM  Production.Product


SELECT TOP 10 * FROM Sales.SalesOrderHeader

SELECT * 
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;



SELECT * 
FROM (
    SELECT TOP 10 * 
    FROM Sales.SalesOrderHeader
    ORDER BY OrderDate ASC
) AS SubQuery
ORDER BY OrderDate DESC;

SELECT TOP 10 * 
    FROM Sales.SalesOrderHeader
    ORDER BY OrderDate ASC

--¿Cómo filtras los productos cuyo nombre comienza con "A" en la tabla Production.Product?
SELECT * FROM Production.Product
WHERE NAME  LIKE 'A%'



SET STATISTICS TIME ON;

SELECT * 
FROM Sales.SalesOrderDetail 
WHERE ProductID = 776;

SET STATISTICS TIME OFF;

CREATE NONCLUSTERED INDEX idx_ProductID 
ON Sales.SalesOrderDetail (ProductID);


