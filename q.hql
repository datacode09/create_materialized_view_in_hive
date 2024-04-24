CREATE MATERIALIZED VIEW IF NOT EXISTS mydb.sales_summary
  COMMENT 'Summary of sales by product and store'
  PARTITIONED ON (store_id)
  SORTED ON (sale_date)
  STORED AS ORC
  LOCATION '/user/hive/materialized_views/sales_summary'
  TBLPROPERTIES ('orc.compress' = 'SNAPPY')
AS
SELECT product_id, store_id, SUM(sales_amount) AS total_sales, COUNT(*) AS transaction_count, MAX(sale_date) AS last_sale_date
FROM sales
GROUP BY product_id, store_id;
