USE northwind;
SELECT * FROM `alphabetical list of products`;
SELECT * FROM `product sales for 1997`;

SELECT categories.CategoryName,products.ProductName,SUM(`order details`.UnitPrice*Quantity*(1-Discount)) AS sales 
FROM (categories JOIN products ON categories.CategoryID = products.CategoryID)
	JOIN 
	`order details` ON products.ProductID = `order details`.ProductID
GROUP BY products.ProductID;

SELECT * FROM `Product Sales for 1997`;