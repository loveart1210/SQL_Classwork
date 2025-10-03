-- 1. Products có “Boxes” trong QuantityPerUnit
SELECT ProductID, ProductName, QuantityPerUnit
FROM products
WHERE QuantityPerUnit LIKE '%Boxes%';

-- 2. Products có UnitPrice > 10 và < 15
SELECT ProductID, ProductName, UnitPrice
FROM products
WHERE UnitPrice > 10 AND UnitPrice < 15;

-- 3. Orders trong tháng 10/1997
SELECT OrderID, CustomerID, EmployeeID, OrderDate
FROM orders
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 10;

-- 4. Products kèm tiền tồn vốn (TotalAccount = UnitsInStock * UnitPrice)
SELECT ProductID, ProductName, UnitPrice, UnitsInStock,
       (UnitsInStock * UnitPrice) AS TotalAccount
FROM products;

-- 5. Customers có City = 'Paris'
SELECT CustomerID, CompanyName, Address, City, Region, Country
FROM customers
WHERE City = 'Paris';

-- 6. 10 Customers có City bắt đầu bằng “M”
SELECT CustomerID, CompanyName, City
FROM customers
WHERE City LIKE 'M%'
LIMIT 10;

-- 7. 3 Employees có tuổi lớn nhất
--(Tuổi = năm hiện hành – năm sinh)

SELECT EmployeeID,
       CONCAT(LastName, ' ', FirstName) AS EmployeeName,
       TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM employees
ORDER BY Age DESC
LIMIT 3;

-- 8. Orders có tổng tiền từng hóa đơn, ShipCity = ‘Madrid’
SELECT o.OrderID, o.OrderDate,
       SUM(od.Quantity * od.UnitPrice) AS TotalAccount
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
WHERE o.ShipCity = 'Madrid'
GROUP BY o.OrderID, o.OrderDate;