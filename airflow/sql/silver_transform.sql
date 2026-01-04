UPDATE house_price
SET property_type = 
CASE 
	WHEN  property_type = 'D' THEN 'Detached'
	WHEN property_type = 'S' THEN 'Semi-detached'
	WHEN property_type = 'T' THEN 'Terraced'
	WHEN property_type = 'F' THEN 'Flat'
	WHEN property_type = 'O' THEN 'Other' END
WHERE property_type IS NOT NULL
; 

UPDATE house_price
SET new_build =
CASE
	WHEN new_build = 'Y' THEN 'Yes'
	WHEN new_build = 'N' THEN 'No' END
WHERE new_build IS NOT NULL
;

UPDATE house_price
SET tenure =
CASE
	WHEN tenure = 'L' THEN 'Leasehold'
	WHEN tenure = 'F' THEN 'Freehold' END
WHERE tenure IS NOT NULL	
;