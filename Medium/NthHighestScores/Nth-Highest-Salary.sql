/* 
Problem: Nth Highest Salary
Source : Leetcode
Difficulty: Medium
*/

/* Problem Statement: 
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.

The result format is in the following example.
*/
/* 
Explaination:

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2: But if, the table is 

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
*/

/* Sotuion: */
/*
-------------------------------------------------------------------
Approach 1: Using User Defined Funciton + OFFSET
-------------------------------------------------------------------       
Idea:
1. First get Distinct Salaries
2. Sort them in descending order.
3. Skip N-1 rows
4. Fetch the next row->which will be the Nth Highest Salary
*/
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    IF @N<=0
       RETURN NULL
    RETURN (
        SELECT MAX(Salary)
        FROM (
            SELECT DISTINCT Salary
            FROM Employee
            ORDER BY Salary DESC
            OFFSET @N-1 ROWS
            FETCH NEXT 1 ROW ONLY
        ) AS Temp
    );
END

/* 
--------------------------------------------------------
Approach 2: Using DENSE_RANK & OFFSET CONCEPT 
--------------------------------------------------------
Idea:
1. First getting the Distinct Salaries & Assign ranks to salaries in descending order using dense_rank().
2. Same salaries receive the same rank 
3. select the salary whose rank = N
Reference for learning DENSE_RANK():
https://learn.microsoft.com/en-us/sql/t-sql/functions/dense-rank-transact-sql
*/
SELECT t.Salary FROM (
SELECT DISTINCT Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS D_R 
FROM Emp1
) AS t 
ORDER BY t.Salary DESC
OFFSET 4 ROWS
FETCH NEXT 1 ROW ONLY ;


