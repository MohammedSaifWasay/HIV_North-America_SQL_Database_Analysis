CREATE TABLE HIV (
Country TEXT,
Year TEXT,
Estimated_People_with_HIV Numeric,
Estimated_Deaths Numeric,
Estimated_Women_15_and_Older Numeric,
Percent_of_Pregnant_Women Numeric,
Mother_to_Child_Rate Numeric,
YTY_Cases_Change Numeric
)


SELECT 
DISTINCT
H1.Country_Display AS Country,
H1.Year_Display AS Year,
SUM(H1.Numeric_Value) AS Estimated_People_with_HIV,
SUM(H4.Numeric_Value) AS Estimated_Deaths,
SUM(H3.Numeric_Value) AS Estimated_Women_15_and_Older,
SUM(H2.Numeric_Value) AS Percent_of_Pregnant_Women
FROM
HIV_Estimated_Number_of_People_3_Final H1
JOIN HIV_Estimated_number_of_Preg_Women_Final H2
ON H1.Year_Display = H2.Year_Display AND H1.Country_Display = H2.Country_Display
JOIN HIV_Gender_Based_Final H3
ON H3.SpatialDim_En = H1.Country_Display AND H3.TimeDim = H1.Year_Display
JOIN HIV_Mortality_Rate_Final H4
ON H1.Year_Display = H4.Year_Display AND H1.Region_Display = H4.Region_Display
WHERE H1.Year_Display in (2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016) AND H1.Country_Display in ('Canada', 'Mexico', 'United States of America')
GROUP BY H1.Country_Display, H1.Year_Display
ORDER BY H1.Country_Display, H1.Year_Display;



SELECT H5.Country_Region AS Country,
H5.Year AS Year FROM HIV_Mother_to_Child_Final H5
WHERE H5.Country_Region = 'Latin America and Caribbean' AND H5.Year in (2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016);

