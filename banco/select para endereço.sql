SELECT a.city as cidade, z.name as estado, c.name as Pais

FROM dd_address a

inner join dd_country c

on a.country_id = c.country_id

inner join dd_zone z
on a.zone_id = z.zone_id

group by a.city

order by a.city
