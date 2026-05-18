# Write your MySQL query statement below
    with temp as
    (
        select distinct a.user_id, b.category
        from productpurchases a 
            left join productinfo b on a.product_id = b.product_id
    ),
    temp2 as 
    (
        select t1.user_id, t1.category as category1, t2.category as category2 
        from temp t1
            left join temp t2 on t1.user_id = t2.user_id
    )
    select category1, category2, count(distinct user_id) as customer_count
    from temp2 
    where category1 < category2 
    group by category1, category2
    having count(distinct user_id) >= 3
    order by customer_count desc, category1, category2
    
    