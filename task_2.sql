SET @Year = 2019;

SELECT Distinct BookInfo.AuthorID,BookInfo.FirstName,BookInfo.LastName,BookInfo.MiddleName
FROM(
SELECT A.BookID
FROM (  
  SELECT BookID, COUNT(DISTINCT StudentID) AS pop
  FROM handout AS A
  WHERE YEAR(TakenAT)=@Year
  GROUP BY BookID 
) AS A LEFT OUTER JOIN ( 
  SELECT BookID, COUNT(DISTINCT StudentID) AS pop
  FROM handout 
  WHERE YEAR(TakenAT)=@Year
  GROUP BY BookID
) AS B
on A.BookID != B.BookID and A.pop>B.pop
WHERE b.BookID is NULL ) AS PopBooks
JOIN 
  (
  SELECT b.id,b.AuthorID,a.FirstName,a.LastName,a.MiddleName
  FROM book as b JOIN author as a ON b.AuthorID = a.AuthorID 
  ) AS BookInfo
 ON PopBooks.BookID=BookInfo.id;
