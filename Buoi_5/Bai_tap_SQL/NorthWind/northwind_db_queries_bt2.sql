-- 1. Danh sách Customers (CustomerID, CompanyName, City, Phone)
SELECT CustomerID, CompanyName, City, Phone
FROM customers;

-- 2. Danh sách Products (ProductID, ProductName, UnitPrice)
SELECT ProductID, ProductName, UnitPrice
FROM products;

-- 3. Danh sách Employees (EmployeeID, EmployeeName, Phone, Age)
SELECT EmployeeID,
       CONCAT(LastName, ' ', FirstName) AS EmployeeName,
       HomePhone AS Phone,
       TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM employees;

-- 4. Employees có năm sinh ≤ 1960
SELECT EmployeeID, LastName, FirstName, BirthDate
FROM employees
WHERE YEAR(BirthDate) <= 1960;

-- 5. Products có từ “Boxes” trong QuantityPerUnit
SELECT ProductID, ProductName, QuantityPerUnit
FROM products
WHERE QuantityPerUnit LIKE '%Boxes%';

-- 6. Products có UnitPrice > 10 và < 15
SELECT ProductID, ProductName, UnitPrice
FROM products
WHERE UnitPrice > 10 AND UnitPrice < 15;

-- 7. Orders trong tháng 9 năm 1996
SELECT OrderID, CustomerID, EmployeeID, OrderDate
FROM orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 9;

-- 8. Products ứng với tiền tồn vốn
SELECT ProductID, ProductName, UnitPrice, UnitsInStock,
       (UnitsInStock * UnitPrice) AS TotalAccount
FROM products;

-- 9. Customers có City = 'Paris'
SELECT CustomerID, CompanyName, City
FROM customers
WHERE City = 'Paris';

-- 10. 5 Customers có City bắt đầu bằng 'M'
SELECT CustomerID, CompanyName, City
FROM customers
WHERE City LIKE 'M%'
LIMIT 5;

-- 11. 2 Employees có tuổi lớn nhất
SELECT EmployeeID,
       CONCAT(LastName, ' ', FirstName) AS EmployeeName,
       TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM employees
ORDER BY Age DESC
LIMIT 2;

-- 12. Products đã từng có khách hàng đặt hàng
SELECT DISTINCT p.ProductID, p.ProductName, p.UnitPrice
FROM products p
JOIN order_details od ON p.ProductID = od.ProductID;

-- 13. Orders ứng với tổng tiền từng hóa đơn
SELECT o.OrderID, o.OrderDate,
       SUM(od.Quantity * od.UnitPrice) AS TotalAccount
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.OrderDate;

-- 14. Orders ứng với tổng tiền từng hóa đơn có ShipCity = 'Madrid'
SELECT o.OrderID, o.OrderDate,
       SUM(od.Quantity * od.UnitPrice) AS TotalAccount
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
WHERE o.ShipCity = 'Madrid'
GROUP BY o.OrderID, o.OrderDate;

-- 15. Products có tổng số lượng lập hóa đơn lớn nhất
SELECT od.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM order_details od
JOIN products p ON od.ProductID = p.ProductID
GROUP BY od.ProductID, p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 1;

-- 16. Mỗi Customer lập bao nhiêu hóa đơn
SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS CountOfOrder
FROM customers c
LEFT JOIN orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName;

-- 17. Mỗi Employee lập được bao nhiêu hóa đơn, ứng với tổng tiền
SELECT e.EmployeeID, CONCAT(e.LastName, ' ', e.FirstName) AS EmployeeName,
       COUNT(o.OrderID) AS CountOfOrder,
       SUM(od.Quantity * od.UnitPrice) AS TotalAmount
FROM employees e
LEFT JOIN orders o ON e.EmployeeID = o.EmployeeID
LEFT JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.LastName, e.FirstName;

-- 18. Customers chưa từng lập hóa đơn
SELECT c.CustomerID, c.CompanyName
FROM customers c
LEFT JOIN orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;