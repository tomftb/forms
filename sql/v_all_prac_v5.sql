Create view `v_all_prac_v5` as 
select 
`id` as `ID`
, CONCAT(`imie`,' ',`nazwisko`) as `ImieNazwisko`
,`stanowisko` as `Stanowisko`
, '0' as `Procent`
,`email` as `Email` 
from `employee`;