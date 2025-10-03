-- Schema
Drop Schema If Exists northwind;
Create Schema If Not Exists northwind;
Use northwind;

-- ======================
-- Tables
-- ======================

-- Employees
Drop Table If Exists employees;
Create Table employees (
    EmployeeID int(11) Not Null Auto_Increment,
    LastName Varchar(20) Not Null,
    FirstName Varchar(10) Not Null,
    Title Varchar(30) Default Null,
    TitleOfCourtesy Varchar(25) Default Null,
    BirthDate Datetime Default Null,
    HireDate Datetime Default Null,
    Address Varchar(60) Default Null,
    City Varchar(15) Default Null,
    Region Varchar(15) Default Null,
    PostalCode Varchar(10) Default Null,
    Country Varchar(15) Default Null,
    HomePhone Varchar(24) Default Null,
    Extension Varchar(4) Default Null,
    Photo Longblob,
    Notes Longtext,
    ReportsTo int Default Null,
    PhotoPath Varchar(255) Default Null,
    Primary Key (EmployeeID),
    Key idx_fk_ReportsTo (ReportsTo),
    Key idx_LastName (LastName),
    Key idx_PostalCode (PostalCode),
    Constraint fk_ReportsTo Foreign Key (ReportsTo) References employees(EmployeeID)
        On Delete Restrict On Update Cascade
) Engine=InnoDB Auto_Increment=10 Default Charset=utf8;

-- Categories
Drop Table If exists categories;
Create Table categories (
    CategoryID int(11) Not Null Auto_Increment,
    CategoryName Varchar(15) Not Null,
    Description Mediumtext,
    Picture Longblob,
    Primary Key (CategoryID),
    Key idx_CategoryName (CategoryName)
) Engine=InnoDB Auto_Increment=9 Default Charset=utf8;

-- Customers
Drop Table If exists customers;
Create Table customers (
    CustomerID Varchar(5) Not Null,
    CompanyName Varchar(40) Not Null,
    ContactName Varchar(30) Default Null,
    ContactTitle Varchar(30) Default Null,
    Address Varchar(60) Default Null,
    City Varchar(15) Default Null,
    Region Varchar(15) Default Null,
    PostalCode Varchar(10) Default Null,
    Country Varchar(15) Default Null,
    Phone Varchar(24) Default Null,
    Fax Varchar(24) Default Null,
    Primary Key (CustomerID),
    Key idx_City (City),
    Key idx_CompanyName (CompanyName),
    Key idx_PostalCode (PostalCode),
    Key idx_Region (Region)
) Engine=InnoDB Default Charset=utf8;

-- Shippers
Drop Table If Exists shippers;
Create Table shippers (
    ShipperID int(11) Not Null Auto_Increment,
    CompanyName Varchar(40) Not Null,
    Phone Varchar(24) Default Null,
    Primary Key (ShipperID)
) Engine=InnoDB Auto_Increment=4 Default Charset=utf8;

-- Suppliers
Drop Table If Exists suppliers;
Create Table suppliers (
    SupplierID int(11) Not Null Auto_Increment,
    CompanyName Varchar(40) Not Null,
    ContactName Varchar(30) Default Null,
    ContactTitle Varchar(30) Default Null,
    Address Varchar(60) Default Null,
    City Varchar(15) Default Null,
    Region Varchar(15) Default Null,
    PostalCode Varchar(10) Default Null,
    Country Varchar(15) Default Null,
    Phone Varchar(24) Default Null,
    Fax Varchar(24) Default Null,
    HomePage Mediumtext,
    Primary Key (SupplierID),
    Key idx_CompanyName (CompanyName),
    Key idx_PostalCode (PostalCode)
) Engine=InnoDB Auto_Increment=30 Default Charset=utf8;

-- Orders
Drop Table If Exists orders;
Create Table orders (
    OrderID int(11) Not Null Auto_Increment,
    CustomerID Varchar(5) Default Null,
    EmployeeID int(11) Default Null,
    OrderDate Datetime Default Null,
    RequiredDate Datetime Default Null,
    ShippedDate Datetime Default Null,
    ShipVia int(11) Default Null,
    Freight Decimal(10,4) Default '0.0000',
    ShipName Varchar(40) Default Null,
    ShipAddress Varchar(60) Default Null,
    ShipCity Varchar(15) Default Null,
    ShipRegion Varchar(15) Default Null,
    ShipPostalCode Varchar(10) Default Null,
    ShipCountry Varchar(15) Default Null,
    Primary Key (OrderID),
    Key idx_fk_CustomerID (CustomerID),
    Key idx_fk_EmployeeID (EmployeeID),
    Key idx_fk_ShipVia (ShipVia),
    Key idx_OrderDate (OrderDate),
    Key idx_ShippedDate (ShippedDate),
    Key idx_ShipPostalCode (ShipPostalCode),
    Constraint fk_orders_customer Foreign Key (CustomerID) References customers(CustomerID)
        On Delete Restrict On Update Cascade,
    Constraint fk_orders_employees Foreign Key (EmployeeID) References employees(EmployeeID)
        On Delete Restrict On Update Cascade,
    Constraint fk_orders_shippers Foreign Key (ShipVia) References shippers(ShipperID)
        On Delete Restrict On Update Cascade
) Engine=InnoDB Auto_Increment=11078 Default Charset=utf8;

-- Products
Drop Table If Exists products;
Create Table products (
    ProductID int(11) Not Null Auto_Increment,
    ProductName Varchar(40) Not Null,
    SupplierID int(11) Default Null,
    CategoryID int(11) Default Null,
    QuantityPerUnit Varchar(20) Default Null,
    UnitPrice Decimal(10,4) Default '0.0000',
    UnitsInStock Smallint Default 0,
    UnitsOnOrder Smallint Default 0,
    ReorderLevel Smallint Default 0,
    Discontinued tinyint(1) Default 0,
    Primary Key (ProductID),
    Key idx_fk_CategoryID (CategoryID),
    Key idx_fk_SupplierID (SupplierID),
    Key idx_ProductName (ProductName),
    Constraint fk_products_categories Foreign Key (CategoryID) References categories(CategoryID)
        On Delete Restrict On Update Cascade,
    Constraint fk_products_suppliers Foreign Key (SupplierID) References suppliers(SupplierID)
        On Delete Restrict On Update Cascade
) Engine=InnoDB Auto_Increment=78 Default Charset=utf8;

-- Order Details
Drop Table If Exists order_details;
Create Table order_details (
    OrderID int(11) Not Null,
    ProductID int(11) Not Null,
    UnitPrice Decimal(10,4) Not Null Default 0.0000,
    Quantity Smallint Not Null Default 1,
    Discount float Not Null Default 0,
    Primary Key (OrderID, ProductID),
    Key fk_idx_OrderID (OrderID),
    Key fk_idx_ProductID (ProductID),
    Constraint fk_order_details_orders Foreign Key (OrderID) References orders(OrderID)
        On Delete Restrict On Update Cascade,
    Constraint fk_order_details_products Foreign Key (ProductID) References products(ProductID)
        On Delete Restrict On Update Cascade
) Engine=InnoDB Default Charset=utf8;

-- Customer Demographics
Drop Table If Exists customer_demographics;
Create Table customer_demographics (
    CustomerTypeID Varchar(10) Not Null,
    CustomerDesc Text,
    Primary Key (CustomerTypeID)
) Engine=InnoDB Default Charset=utf8;

-- Customer Customer Demo
Drop Table If Exists customer_customer_demo;
Create Table customer_customer_demo (
    CustomerID Varchar(5) Not Null,
    CustomerTypeID Varchar(10) Not Null,
    Primary Key (CustomerID, CustomerTypeID),
    Constraint fk_CustomerTypeID Foreign Key (CustomerTypeID) References customer_demographics(CustomerTypeID)
        On Delete Restrict On Update Cascade
) Engine=InnoDB Default Charset=utf8;

-- Region
Drop Table If Exists region;
Create Table region (
    RegionID int Not Null,
    RegionDescription Varchar(50) Not Null,
    Primary Key (RegionID)
) Engine=InnoDB Default Charset=utf8;

-- Territories
Drop Table If Exists territories;
Create Table territories (
    TerritoryID Varchar(20) Not Null,
    TerritoryDescription Varchar(50) Not Null,
    RegionID int Not Null,
    Primary Key (TerritoryID),
    Constraint fk_territories_region Foreign Key (RegionID) References region(RegionID)
        On Delete Restrict On Update Cascade
) Engine=InnoDB Default Charset=utf8;

-- Employee Territories
Drop Table If Exists employee_territories;
Create Table employee_territories (
    EmployeeID int(11) Not Null,
    TerritoryID Varchar(20) Not Null,
    Primary Key (EmployeeID, TerritoryID),
    Constraint fk_employee_territories_employees Foreign Key (EmployeeID) References employees(EmployeeID)
        On Delete Restrict On Update Cascade,
    Constraint fk_employee_territories_territories Foreign Key (TerritoryID) References territories(TerritoryID)
        On Delete Restrict On Update Cascade
) Engine=InnoDB Default Charset=utf8;
