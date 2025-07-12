-- Table 1
CREATE TABLE HIV_North_America_Info
(
Country TEXT,
Country_Code TEXT,
Reporting_Year TEXT,
Total_Current_HIV_Cases NUMERIC,
Total_Deaths NUMERIC,
Children_with_HIV NUMERIC,
New_HIV_Cases NUMERIC,
Women_with_HIV_Percentage NUMERIC,
HIV_Mortality_Rate NUMERIC,
Proportion_of_New_Cases_in_Children NUMERIC
);

-- Insert data into the table using the SELECT query
INSERT INTO HIV_North_America_Info
SELECT
    T1.Country AS Country,
    T1.Code AS Country_Code,
    T1.Year AS Reporting_Year,
    T3.Current_Number AS Total_Current_HIV_Cases,
    T1.Deaths AS Total_Deaths,
    T2.Children_under14 AS Children_with_HIV,
    T3.New_Cases AS New_HIV_Cases,
    T4.Women AS Women_with_HIV_Percentage,
    -- KPI 1: HIV Mortality Rate
    (T1.Deaths / T3.Current_Number) * 1000 AS HIV_Mortality_Rate,
    -- KPI 2: Proportion of New HIV Cases in Children
    (T2.Children_under14 / (T2.Children_under14 + T3.New_Cases)) * 100 AS Proportion_of_New_Cases_in_Children
FROM 
    Annual_Number_of_Deaths T1
JOIN 
    Children_Living_with_HIV T2 ON T1.Year = T2.Year
JOIN 
    Deaths_and_New_Cases_of_HIV T3 ON T1.Country = T3.Country AND T1.Year = T3.Year
JOIN 
    Share_of_Women_Among_the_Population_Living_with_HIV T4 ON T1.Country = T4.Country AND T1.Year = T4.Year
WHERE 
    T1.Country IN ('Canada', 'United States', 'Bermuda', 'North America')
    AND T1.Year IN (2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016)
GROUP BY 
    T1.Country, T1.Year
ORDER BY 
    T1.Country, T1.Year;
	
-- Table 2
SELECT * FROM Country_Info;

-- Table 1 with Table 2 as Whole data. Will export the output as final joined dataset.
SELECT * 
FROM HIV_North_America_Info h1
JOIN Country_Info h2
ON h1.Country = h2.Country AND h1.Reporting_Year = h2.Year;

-- Number of people living with HIV by country population
SELECT
    HNI.Country AS Country,
    HNI.Country_Code AS Country_Code,
    HNI.Reporting_Year AS Reporting_Year,
    HNI.Total_Current_HIV_Cases AS Total_Current_HIV_Cases,
    HNI.Total_Deaths AS Total_Deaths,
    HNI.Children_with_HIV AS Children_with_HIV,
    HNI.New_HIV_Cases AS New_HIV_Cases,
    HNI.Women_with_HIV_Percentage AS Women_with_HIV_Percentage,
    HNI.HIV_Mortality_Rate AS HIV_Mortality_Rate,
    HNI.Proportion_of_New_Cases_in_Children AS Proportion_of_New_Cases_in_Children,
    -- Calculate the "number of people living with HIV" by country population
    (HNI.Total_Current_HIV_Cases / CI.Country_Population) * 100 AS People_with_HIV_Percentage
FROM 
    HIV_North_America_Info HNI
JOIN 
    Country_Info CI ON HNI.Country = CI.Country AND HNI.Reporting_Year = CI.Year;


