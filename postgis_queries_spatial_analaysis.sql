  
---------------------------------------------------------------
-------  DEMO USING POSTGIS QUERIES: SPATIAL ANALYSIS ------
---------------------------------------------------------------

-- The goal of this exercise is to show basic functions using Postgis, including measuring distance between objects.
-- The objective below is to find out which politicians live in the riding their are running in, and if they don't
-- live in their riding, how far do they live away from the nearest boundary.

-- add empty GEOMETRY column to you basic CSV table that contains latitude and longitude
-- Must use ESPG code 4326 (i.e. WSG84) when converting decimal degrees. Can change CRS later.
SELECT addgeometrycolumn('addresses', 'geom', 4326,'POINT',2);


-- now populate that empty GEOMETRY column (i.e. update in SQL speak) using your lat and long columns from your CSV table.
-- GEOMETRY column is stored as long hexadecimal value
-- Sometimes decimal value is stored as text, rather than real number, so force datatype to NUMERIC (this used postgresql syntax)
UPDATE addresses
    SET geom = ST_SetSRID(ST_POINT("longitude"::NUMERIC, "latitude"::NUMERIC),4326)
    

-- Get distance from riding for each candidate's home address
-- Home address POINTs are currently not projected (spatial reference identifier "SRID" = 4326, WGS84)
-- Therefore in order to measure distance in metric measurements, transform CRS on the fly to ESPG 26914
-- Note: this is not a spatial join. This is an attribute join.
-- This query will return a table with the candiate's name, party name and distance from their home and the riding they are running in.
-- If the candidate lives inside the riding their are running in distance will be zero.
SELECT
	a.candidate,
	a.party,
	ST_Distance(ST_Transform(a.geom,26914), ST_Transform(e.geom,26914))::NUMERIC as distance_meters
FROM addresses as a
JOIN ed2018 as e
	ON a.ed_run = e.ed_name;
