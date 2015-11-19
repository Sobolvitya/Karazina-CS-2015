%let datapath = ~/my_content/Fall/Rawdata;
libname rawdata "&datapath";


proc SQL;
	create view rawdata as
	select 
		customer.customer_id,
		customer.valid_start_dttm as customer_start_dttm,
		customer.valid_end_dttm as customer_end_dttm,
		customer.customer_nm,
		customer.birth_dt,
		customer.passport_no,
		customer.death_dt,
		deal.deal_id,
		deal.valid_start_dttm as deal_start_dttm,
		deal.valid_end_dttm as deal_end_dttm,
		deal.open_deal_dt,
		deal.close_deal_dt,
/*		deal.internal_org_id,*/
		product.product_id,
		product.product_type_cd,
		product.product_cd,
		product.product_nm,
		product.currency_cd,
		product.int_rt as product_inr_rt,
		product.min_amt as product_min_amt,
		data.valid_start_dttm as data_start_dttm,
		data.valid_end_dttm as data_end_dttm,
		data.amt,
		data.open_amt,
		data.interest_amt
	from rawdata.deal_depo_chng AS data
	inner join rawdata.deal as deal
		on data.deal_ID = deal.deal_ID
	inner join rawdata.customer as customer
		on deal.customer_id = customer.customer_id
	inner join rawdata.product as product
		on deal.product_id = product.product_id;

	create view rawdata_short as
	select 
		customer_id,
		deal_id,
		customer_nm label='Customer Name',
		open_deal_dt label='Deal Start Date',
		close_deal_dt label='Deal Close Date',
		product_type_cd label='Product Type',
		product_cd label='Product Name',
		product_nm label='Product Name Full',
		currency_cd label='Currency',
		data_start_dttm label='Operation Start Date' ,
		data_end_dttm label='Operation End Date',
		amt label='Amount',
		open_amt label='Start Amount',
		interest_amt label='Interest'
	from rawdata;
run;
