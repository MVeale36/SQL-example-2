explain analyze
Select clb.f_name, clb.l_name, noofbooks
from (
        select f_name,
            l_name,
            count(*) as noofbooks
        from customer
            natural join loaned_book
        group by f_name,
            l_name
    ) as clb
where 3 > (
        select count(*)
        from (
                select f_name,
                    l_name,
                    count(*) as noofbooks
                from customer
                    natural join loaned_book
                group by f_name,
                    l_name
            ) as clb1
        where clb.noofbooks < clb1.noofbooks
    )
order by noofbooks desc;