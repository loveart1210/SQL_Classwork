USE northwind;

-- 1) Danh sách các products có từ ‘Boxes’ trong cột QuantityPerUnit. (1 điểm)
SELECT ProductID, ProductName, QuantityPerUnit
FROM products
WHERE QuantityPerUnit LIKE '%Boxes%';

-- 2) Danh sách các products có Unitprice lớn hớn 10 và nhỏ hơn 15. (1 điểm)
SELECT ProductID, ProductName, UnitPrice
FROM products
WHERE UnitPrice > 10 AND UnitPrice < 15
ORDER BY UnitPrice, ProductName;

-- 3) Danh sách các orders có OrderDate được lập trong tháng 10 năm 1997. (1 điểm)
SELECT OrderID, CustomerID, EmployeeID, OrderDate
FROM orders
WHERE OrderDate >= '1997-10-01' 
  AND OrderDate <  '1997-11-01'
ORDER BY OrderDate, OrderID;

-- 4) Danh sách các products ứng với tiền tồn vốn. Thông tin bao gồm ProductId, ProductName, Unitprice, UnitsInStock, TotalAccount. Trong đó TotalAccount= UnitsInStock * Unitprice. (1 điểm)
SELECT 
    ProductID, 
    ProductName, 
    UnitPrice, 
    UnitsInStock,
    ROUND(UnitsInStock * UnitPrice, 2) AS TotalAccount
FROM products
ORDER BY TotalAccount DESC, ProductName;

-- 5) Danh sách các customers có city là Paris. (1 điểm)
SELECT CustomerID, CompanyName, City, Country
FROM customers
WHERE City = 'Paris'
ORDER BY CompanyName;

-- 6) Danh sách 10 customers có city bắt đầu ‘M’. (1 điểm)
SELECT CustomerID, CompanyName, City, Country
FROM customers
WHERE City LIKE 'M%'
ORDER BY City, CompanyName
LIMIT 10;

-- 7) Danh sách 3 employees có tuổi lớn nhất. Thông tin bao gồm EmployeeID, EmployeeName, Age. Trong đó, EmployeeName được ghép từ LastName và FirstName; Age là năm hiện hành từ cho năm sinh. (2 điểm)
SELECT 
    EmployeeID,
    CONCAT(LastName, ' ', FirstName) AS EmployeeName,
    (YEAR(CURDATE()) - YEAR(BirthDate)) AS Age
FROM employees
ORDER BY Age DESC, BirthDate ASC, EmployeeID ASC
LIMIT 3;

-- 8) Danh sách các orders ứng với tổng tiền của từng hóa đơn có Shipcity là ‘Madrid’. Thông tin bao gồm OrdersId, OrderDate, TotalAccount. Trong đó TotalAccount là Sum của Quantity * Unitprice, kết nhóm theo OrderId. (2 điểm)
SELECT 
    o.OrderID,
    o.OrderDate,
    ROUND(SUM(od.Quantity * od.UnitPrice), 2) AS TotalAccount
FROM orders AS o
JOIN order_details AS od 
  ON o.OrderID = od.OrderID
WHERE o.ShipCity = 'Madrid'
GROUP BY o.OrderID, o.OrderDate
ORDER BY o.OrderDate, o.OrderID;
