/* Qns2). 
Write a SQL query to get the second highest salary from the Employee table.
For example, given the above Employee table, the query should return 200 as the
second highest salary. If there is no second highest salary, then the query
should return null.
TABLE:
+---------------------+
| id |  Salary        |
+---------------------+
| 1 |   100           |
+---------------------+
| 2 |   200           |
+---------------------+
| 3 |   300           |
+---------------------+

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200 |               |
+---------------------+

Solution: Here
          300: First-Highest-Salary,
		  200: Second-Highest-Salary
		  100: Third-Highest-Salary 
		  So, we'll use aggregated sql clause 
          and subquery concept where,
          MAX(Salary excluding First-Highest-Salary), which will get by applying aggregated max clause over 
		  inner query result, where inner query will be giving us the First-Highest-Salary
*/
SELECT max(Salary) AS SecondHighestSalary FROM Employee
WHERE Salary < ( SELECT max(Salary) FROM Employee);

-- OR USING THE CASE STATEMENTS --
SELECT 
    CASE 
	     WHEN COUNT(DISTINCT Salary) < 2 THEN NULL 
		 ELSE(
		     SELECT DISTINCT salary
             FROM Employee
             ORDER BY salary DESC
             OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
		 )
	END AS SecondHighestSalary
FROM Employee;