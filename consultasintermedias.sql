--1. Mostrar nombres de productos con su categoría y subcategoría
SELECT 
    p.Name AS ProductName,
    pc.Name AS Category,
    ps.Name AS Subcategory
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY Category, Subcategory, ProductName;
--2. Total de ventas por producto (solo productos vendidos)
SELECT 
    p.Name AS ProductName,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
HAVING SUM(sod.LineTotal) > 0
ORDER BY TotalSales DESC;
--3. Ventas totales por año
SELECT 
    YEAR(OrderDate) AS Year,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY Year;
--3. Ventas totales por año
SELECT 
    YEAR(OrderDate) AS Year,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY Year;
--4. Listado de empleados con su gerente directo
SELECT 
    e.BusinessEntityID AS EmployeeID,
    p.FirstName + ' ' + p.LastName AS EmployeeName,
    e2.BusinessEntityID AS ManagerID,
    p2.FirstName + ' ' + p2.LastName AS ManagerName
FROM HumanResources.Employee e
JOIN HumanResources.Employee e2 ON e.OrganizationNode.GetAncestor(1) = e2.OrganizationNode
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN Person.Person p2 ON e2.BusinessEntityID = p2.BusinessEntityID;

--5. Productos con precio por encima del promedio
SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice > (
    SELECT AVG(ListPrice)
    FROM Production.Product
    WHERE ListPrice > 0
)
ORDER BY ListPrice DESC;
--6. Clientes que han hecho más de 5 pedidos
SELECT 
    CustomerID,
    COUNT(SalesOrderID) AS TotalOrders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 5
ORDER BY TotalOrders DESC;
--7. Órdenes con demora en la entrega (ShipDate > DueDate)
SELECT 
    SalesOrderID, OrderDate, DueDate, ShipDate,
    DATEDIFF(DAY, DueDate, ShipDate) AS DelayDays
FROM Sales.SalesOrderHeader
WHERE ShipDate > DueDate
ORDER BY DelayDays DESC;

--8. Subconsulta: Productos que no han sido vendidos
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM Sales.SalesOrderDetail
);


