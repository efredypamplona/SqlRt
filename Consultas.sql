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
