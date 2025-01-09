-- Calcular:
-- Quais pedidos tiveram;
-- Quantos produtos únicos dentro do mesmo pedido?
-- Quantidade de peças vendidas por produto no total?
-- Qual é o valor total vendido por produto?

SELECT 
	DISTINCT order_id,
	COUNT(order_id) OVER (PARTITION BY order_id) AS total_unique_product,
	SUM(quantity) OVER (PARTITION BY order_id) AS total_product_sales,
	SUM(unit_price * quantity) OVER (PARTITION BY order_id) AS total_sales

FROM order_details
ORDER bY order_id;