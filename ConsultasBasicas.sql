--Listar los primeros 10 productos
SELECT TOP 10 ProductID, Name, ProductNumber, StandardCost, ListPrice
FROM Production.Product;
--Obtener los primeros 10 empleados
SELECT TOP 10 BusinessEntityID, JobTitle, BirthDate, MaritalStatus, Gender
FROM HumanResources.Employee;
--3. Listar los 10 primeros clientes
SELECT TOP 10 CustomerID, PersonID, StoreID, TerritoryID
FROM Sales.Customer;
--4. Mostrar órdenes de venta con su fecha
SELECT TOP 10 SalesOrderID, OrderDate, DueDate, ShipDate, Status
FROM Sales.SalesOrderHeader;
--5. Obtener nombres completos de los contactos (personas)
SELECT TOP 10 BusinessEntityID, FirstName, LastName
FROM Person.Person;
--6. Mostrar detalles de una orden de venta específica
SELECT SalesOrderID, ProductID, OrderQty, UnitPrice, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43659;  -- Puedes cambiar el ID por otro
--7. Total de productos por categoría >>>>>pendiente
SELECT pc.Name AS Category, COUNT(p.ProductID) AS TotalProducts
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name;
--8. Clientes y su total de órdenes
SELECT CustomerID, COUNT(SalesOrderID) AS TotalOrders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY TotalOrders DESC;


