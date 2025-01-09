-- Quais são os valores mínimo, máximo e médio de frete pago por cada cliente? (tabela orders)

SELECT
	DISTINCT customer_id,
	MIN(freight) OVER (PARTITION BY customer_id) AS frete_minimo,
	MAX(freight) OVER (PARTITION BY customer_id) AS frete_maximo,
	AVG(freight) OVER (PARTITION BY customer_id) AS frete_medio
FROM orders
ORDER BY customer_id;