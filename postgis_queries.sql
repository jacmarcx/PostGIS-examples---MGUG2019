---------------------------------------------------------------
-------  DEMO USING POSTGIS QUERIES: ELECTION BOUNDARIES ------
---------------------------------------------------------------

-- The goal of this exercise is to show basic functions using Postgis.
-- We will show how to load, filter and transform spatial data.
-- The objective below is to take the Province of Manitoba electoral map, and remove the surface area that
-- represents major waterways in order to make the map more graphically pleasing and also to make any sort
-- of spatial analaysis more valid by not including locations that logically cannot contain voters (i.e. the middle of a lake).


-- Select all ridings province-wide
SELECT *
FROM ed2018;


-- Single riding selection
SELECT *
FROM ed2018
WHERE ed_name = 'River Heights';


-- Selecy Winnipeg Ridings only
SELECT *
FROM ed2018
WHERE ed_name IN ('River Heights','Fort Rouge','Fort Garry','Fort Whyte',
				  'Waverley','Fort Richmond','Tuxedo','Charleswood',
				  'Transcona','Seine River','Lagimodiere','Riel','St. Vital',
				  'Southdale','St. Boniface','Radisson','Concordia','Elmwood',
				  'Kildonan','Kirkfield Park','Assiniboia','Rossmere','Wolseley',
				  'Union Station','Notre Dame','Point Douglas','St. Johns','Burrows',
				  'St. James','Tyndall Park','The Maples','Garden City');
          
          
-- Selecy entire water layer
SELECT
	geom
FROM water;


-- Merge water layer into a single polygon
SELECT
	ST_Union(geom) as geom
FROM water;


-- Use merged water layer to "punch a hole" (Difference operation) into the riding boundary file
-- Use water union as Common Table Expression (CTE)
WITH water_merge AS (

SELECT
	ST_Union(geom) as geom
FROM water
)

SELECT
	e.ed_num,
	e.ed_name,
	ST_Difference(e.geom, w.geom) as geom
FROM ed2018 as e
LEFT JOIN water_merge as w
	ON ST_Intersects(e.geom, w.geom);
  

-- The above only returned elements that intersected with the water.
-- We also want all the boundaries that did not intersect, so we can rebuild the entire election map minus the water.
-- Use SQL claus COALESCE to include non intersecting components
WITH water_merge AS (

SELECT
	ST_Union(geom) as geom
FROM water
)

SELECT
	e.ed_num,
	e.ed_name,
	COALESCE(ST_Difference(e.geom, w.geom),e.geom) as geom
FROM ed2018 as e
LEFT JOIN water_merge as w
	ON ST_Intersects(e.geom, w.geom);
