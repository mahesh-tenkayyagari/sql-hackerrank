Generate the following two result sets:

1) Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2) Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format: 
There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

SQL:-
/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

SELECT 
TXT
FROM
(
SELECT 
CAST(NAME||'('||SUBSTR(OCCUPATION,1,1)||')' AS VARCHAR2(255)) AS TXT,
ROW_NUMBER() OVER (ORDER BY NAME ASC) AS SEQ
FROM
OCCUPATIONS
UNION
SELECT
TXT,
MAX_TOT+ROW_NUMBER() OVER(ORDER BY TOT,OCCUPATION) AS SEQ
FROM
(
SELECT 
DISTINCT 
CAST('There are a total of '||COUNT(*) OVER(PARTITION BY OCCUPATION)
||' '||
(CASE WHEN OCCUPATION='Doctor' THEN 'doctors.'
     WHEN OCCUPATION='Singer' THEN 'singers.'
     WHEN OCCUPATION='Actor' THEN 'actors.'
     WHEN OCCUPATION='Professor' THEN 'professors.'
END) AS VARCHAR2(255))  AS TXT,
COUNT(*) OVER(PARTITION BY OCCUPATION) AS TOT,
COUNT(*) OVER(PARTITION BY 1) AS MAX_TOT,
OCCUPATION
FROM
OCCUPATIONS
)
)
ORDER BY SEQ;
