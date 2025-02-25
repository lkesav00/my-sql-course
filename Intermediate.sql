

SELECT * FROM DimHospital


/*

Foundation Recap Exercise
 
Use the table PatientStay.  

This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024

*/
 
SELECT

	*

FROM

	PatientStay ps ;
 
/*

1. Filter the list the patients to show only those  -

a) in the Oxleas hospital,
*/
SELECT *
FROM PatientStay ps 
where Hospital = 'Oxleas'

/*
b) and also in the PRUH hospital,

SELECT *
FROM PatientStay ps 
where Hospital in ('Oxleas', 'PRUH')
*/

/*

c) admitted in February 2024

d) only the surgical wards (i.e. wards ending with the word Surgery) 
 
2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.

3. Order results by AdmittedDate (latest first) then PatientID column (high to low)

4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.

*/
 
-- Write the SQL statement here
 
 SELECT ps.PatientId
 ,ps.AdmittedDate
 ,ps.DischargeDate
 ,ps.Hospital
 ,ps.ward
FROM PatientStay ps 
where Hospital in ('Oxleas', 'PRUH')

SELECT *
FROM PatientStay ps 
where AdmittedDate between '2024-02-01' and  '2024-02-28'
and ward like 'D%'



Select ps.PatientId, 
        ps.AdmittedDate, 
        ps.DischargeDate, 
        ps.Hospital
 from PatientStay ps 

Select ps.PatientId, 
        ps.AdmittedDate, 
        ps.DischargeDate, 
        ps.Hospital
 from PatientStay ps 
order by ps.AdmittedDate desc , ps.PatientId desc


Select ps.PatientId, 
        ps.AdmittedDate, 
        ps.DischargeDate, 
        ps.Hospital,
        DATEDIFF(day,ps.AdmittedDate,ps.DischargeDate) as LOS
 from PatientStay ps 
order by ps.AdmittedDate desc , ps.PatientId desc



Select ps.PatientId, 
        ps.AdmittedDate, 
        ps.DischargeDate, 
        ps.Hospital,
        DATEDIFF(day,ps.AdmittedDate,ps.DischargeDate) +1 as LOS
 from PatientStay ps 
order by ps.AdmittedDate desc , ps.PatientId desc


 
/*

5. How many patients has each hospital admitted? 

6. How much is the total tarriff for each hospital?

7. List only those hospitals that have admitted over 10 patients

8. Order by the hospital with most admissions first

*/
 
-- Write the SQL statement here
 
select count(*), ps.Hospital
from PatientStay ps
group by ps.Hospital





/*
Pivot and unpivot
 
Prompt for an AI tool:
Act as a Microsoft T-SQL expert. Table Message has column Category (varchar), Region (varchar), Movement (int).
There are four unique values in the Region column: North, South, East and West
Write the SQL to pivot the table.  
The resulting dataset should have columns: Category, North, South, East and West
 
Then write the SQL to unpivot the pivoted table back to the original table.
*/
-- The sample data
SELECT
	m.Category
	,	m.Region
	,	m.Movement
FROM
	Message m;
 
-- Pivot by Region
SELECT
	[Category]
	, [North]
	, [East]
	, [South]
	, [West]
FROM
	(
	SELECT
		m.Category
		, m.Region
		, m.Movement
	FROM
		Message m) temp_table
PIVOT
(
    SUM(Movement)
    FOR Region IN (North, East, South, West)
) AS pivot_table
 
 
-- the long way to pivot
 
SELECT
	m.Category
	, SUM(CASE WHEN m.Region = 'North' THEN m.Movement ELSE NULL END) AS NorthMovement
	, SUM(CASE WHEN m.Region = 'South' THEN m.Movement ELSE NULL END) AS SouthMovement
	, SUM(CASE WHEN m.Region = 'East' THEN m.Movement ELSE NULL END) AS EastMovement
	, SUM(CASE WHEN m.Region = 'West' THEN m.Movement ELSE NULL END) AS WestMovement
FROM
	Message m
GROUP BY
	m.Category;
 
 
-- Create a  pivoted temporary table so can unpivot later
DROP TABLE IF EXISTS #PivotMessageTable;
 
SELECT
	[Category]
	, [North]
	, [East]
	, [South]
	, [West]
INTO
	#PivotMessageTable
FROM
	(
	SELECT
		m.Category
		, m.Region
		, m.Movement
	FROM
		Message m) temp_table
PIVOT
(
    SUM(Movement)
    FOR Region IN (North, East, South, West)
) AS pivot_table;
 
SELECT
	*
FROM
	#PivotMessageTable;
 
-- Unpivot this table to get back to the original table
SELECT
	Category
	, Region
	, Movement
FROM
	#PivotMessageTable
UNPIVOT
(
    Movement FOR Region IN (North, East, South, West)
) AS unpivot_table
 
-- An alternative way to unpivot not using the UNPIVOT keyword
SELECT 	Category, North AS Movement FROM #PivotMessageTable
UNION ALL
SELECT 	Category, South AS Movement FROM #PivotMessageTable
UNION ALL
SELECT 	Category, East AS Movement FROM #PivotMessageTable
UNION ALL
SELECT 	Category, West AS Movement FROM #PivotMessageTable





select  *
from PatientStay ps
group by ps.Hospital




 select count(*), ps.Hospital
from PatientStay ps
group by ps.Hospital
having count(*) > 10


SELECT
    ps.Hospital
    , count(*) as NumPatients
    , sum(ps.Tariff) AS TotalTariff
    ,avg(ps.Tariff) AS AverageTariff
from PatientStay ps
GROUP BY ps.Hospital
having count(*) > 10
ORDER BY NumPatients desc
 
 
DROP TABLE IF EXISTS #EDD
 
 
IF OBJECT_ID('tempdb..#EDD') IS NOT NULL DROP TABLE #EDD
 
SELECT
    m.Category
    , CASE WHEN m.Region = 'North' THEN m.Movement ELSE NULL END AS NorthMovement
    , CASE WHEN m.Region = 'South' THEN m.Movement ELSE NULL END AS SouthMovement
    , CASE WHEN m.Region = 'East' THEN m.Movement ELSE NULL END AS EastMovement
    , CASE WHEN m.Region = 'West' THEN m.Movement ELSE NULL END AS WestMovement
FROM
    Message m
 
 


 select top 10 ps.patientDI
 from patientstay ps


;
with CTE1 as (
 SELECT
    TOP 10
    ps.PatientId
    ,ps.Tariff
FROM
    PatientStay ps
ORDER BY ps.Tariff DESC
) select sum (tariff) as Total_tariff from CTE1;

select tariff from
(SELECT
    TOP 10
    ps.PatientId
    ,ps.Tariff
FROM
    PatientStay ps
ORDER BY ps.Tariff DESC)

