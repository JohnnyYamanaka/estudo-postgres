-- 1. Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)

SELECT 
	o.order_id,
	o.customer_id,
	c.company_name,
	o.order_date,
	o.required_date,
	o.shipped_date,
	o.ship_city,
	o.ship_country,
	o.ship_postal_code,
	o.ship_region,
	o.ship_via
	
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE date_part('year', o.order_date) = 1996;