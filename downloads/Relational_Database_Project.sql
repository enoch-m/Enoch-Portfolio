CREATE TABLE Customer (
	CustomerID INT PRIMARY KEY,
	CustLName VARCHAR(50),
    CustFName VARCHAR(50),
    CustPhone VARCHAR(15)
);
INSERT INTO Customer (CustomerID, CustLName, CustFName, CustPhone)
VALUES
    (1, 'Johnson', 'Emma', '1234567890'),
    (2, 'Williams', 'Daniel', '9876543210'),
    (3, 'Brown', 'Olivia', '5551234567'),
    (4, 'Jones', 'Liam', '7779998888'),
    (5, 'Garcia', 'Sophia', '3216549870'),
    (6, 'Martinez', 'Noah', '9998887777'),
    (7, 'Miller', 'Isabella', '4445556666'),
    (8, 'Davis', 'William', '8887779999'),
    (9, 'Rodriguez', 'Ava', '2223334444'),
    (10, 'Martinez', 'James', '6667778888');

CREATE TABLE Chef (
	ChefID INT PRIMARY KEY,
    ChefLName VARCHAR(50),
    ChefFName VARCHAR(50),
    ChefPhone VARCHAR(15)
);
INSERT INTO Chef (ChefID, ChefLName, ChefFName, ChefPhone)
VALUES
    (1001, 'Haze', 'Alanna', '5552238767'),
    (1002, 'Lindy', 'Charles', '5559876543'),
    (1003, 'Patti', 'Jaylyn', '5555551212'),
    (1004, 'Jeff', 'Karyn', '5558675309'),
    (1005, 'Jacklyn', 'Everitt', '5552345678'),
    (1006, 'Cleve', 'Lovell', '5553210987'),
    (1007, 'Bellamy', 'Fabian', '5557778888'),
    (1008, 'Oralee', 'Mabel', '5554567890'),
    (1009, 'Winslow', 'Mary', '5558889999'),
    (1010, 'Eve', 'Oli', '5556789012');

CREATE TABLE DiningTable (
    TableID INT PRIMARY KEY,
    TableSize INT,
    TableType VARCHAR(50)
);
INSERT INTO DiningTable (TableID, TableSize, TableType) 
VALUES 
(1, 4, 'Standard'),
(2, 2, 'Booth'),
(3, 4, 'Standard'),
(4, 2, 'Booth'),
(5, 6, 'Standard'),
(6, 4, 'Booth');

CREATE TABLE Dish (
	DishID INT PRIMARY KEY,
    ChefID INT,
    DishName VARCHAR(100),
    DishDescr VARCHAR(500),
    Cost DECIMAL(10, 2),
    DishType ENUM('Appetizer', 'Main Course', 'Dessert',
					'Beverage'),
	Vegetarian TINYINT(1),
    FOREIGN KEY (ChefID) REFERENCES Chef(ChefID)
);
INSERT INTO Dish (DishID, ChefID, DishName, DishDescr, Cost, DishType, Vegetarian)
VALUES
(101, 1001, 'Caprese Salad', 'Fresh tomatoes, mozzarella, basil, olive oil, and balsamic glaze.', 12.99, 'Appetizer', 1),
(102, 1002, 'Chicken Alfredo Pasta', 'Creamy Alfredo sauce with grilled chicken and pasta.', 16.99, 'Main Course', 0),
(103, 1003, 'Tiramisu', 'Classic Italian dessert made with ladyfingers, coffee, mascarpone cheese, and cocoa.', 8.50, 'Dessert', 1),
(104, 1004, 'Vegetable Stir-Fry', 'Assorted vegetables stir-fried in a savory sauce, served with rice.', 10.49, 'Main Course', 1),
(105, 1005, 'Margarita Pizza', 'Thin-crust pizza topped with fresh tomato sauce, mozzarella cheese, and basil leaves.', 14.99, 'Main Course', 1),
(106, 1006, 'Chocolate Lava Cake', 'Warm chocolate cake with a gooey chocolate center, served with vanilla ice cream.', 9.99, 'Dessert', 0),
(107, 1007, 'Spinach and Artichoke Dip', 'Creamy dip made with spinach, artichokes, and cheese, served with tortilla chips.', 11.49, 'Appetizer', 1),
(108, 1008, 'Grilled Salmon', 'Fresh salmon fillet grilled to perfection, served with roasted vegetables.', 18.99, 'Main Course', 0),
(109, 1009, 'Caesar Salad', 'Crisp romaine lettuce, croutons, Parmesan cheese, and Caesar dressing.', 10.99, 'Appetizer', 0),
(110, 1010, 'Fruit Salad', 'Assorted fresh fruits including strawberries, pineapple, grapes, and melon.', 7.99, 'Appetizer', 1);

CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
    CustomerID INT,
    DishID INT,
    OrderTime TIMESTAMP,
    Quantity INT,
    Specialreq VARCHAR(300) DEFAULT 'None',
    OrderProgress ENUM('Pending', 'Processing', 'Completed'),
    TotalCost DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (DishID) REFERENCES Dish(DishID)
);
ALTER TABLE Orders
ADD TableID INT;
INSERT INTO Orders (OrderID, CustomerID, DishID, OrderTime, Quantity, SpecialReq, 
					OrderProgress, TotalCost)
VALUES
(1, 1, 101, '2024-03-20 10:15:00', 2, 'Extra cheese', 'Completed', 25.98),
(2, 2, 102, '2024-03-20 12:30:00', 1, NULL, 'Completed', 10.50),
(3, 3, 103, '2024-03-20 13:45:00', 1, 'No onions', 'Pending', 10.49),
(4, 4, 104, '2024-03-20 14:00:00', 3, 'Extra spicy', 'Processing', 34.47),
(5, 5, 105, '2024-03-20 15:20:00', 1, 'Thin crust', 'Completed', 14.99),
(6, 6, 106, '2024-03-20 16:00:00', 2, NULL, 'Completed', 37.98),
(7, 7, 107, '2024-03-20 16:30:00', 1, 'No croutons', 'Completed', 10.99),
(8, 8, 108, '2024-03-20 17:45:00', 2, NULL, 'Completed', 15.98),
(9, 9, 109, '2024-03-20 18:00:00', 1, 'Extra sauce', 'Pending', 16.99),
(10, 10, 110, '2024-03-20 19:30:00', 2, NULL, 'Processing', 19.98);

CREATE TABLE Review (
	ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    DishID INT,
    CustomerID INT,
    Rating DECIMAL(3,2),
    Notes VARCHAR(300) DEFAULT 'None',
    DateRecorded DATE,
    ReviewTitle VARCHAR(100),
    ReviewType ENUM('Dish', 'Service'),
    FOREIGN KEY (DishID) REFERENCES Dish(DishID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(customerID)
);
INSERT INTO Review (DishID, CustomerID, Rating, Notes, DateRecorded,
					ReviewTitle, ReviewType)
VALUES
    (101, 1, 4.5, 'Delicious dish, highly recommended!', '2024-03-20', 'Amazing Dish!', 'Dish'),
    (102, 2, 3.8, 'Good but could be better with less salt', '2024-03-21', 'Needs Improvement', 'Dish'),
    (103, 3, 4.2, 'Great service, friendly staff', '2024-03-22', 'Excellent Service!', 'Service'),
    (104, 4, 4.0, 'Tasty but a bit too spicy for my liking', '2024-03-23', 'Spicy Delight', 'Dish'),
    (105, 5, 4.7, 'Absolutely loved it, will definitely order again!', '2024-03-24', 'Perfect Dish!', 'Dish'),
    (106, 6, 3.5, 'Average experience, nothing exceptional', '2024-03-25', 'Meh', 'Service'),
    (107, 7, 4.8, 'Fantastic dish, exceeded my expectations', '2024-03-26', 'Sensational!', 'Dish'),
    (108, 8, 3.0, 'Disappointing service, slow and unresponsive', '2024-03-27', 'Poor Service', 'Service'),
    (109, 9, 4.3, 'Delicious and perfectly cooked, loved it!', '2024-03-28', 'Yummy Dish', 'Dish'),
    (110, 10, 4.6, 'Great experience overall, will recommend to friends', '2024-03-29', 'Awesome Service!', 'Service');
    
/*Display customers and their orders*/
SELECT c.CustomerID, c.CustLName, c.CustFName, o.OrderID, o.OrderTime, d.DishName
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Dish d ON o.DishID = d.DishID;

/*display dishes with their chef and orderid */
SELECT d.DishName, c.ChefFName, c.ChefLName, o.OrderID, o.OrderTime
FROM Dish d
JOIN Chef c ON d.ChefID = c.ChefID
LEFT JOIN Orders o ON d.DishID = o.DishID;

/*display customers, orders, and their table */
SELECT c.CustomerID, c.CustFName, c.CustLName, o.OrderID, t.TableID, t.TableType
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN DiningTable t ON o.TableID = t.TableID;

/*display the customer's total cost */
SELECT c.CustomerID, c.CustFName, c.CustLName, SUM(o.TotalCost) AS TotalOrderCost
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustFName, c.CustLName;

/*display average cost of dishes by type */
SELECT d.DishType, AVG(d.Cost) AS AvgCost
FROM Dish d
GROUP BY d.DishType;

/*display the count of orders placed by each customer for each type */
SELECT c.CustomerID, c.CustFName, c.CustLName, d.DishType, COUNT(o.OrderID) AS OrderCount
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Dish d ON o.DishID = d.DishID
GROUP BY c.CustomerID, c.CustFName, c.CustLName, d.DishType;

/*display total cost of order placed by customer with their dining table types */
SELECT c.CustomerID, c.CustFName, c.CustLName, t.TableType, SUM(o.TotalCost) AS TotalOrderCost
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN DiningTable t ON o.TableID = t.TableID
GROUP BY c.CustomerID, c.CustFName, c.CustLName, t.TableType;