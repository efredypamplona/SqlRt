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

--¿Cómo actualizas el precio de un producto en la tabla Production.Product?
select * from Production.Product

--UPDATE o TRUNCATE

UPDATE Production.Product
SET ListPrice = 500.00
FROM
Production.Product
WHERE Production.Product.ProductID = 1


--eliminar duplicados con DISTINCT
SELECT DISTINCT ProductSubcategoryID, color
FROM Production.Product;

--Escribe una consulta que obtenga la cantidad total de pedidos por cliente en Sales.Customer.
 
 --obtener cantidad total
 --

 select * from Sales.Customer
 SELECT * from sales.SalesOrderHeader
 --SELECT * from Sales.SalesOrderDetail

 SELECT name from sys.tables

 SELECT c.CustomerID AS id_cliente, COUNT(soh.SalesOrderID) AS total_pedidos
 FROM Sales.Customer c
 INNER JOIN sales.SalesOrderHeader soh
 on c.CustomerID  = soh.CustomerID
 GROUP BY c.CustomerID


--Sub consulta que trae todos los pedidos de los clientes
 SELECT 
    CustomerID, 
    (SELECT COUNT(*) 
     FROM Sales.SalesOrderHeader soh 
     WHERE soh.CustomerID = c.CustomerID) AS TotalPedidos
FROM Sales.Customer c;

--Escribe una consulta para obtener los clientes que han hecho compras en 2023.
--clientes
--Compras
--ordenes

select  DISTINCT c.CustomerID, c.PersonID
from sales.Customer c
inner join sales.SalesOrderHeader soh
on c.CustomerID = soh.CustomerID 
WHERE SOH.OrderDate  LIKE '%2013%'



SELECT DISTINCT c.CustomerID, c.PersonID
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE YEAR(soh.OrderDate) = 2013

--¿Cómo encontrar productos que nunca han sido vendidos usando NOT EXISTS?
select prod.ProductID, prod.Name
from Production.Product prod
where not exists (
select 1
from sales.SalesOrderDetail sod 
where sod.ProductID = prod.ProductID
);

--ota manera para ver el resultado
SELECT p.ProductID, p.Name
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;

--¿Cómo escribirías una consulta para calcular el precio promedio de los productos vendidos en Sales.SalesOrderDetail?
select avg(sod.UnitPrice) as promedio
from sales.SalesOrderDetail sod

--¿Cómo podrías encontrar empleados con el salario más alto en la tabla HumanResources.EmployeePayHistory?
select DISTINCT he.JobTitle,heh.Rate
from HumanResources.Employee he
join HumanResources.EmployeePayHistory heh
on he.BusinessEntityID = heh.BusinessEntityID
order by heh.Rate desc