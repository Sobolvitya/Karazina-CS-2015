/*http://www2.sas.com/proceedings/sugi30/257-30.pdf*/

%let datapath = ~/my_content/Fall/Rawdata;
libname rawdata "&datapath";

/*proc contents data=rawdata._all_ nods;*/

/*================================ SIMPLE SELECT*/
proc SQL;
	select * from rawdata.deal_depo_chng
	where monotonic() < 20;
 
	select * from rawdata.deal_loan_chng
	where monotonic() < 20; 

run;

/*================================ GROUP BY*/
proc SQL;
	select distinct deal_ID from rawdata.deal_depo_chng
	where deal_ID < 30;

	select 
		deal_ID, 
		count(deal_ID) as N,
		sum(interest_amt) as interest_sum,
		min(interest_amt) as interest_min,
		avg(interest_amt) as interest_avg,
		max(interest_amt) as interest_max
	from rawdata.deal_depo_chng
	group by deal_id;
run;


/*================================ INNER JOIN*/
proc SQL;
	select 
		deal.customer_ID,
		deal.product_ID,
		deal.internal_org_ID,
		data.*		
	from		
		rawdata.deal_depo_chng AS data
		inner join rawdata.deal as deal
	on data.deal_ID = deal.deal_ID
	where data.deal_ID < 10
	order by customer_id;
run;



/*================================ GROUP BY WITH JOIN, HAVING*/
proc SQL;
	select 
		deal.customer_ID,
		sum(interest_amt) as interest_sum,
		count (distinct data.deal_ID) as deal_Count
	from		
		rawdata.deal_depo_chng AS data
		inner join rawdata.deal as deal
	on data.deal_ID = deal.deal_ID
	group by deal.customer_id
	having deal_count = 3;
run;

/*================================ DOUBLE SELECT*/
proc sql;
	select 
		max(deal_count) as max_count
	from(
		select 
			count (distinct data.deal_ID) as deal_Count
		from		
			rawdata.deal_depo_chng AS data
			inner join rawdata.deal as deal
		on data.deal_ID = deal.deal_ID
		group by deal.customer_id
	);
run;

/*================================ TRIPLE SELECT*/
proc SQL;
	select 
		deal.customer_ID,
		sum(interest_amt) as interest_sum,
		count (distinct data.deal_ID) as deal_Count
	from		
		rawdata.deal_depo_chng AS data
		inner join rawdata.deal as deal
	on data.deal_ID = deal.deal_ID
	group by deal.customer_id
	having deal_count = (
		select 
			max(deal_count) as max_count
		from(
			select 
				count (distinct data.deal_ID) as deal_Count
			from		
				rawdata.deal_depo_chng AS data
				inner join rawdata.deal as deal
			on data.deal_ID = deal.deal_ID
			group by deal.customer_id
		)
	);
run;

/*================================ SELECT INTO*/
proc sql;
	select 
		max(deal_count) as max_count
		into :MAXCOUNT
	from(
		select 
			count (distinct data.deal_ID) as deal_Count
		from		
			rawdata.deal_depo_chng AS data
			inner join rawdata.deal as deal
		on data.deal_ID = deal.deal_ID
		group by deal.customer_id
	);

	select 
		deal.customer_ID,
		sum(interest_amt) as interest_sum,
		count (distinct data.deal_ID) as deal_Count
	from		
		rawdata.deal_depo_chng AS data
		inner join rawdata.deal as deal
	on data.deal_ID = deal.deal_ID
	group by deal.customer_id
	having deal_count = &MAXCOUNT;
run;

/*================================ LIKE*/
proc SQL;
	select 
		deal.customer_id,
		max (cust.customer_nm) as customer_nm,
		sum(interest_amt) as interest_sum,
		count (distinct data.deal_ID) as deal_Count
	from rawdata.deal_depo_chng AS data
	inner join rawdata.deal as deal
		on data.deal_ID = deal.deal_ID
	inner join rawdata.customer as cust
		on deal.customer_id = cust.customer_id 
	where customer_nm like 'A%'
		or customer_nm like '%d'
	group by deal.customer_id
	order by customer_nm;
run;

/*================================ FORMATTED*/
proc SQL;
	create table CUSTOMERS as
	select 
		deal.customer_id label='Customer ID',
		max (cust.customer_nm) as customer_nm label='Customer Name',
		sum(interest_amt) as interest_sum format = dollar8. label = 'Total AMT by customer',
		count (distinct data.deal_ID) as deal_Count label = 'Deal count' 
	from rawdata.deal_depo_chng AS data
	inner join rawdata.deal as deal
		on data.deal_ID = deal.deal_ID
	inner join rawdata.customer as cust
		on deal.customer_id = cust.customer_id 
	where customer_nm like 'A%'
		or customer_nm like '%d'
	group by deal.customer_id
	order by customer_nm;
run;

proc print data= CUSTOMERS label;


/*================================ UNION*/
proc SQL;
	select 
		1 as tp,
		deal.customer_id,
		max (cust.customer_nm) as customer_nm,
		sum(interest_amt) as interest_sum,
		count (distinct data.deal_ID) as deal_Count
	from rawdata.deal_depo_chng AS data
	inner join rawdata.deal as deal
		on data.deal_ID = deal.deal_ID
	inner join rawdata.customer as cust
		on deal.customer_id = cust.customer_id 
	where customer_nm like 'A%'
	group by deal.customer_id
	UNION
	select 
		2 as tp,
		deal.customer_id,
		max (cust.customer_nm) as customer_nm,
		sum(interest_amt) as interest_sum,
		count (distinct data.deal_ID) as deal_Count
	from rawdata.deal_depo_chng AS data
	inner join rawdata.deal as deal
		on data.deal_ID = deal.deal_ID
	inner join rawdata.customer as cust
		on deal.customer_id = cust.customer_id 
	where customer_nm like '%d'
	group by deal.customer_id;
run;