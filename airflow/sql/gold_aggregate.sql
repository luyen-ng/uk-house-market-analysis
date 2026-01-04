truncate table public.house_adjusted_price;

insert into public.house_adjusted_price (id, price, adjusted_price, date_of_transfer, postcode, property_type, new_build, tenure, street, district, town_city, county)
select h.id, h.price
, round(h.price*100.0/value,2) adjusted_price
, h.date_of_transfer, h.postcode
, h.property_type, h.new_build, h.tenure
, h.street, h.district, h.town_city, h.county
from public.house_price h 
left join public.cpi c
on DATE_TRUNC('month', date_of_transfer)::date = cpi_month
where postcode is not null;