# MANDATORY PROJECT 
#1.Calculate average Unit Price for each CustomerId.
select CustomerId, UnitPrice,avg(UnitPrice) over (partition by CustomerID) as AvgUnitPrice 
from orders inner join order_details on orders.OrderID = order_details.OrderID
 
#2.Calculate average Unit Price for each group of CustomerId AND EmployeeId.
Select CustomerID, EmployeeID, UnitPrice ,avg(UnitPrice) over (partition by CustomerID,EmployeeID) AS AvgUnitPrice
from orders inner join order_details on orders.OrderID = order_details.OrderID

#3.Rank Unit Price in descending order for each CustomerId.
select CustomerID, UnitPrice,
rank() over (partition by CustomerID order by UnitPrice DESC)
AS UnitRank from orders inner join order_details on orders.OrderID = order_details.OrderID

#4.How can you pull the previous order date’s Quantity for each ProductId.
SELECT ProductID,OrderDate, Quantity,
LAG(Quantity) over (partition by ProductID)
as PreviousQuantity 
from orders inner join order_details on orders.OrderID = order_details.OrderID

# 5.How can you pull the following order date’s Quantity for each ProductId.
select ProductID, OrderDate, Quantity,
Lead(Quantity) over(partition by ProductID)
AS LeadingQuantity
from orders inner join order_details on orders.OrderID = order_details.OrderID

#6.Pull out the very first Quantity ever ordered for each ProductId.
Select ProductID, OrderDate, Quantity,
first_value(Quantity) over (partition by ProductID order by OrderDate) as FirstQuantity 
from orders inner join order_details on orders.OrderID = order_details.OrderID

#7.Calculate a cumulative moving average UnitPrice for each CustomerId.
SELECT CustomerId, UnitPrice, AVG(UnitPrice) OVER (PARTITION BY CustomerId ORDER BY CustomerId 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumAverage FROM orders
INNER JOIN order_details ON orders.OrderId = order_details.OrderId

 