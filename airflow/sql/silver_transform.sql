INSERT INTO silver.house_price (
	id, price, date_of_transfer, postcode, property_type, new_build, tenure, street, district, town_city, county
)
SELECT 
	id, price, date_of_transfer, postcode,
	CASE 
		WHEN property_type = 'D' THEN 'Detached'
		WHEN property_type = 'S' THEN 'Semi-detached'
		WHEN property_type = 'T' THEN 'Terraced'
		WHEN property_type = 'F' THEN 'Flat'
		WHEN property_type = 'O' THEN 'Other' END property_type,
	CASE
		WHEN new_build = 'Y' THEN 'Yes'
		WHEN new_build = 'N' THEN 'No' END new_build,
	CASE
		WHEN tenure = 'L' THEN 'Leasehold'
		WHEN tenure = 'F' THEN 'Freehold' END tenure,
	street, district, town_city, county
FROM bronze.house_price
;