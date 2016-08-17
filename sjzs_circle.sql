#app_num_rec

#在QDAS-参与度-页面访问热度 中，可以通过页面ID查询助手各个页面的uv
#目标数据为页面id=app_num_rec
#希望查询该页面的浏览留存 
#时间区间：2016-6-23到2016-8-15


create table ysy_sjzs_app_num_rec
as
select distinct p_day_id,m2
from temp_qdas_activity_trend_daily
where p_day_id>=20160623 and p_day_id<=20160816 and appkey='3416a75f4cea9109507cacd8e2f2aefc' and page='app_num_rec'
;



select a.act_date,
    count(distinct a.m2) act_mids,
	count(distinct case when datediff(b.act_date,a.act_date)=1 then a.m2 end) remain1_mids,
	count(distinct case when datediff(b.act_date,a.act_date)=6 then a.m2 end) remain7_mids,
	count(distinct case when datediff(b.act_date,a.act_date)=14 then a.m2 end) remain15_mids,
	count(distinct case when datediff(b.act_date,a.act_date)=29 then a.m2 end) remain30_mids
from
(
    select concat(substr(p_day_id,1,4),'-',substr(p_day_id,5,2),'-',substr(p_day_id,7,2)) act_date,
        m2
    from ysy_sjzs_app_num_rec
) a
join
(
    select concat(substr(p_day_id,1,4),'-',substr(p_day_id,5,2),'-',substr(p_day_id,7,2)) act_date,
        m2
    from ysy_sjzs_app_num_rec
) b
on a.m2=b.m2
group by a.act_date
;



