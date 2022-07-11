USE zonaprop;

SELECT *
FROM zonaprop_data;


-- Seeing the average price of BUYING a property in each CABA neighborhood

SELECT l3, AVG(price) AS AVGprice 
FROM zonaprop_data
WHERE operation_type = 'Venta' AND l3 IS NOT NULL
GROUP BY l3
HAVING AVG(price) IS NOT NULL 
ORDER BY AVGprice;

-- Seeing the average price of BUYING a living property in each CABA neighborhood -- H5

SELECT l3, AVG(price) AS AVGprice, COUNT(l3) AS count, AVG(surface_total) AS surface
FROM zonaprop_data
WHERE operation_type = 'Venta' 
AND l3 IS NOT NULL 
AND property_type LIKE('Departamento') OR property_type LIKE('PH') OR property_type LIKE('Casa') 
GROUP BY l3
HAVING AVG(price) IS NOT NULL 
ORDER BY AVGprice;

-- Seeing the average price of RENTING an apartment in each CABA neighborhood -- H5

SELECT AVG(lat),AVG(lon), l3, AVG(price) AS AVGprice, COUNT(price) AS countApartments--, AVG(surface_total) AS surface
FROM zonaprop_data
WHERE operation_type = 'Alquiler' 
AND l3 IS NOT NULL 
AND property_type LIKE('Departamento') --OR property_type LIKE('Casa') OR property_type LIKE('PH')-- 
AND price < 10000 AND price > 0
GROUP BY l3
HAVING AVG(price) IS NOT NULL 
ORDER BY AVGprice DESC;


-- Seeing the average price of RENTING a FLAT in each CABA neighborhood -- H6?

SELECT l3, AVG(price) AS AVGprice, COUNT(l3) AS count, AVG(surface_total) AS surface
FROM zonaprop_data
WHERE operation_type = 'Alquiler' 
AND l3 IS NOT NULL 
AND property_type LIKE('Departamento')
GROUP BY l3
HAVING AVG(price) IS NOT NULL 
ORDER BY AVGprice;

-- Seeing RENTING vs SELLING vs TEMPORAL RENTING in each neighborhood -- H2

SELECT operation_type, COUNT(operation_type) AS op_type_count, l3
FROM zonaprop_data
WHERE l3 IS NOT NULL
GROUP BY l3, operation_type
ORDER BY l3, op_type_count;

-- Seeing the price per sqMeter in selling properties per neighborhood -- H3

SELECT (SUM(price)/SUM(surface_total)) AS price_surface_ratio, l3
FROM zonaprop_data
WHERE operation_type = 'Venta' 
AND l3 IS NOT NULL
AND surface_total <> 0
AND price <> 0
AND property_type LIKE('Departamento') OR property_type LIKE('PH') OR property_type LIKE('Casa') 
GROUP BY l3
ORDER BY price_surface_ratio DESC;

-- Average sqMeter price in CABA --H6
SELECT (SUM(price)/SUM(surface_total)) AS price_surface_ratio
FROM zonaprop_data
WHERE operation_type = 'Venta' 
--AND property_type LIKE('Departamento') OR property_type LIKE('PH') OR property_type LIKE('Casa') 

-- Neighborhoods with more offer -- H4
SELECT l3, COUNT(l3) AS count_per_neighborhood
FROM zonaprop_data
WHERE l3 IS NOT NULL
GROUP BY l3
ORDER BY count_per_neighborhood DESC


-- Seeing the average price of BUYING PARKING in each CABA neighborhood -- C1

SELECT l3, AVG(price) AS AVGprice, COUNT(l3), AVG(surface_total)
FROM zonaprop_data
WHERE operation_type = 'Venta' 
AND l3 IS NOT NULL 
AND property_type LIKE('Cochera')
AND surface_total < 20
AND price <  70000 AND price > 1000
GROUP BY l3
HAVING AVG(price) IS NOT NULL AND COUNT(l3) >10
ORDER BY AVGprice DESC;

-- Seeing Comercial properties in each neighbourhood ordered by price per sqMeter -- C2

SELECT l3, AVG(price)/AVG(surface_total) AS AVGpricePerSqMeter, COUNT(l3) AS quantity, AVG(price) AS price, AVG(surface_total) AS surface
FROM zonaprop_data
WHERE operation_type = 'Venta' 
AND l3 IS NOT NULL 
AND property_type NOT IN ('Departamento','PH','Casa')
GROUP BY l3
HAVING AVG(price) IS NOT NULL 
ORDER BY AVGpricePerSqMeter DESC;

-- Comercial Property Type Quantities -- C3

SELECT property_type, COUNT(property_type) AS Quantity
FROM zonaprop_data
WHERE l3 IS NOT NULL 
AND property_type NOT IN ('Departamento','PH','Casa')
GROUP BY property_type
ORDER BY Quantity DESC

