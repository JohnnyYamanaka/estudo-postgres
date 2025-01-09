-- Classificação dos produtos mais vendidos

SELECT
	DISTINCT p.product_id,
	p.product_name,
	(o.unit_price * o.quantity) AS total_vendas,
	ROW_NUMBER() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_rn,
	RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_rank,
	DENSE_RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_dense
FROM
	order_details o
JOIN
	products p ON p.product_id = o.product_id
ORDER BY (o.unit_price * o.quantity) DESC