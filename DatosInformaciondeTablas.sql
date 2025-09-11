-- Trae la informacion completa de la tabla
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Product'
  AND TABLE_SCHEMA = 'Production';

--concejos para evitar que te confundas con los join 
-- 1. Usa alias descriptivos
--FROM Production.Product p
--JOIN Production.ProductSubcategory subcat ON p.ProductSubcategoryID = subcat.ProductSubcategoryID
--JOIN Production.ProductCategory cat ON subcat.ProductCategoryID = cat.ProductCategoryID

--p.ProductSubcategoryID = subcat.ProductCategoryID -- ⚠️ se nota más el error


--4. Prueba los JOIN de dos en dos
--Primero prueba unir dos tablas y ver cuántos resultados obtienes. Luego añade la tercera. Por ejemplo:
-- Paso 1
SELECT p.Name, subcat.Name
FROM Production.Product p
JOIN Production.ProductSubcategory subcat ON p.ProductSubcategoryID = subcat.ProductSubcategoryID

-- Paso 2
SELECT p.Name, subcat.Name, cat.Name
FROM Production.Product p
JOIN Production.ProductSubcategory subcat ON p.ProductSubcategoryID = subcat.ProductSubcategoryID
JOIN Production.ProductCategory cat ON subcat.ProductCategoryID = cat.ProductCategoryID
--Si al hacer el segundo JOIN te baja el número de filas, probablemente haya un problema.

--5. Validar con COUNT para encontrar errores
--Puedes comparar el total de productos que deberían tener subcategoría o categoría así:
-- Total de productos con subcategoría asignada
SELECT COUNT(*) FROM Production.Product WHERE ProductSubcategoryID IS NOT NULL;

-- Total de subcategorías
SELECT COUNT(*) FROM Production.ProductSubcategory;

-- Total de categorías
SELECT COUNT(*) FROM Production.ProductCategory;
--Esto te ayuda a saber si hay datos huérfanos (productos sin subcategoría válida, por ejemplo).


--3. Usar esta consulta para ver claves primarias y foráneas
--Esto te dice qué columnas están relacionadas entre sí:
SELECT 
    fk.name AS FK_Name,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id
INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id
INNER JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
ORDER BY ParentTable, ReferencedTable;
--Esto te ayuda a confirmar qué columnas debes usar en tus JOIN.